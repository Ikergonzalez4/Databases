/*4. Dins de la base dades world, crea un procedure que permeti inserir dades noves dins de la taula City*/

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS insertCity // 
CREATE PROCEDURE insertCity(IN vName CHAR(35), IN vCountryCode CHAR(3), IN vDistrict CHAR(20), IN vPopulation INT)
BEGIN
  INSERT INTO City (Name, CountryCode, District, Population) VALUES (vName, vCountryCode, vDistrict, vPopulation);
END //
DELIMITER ;

CALL insertCity('Barcelona', 'ESP', 'Catalunya', 1620343);
select * from city;

