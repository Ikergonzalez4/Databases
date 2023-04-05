/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que té. 
Aquests dos valors també s'han de passar com a paràmetres de sortida */

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS idCountry // 
CREATE PROCEDURE idCountry(IN idCountry INT, OUT numLanguages INT, OUT numCities INT) 
BEGIN
	SELECT COUNT(DISTINCT Language) INTO numLanguages FROM countrylanguage WHERE CountryCode = idCountry;
    SELECT COUNT(*) INTO numCities FROM city WHERE CountryCode = idCountry;
END // 
DELIMITER ;

CALL idCountry('ESP', @numLanguages, @numCities);
SELECT @numLanguages, @numCities;
