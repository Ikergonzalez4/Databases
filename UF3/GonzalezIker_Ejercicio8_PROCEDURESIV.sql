use mymovies;

DELIMITER XX
DROP PROCEDURE IF EXISTS exportOrderDetailsPerCountry XX
CREATE PROCEDURE exportOrderDetailsPerCountry()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE curCountries CURSOR FOR SELECT DISTINCT Country FROM customers;
    DECLARE curOrders CURSOR FOR 
        SELECT o.OrderID, o.OrderDate, od.ProductID, p.ProductName, od.Quantity, od.UnitPrice, 
        (od.Quantity * od.UnitPrice) AS TotalPrice
        FROM orders o 
        JOIN customers c ON o.CustomerID = c.CustomerID 
        JOIN order_details od ON o.OrderID = od.OrderID 
        JOIN products p ON od.ProductID = p.ProductID 
        WHERE c.Country = @currentCountry;
    DECLARE currentCountry VARCHAR(50);
    DECLARE fileName VARCHAR(100);

    OPEN curCountries;

    read_loop: LOOP
        FETCH curCountries INTO currentCountry;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET fileName = CONCAT(currentCountry, '_OrderDetailsResum.csv');
        SET @sql = CONCAT(
            "SELECT c.CompanyName, o.OrderID, o.OrderDate, p.ProductName, SUM(od.Quantity) AS TotalQuantity, SUM(od.UnitPrice * od.Quantity) AS TotalPrice ",
            "INTO OUTFILE '", fileName, "' ",
            "FIELDS TERMINATED BY ',' ",
            "ENCLOSED BY '\"' ",
            "LINES TERMINATED BY '\n' ",
            "FROM orders o ",
            "JOIN customers c ON o.CustomerID = c.CustomerID ",
            "JOIN order_details od ON o.OrderID = od.OrderID ",
            "JOIN products p ON od.ProductID = p.ProductID ",
            "WHERE c.Country = '", currentCountry, "' ",
            "GROUP BY c.CompanyName, o.OrderID, o.OrderDate, p.ProductName "
        );

        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE curCountries;
END XX
DELIMITER ;

CALL exportOrderDetailsPerCountry();



