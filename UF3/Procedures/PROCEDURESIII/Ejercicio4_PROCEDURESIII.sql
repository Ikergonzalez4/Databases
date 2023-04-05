/*4. A la BD World, Crea un procediment que donada una llengua,
guardi en un fitxer els països que la parlen. */

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS exportLanguages // 
CREATE PROCEDURE exportLanguages(IN lang CHAR(30)) 
BEGIN
	DECLARE countries_list VARCHAR(500); 
    
    SELECT GROUP_CONCAT(DISTINCT c.Name SEPARATOR '\n') INTO countries_list
    FROM countrylanguage cl
    INNER JOIN country c ON cl.CountryCode = c.Code
    WHERE cl.Language = lang AND cl.IsOfficial = 'T';
    
    SELECT countries_list INTO OUTFILE 'C:/Users/ikerg/Desktop/paises2.txt';
END // 
DELIMITER ;

CALL exportLanguages('Spanish');
