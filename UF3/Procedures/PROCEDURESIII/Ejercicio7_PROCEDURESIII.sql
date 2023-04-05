/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage.
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS exportCountryLanguage // 
CREATE PROCEDURE exportCountryLanguage(IN filename VARCHAR(100))
BEGIN
   SET @sql = CONCAT("SELECT * INTO OUTFILE '", filename, "' ",
                     "FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ",
                     "LINES TERMINATED BY '\n' FROM CountryLanguage");
   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL exportCountryLanguage('C:/Users/ikerg/Desktop/countrylanguage.csv');
