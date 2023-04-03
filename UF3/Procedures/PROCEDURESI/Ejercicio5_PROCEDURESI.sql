
/*5. També a la BD World, modifica l'exercici anterior per fer que el nom del fitxer
resultant sigui: NOM_LLENGUA.txt on NOM_LLENGUA òbviament s'adapta al valor de a llengua passada per paràmetre, no en text literal.*/

DELIMITER //
CREATE PROCEDURE getLanguageCountries(IN langName VARCHAR(50))
BEGIN
  DECLARE langCountries VARCHAR(1000);
  SELECT GROUP_CONCAT(DISTINCT country.`Name` ORDER BY country.`Name` ASC SEPARATOR ', ') 
  INTO langCountries
  FROM countrylanguage 
  JOIN country ON country.Code = countrylanguage.CountryCode 
  WHERE countrylanguage.Language = langName;
  
  SET @filename = CONCAT(langName, '.txt');
  SET @query = CONCAT('SELECT "', langCountries, '" INTO OUTFILE "', @filename, '"');
  
  PREPARE statement FROM @query;
  EXECUTE statement;
  DEALLOCATE PREPARE statement;
END //
DELIMITER ;

CALL getLanguageCountries('Spanish');


