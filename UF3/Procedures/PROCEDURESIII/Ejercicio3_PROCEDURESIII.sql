/*3. A la BD northwind, crea el procediment calcIVA a la base de dades de procediments que donats 2 paràmetres d'entrada FLOAT 
(preu i iva) i un de sortida amb el preu final incrementat amb l'¡mpost.
Fés un CALL amb una variable no declarada.*/

use northwind;

DELIMITER // 
DROP PROCEDURE IF EXISTS calcIVA // 
CREATE PROCEDURE calcIVA(IN cost FLOAT, IN iva FLOAT, OUT finalCost FLOAT) 
BEGIN
	SET finalCost = cost * iva;
END // 
DELIMITER ;

SET @finalCost = 0;
CALL northwind.calcIVA(10,2,@finalCost);
SELECT @finalCost;