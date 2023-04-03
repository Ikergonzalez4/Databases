/*2. A la BD World, crea un procediment que donada una ciutat,
retorni el recompte dels seus habitants per pantalla juntament amb el seu país.*/

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS getCityPopulation // 
CREATE PROCEDURE getCityPopulation(IN cityName VARCHAR(35))
BEGIN
  DECLARE cityPopulation INT;
  DECLARE countryCode CHAR(3);
  DECLARE countryName VARCHAR(50);
  
  SELECT Population, CountryCode INTO cityPopulation, countryCode FROM city WHERE `Name` = cityName;
  
  SELECT `Name` INTO countryName FROM country WHERE `Code` = countryCode;
  
  SELECT CONCAT(cityName, ' is located in ', countryName, ' and has a population of ', cityPopulation) AS Resultado;
END // 
DELIMITER ;

CALL world.getCityPopulation('Kabul');

select * from country; 
SELECT * FROM city WHERE Name = 'Kabul';

