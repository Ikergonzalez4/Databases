/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage.
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS export_countrylanguage // 
CREATE PROCEDURE export_countrylanguage(IN file_name VARCHAR(255))
BEGIN
	SELECT * FROM CountryLanguage INTO OUTFILE 'file_name';
END //
DELIMITER ;


CALL world.export_countrylanguage('fitxer.csv');
