use northwind;

DELIMITER XX

DROP PROCEDURE IF EXISTS backUpOrders XX 
CREATE PROCEDURE backUpOrders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE order_id INT;
    DECLARE customer_id CHAR(5);
    DECLARE employee_id INT;
    DECLARE order_date DATETIME;
    DECLARE required_date DATETIME;
    DECLARE shipped_date DATETIME;
    DECLARE ship_via INT;
    DECLARE freight DOUBLE;
    DECLARE ship_name VARCHAR(40);
    DECLARE ship_address VARCHAR(60);
    DECLARE ship_city VARCHAR(15);
    DECLARE ship_region VARCHAR(15);
    DECLARE ship_postal_code VARCHAR(10);
    DECLARE ship_country VARCHAR(15);
    DECLARE backup_date DATETIME;

    DECLARE cur CURSOR FOR SELECT * FROM orders;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET backup_date = NOW();

        INSERT INTO orders_bck (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, bck_date)
        VALUES (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country, backup_date);
    END LOOP;

    CLOSE cur;
END XX;

DELIMITER ;

/*SHOW CREATE TABLE orders;*/

/*CREATE TABLE orders_bck (
   OrderID int(11) NOT NULL AUTO_INCREMENT,
   CustomerID char(5) DEFAULT NULL,
   EmployeeID int(11) DEFAULT NULL,
   OrderDate datetime DEFAULT NULL,
   RequiredDate datetime DEFAULT NULL,
   ShippedDate datetime DEFAULT NULL,
   ShipVia int(11) DEFAULT NULL,
   Freight double DEFAULT 0,
   ShipName varchar(40) DEFAULT NULL,
   ShipAddress varchar(60) DEFAULT NULL,
   ShipCity varchar(15) DEFAULT NULL,
   ShipRegion varchar(15) DEFAULT NULL,
   ShipPostalCode varchar(10) DEFAULT NULL,
   ShipCountry varchar(15) DEFAULT NULL,
   bck_date datetime,
	PRIMARY KEY (OrderID)
);*/

call northwind.backUpOrders();
