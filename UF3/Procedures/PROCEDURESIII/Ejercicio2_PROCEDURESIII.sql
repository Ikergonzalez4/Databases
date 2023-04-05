/*2. A la BD World, crea un procediment que donada una ciutat,
retorni el recompte dels seus habitants per pantalla juntament amb el seu país.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS `getCityPopulation` //
CREATE PROCEDURE `getCityPopulation`(IN cityName CHAR(35))
BEGIN
   SELECT city.Population, country.Name AS Country
   FROM city
   JOIN country ON city.CountryCode = country.Code
   WHERE city.Name = cityName
   LIMIT 1;
END //
DELIMITER ;


CALL getCityPopulation('Barcelona');

