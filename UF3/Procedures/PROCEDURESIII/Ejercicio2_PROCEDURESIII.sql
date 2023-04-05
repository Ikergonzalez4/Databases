/*2.Aneu a Northwind.
Creeu un procediment que mostri les dades dels shippers per pantalla.*/

use sakila;

DELIMITER //
DROP PROCEDURE IF EXISTS showShippers //
CREATE PROCEDURE showShippers()
BEGIN
  SELECT * FROM customer;
END // 
DELIMITER ;

CALL showShippers();


