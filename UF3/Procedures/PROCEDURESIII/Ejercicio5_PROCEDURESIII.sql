/*5. Crea un procedure que permeti exportar les dades de la 
taula CountryLanguage. El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/

DELIMITER // 
DROP PROCEDURE IF EXISTS exportCountryLanguage // 
CREATE PROCEDURE exportCountryLanguage(IN filename VARCHAR(255))
BEGIN
    SET @sql = CONCAT("SELECT * INTO OUTFILE '", filename, "' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' FROM CountryLanguage");
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END // 
DELIMITER ;


CALL exportCountryLanguage('C:/Users/ikerg/Desktop/exportCountryLanguage.csv');
