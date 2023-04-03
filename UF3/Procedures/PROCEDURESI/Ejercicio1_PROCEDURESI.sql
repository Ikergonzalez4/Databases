/*1. Dins de la base dades world, crea un procedure que permeti inserir dades noves 
dins de la taula City.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS insertCity // 
CREATE PROCEDURE insertCity(
  IN cityName CHAR(35),
  IN countryCode CHAR(3),
  IN district CHAR(20),
  IN population INT(11)
)
BEGIN
  INSERT INTO City(Name, CountryCode, District, Population)
  VALUES(cityName, countryCode, district, population);
END//
DELIMITER ;

CALL insertCity('New York', 'USA', 'New York', 8537673);

select ID from city;
show create table city;