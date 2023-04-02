USE northwind;

DELIMITER XX
DROP PROCEDURE IF EXISTS mostrar_shippers_un_per_un XX
CREATE PROCEDURE mostrar_shippers_un_per_un()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE ShipperID INT;
    DECLARE CompanyName VARCHAR(40);
    DECLARE Phone VARCHAR(24);
    DECLARE shippers_cursor CURSOR FOR 
        SELECT ShipperID, CompanyName, Phone FROM Shippers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN shippers_cursor;
    
    shipper_loop: LOOP
        FETCH shippers_cursor INTO ShipperID, CompanyName, Phone;
        IF done THEN
            LEAVE shipper_loop;
        END IF;
        
        SELECT CONCAT('ShipperID: ', ShipperID) AS 'ShipperID',
               CONCAT('CompanyName: ', CompanyName) AS 'CompanyName',
               CONCAT('Phone: ', Phone) AS 'Phone';
    END LOOP;

    CLOSE shippers_cursor;
END XX
DELIMITER ;

call northwind.mostrar_shippers_un_per_un();
