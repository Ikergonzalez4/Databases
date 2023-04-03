/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que 
té. Aquests dos valors també s'han de passar com a paràmetres de sortida */

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS obtenerCountryInfo // 
CREATE PROCEDURE obtenerCountryInfo (IN countryID CHAR(3), OUT numLanguages INT, OUT numCities INT)
BEGIN 
	SELECT COUNT(*) INTO numLanguages FROM countrylanguage WHERE CountryCode = countryId;
    SELECT COUNT(*) INTO numCities FROM city WHERE CountryCode = countryId;
END // 
DELIMITER ;

CALL obtenerCountryInfo('ESP', @numLanguages, @numCities);
SELECT CONCAT('Spain has ', @numLanguages, ' official languages and ', @numCities, ' cities') AS Resultado;