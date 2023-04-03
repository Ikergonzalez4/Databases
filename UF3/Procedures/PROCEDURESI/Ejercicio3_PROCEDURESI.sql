/*3. A la BD northwind, crea el procediment calcIVA a la base de dades de procediments que donats 2 paràmetres 
d'entrada FLOAT (preu i iva) i un de sortida amb el preu final incrementat amb l'¡mpost.
Fés un CALL amb una variable no declarada.*/

use northwind;
DELIMITER // 
DROP PROCEDURE IF EXISTS calcIVA // 
CREATE PROCEDURE calcIVA(IN iva FLOAT, IN precio FLOAT, OUT precio_final FLOAT) 
BEGIN
	SET precio_final = precio * iva;
END //
DELIMITER ;

SET @precio_final = 0;
CALL calcIVA(100, 1.2, @precio_final);
SELECT @precio_final;