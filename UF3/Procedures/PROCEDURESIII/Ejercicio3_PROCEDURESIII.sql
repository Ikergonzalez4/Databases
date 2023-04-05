/*3.Aneu a la BD Northwind. Mireu la taula customers.
Creeu un nou procediment que comprovi si un CustomerID passat per paràmetre existeix. En cas de que exiteixi, 
que retorni el seu ContactName. Si no existeix que mostri un missatge d'error.
Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).*/

DELIMITER //
DROP PROCEDURE IF EXISTS checkCustomerID //
CREATE PROCEDURE checkCustomerID(IN vCustomerID SMALLINT, OUT vContactName VARCHAR(90))
BEGIN
  SELECT CONCAT(first_name, ' ', last_name) INTO vContactName FROM customer WHERE customer_id = vCustomerID;
  IF vContactName IS NULL THEN
    SELECT 'Error: CustomerID does not exist' AS ErrorMessage;
  END IF;
END //
DELIMITER ;

CALL checkCustomerID(1, @contactName);
SELECT @contactName;
