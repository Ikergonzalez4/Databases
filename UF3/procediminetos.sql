-- 3 Crear un procedimiento que calcule el iva 

use northwind;

DELIMITER XX 

DROP PROCEDURE IF EXISTS precioIva; XX

CREATE PROCEDURE precioIva(IN UnitPrice DOUBLE, IN iva DOUBLE, OUT final DOUBLE) 
BEGIN
    SET final = (UnitPrice * iva);
END XX 

DELIMITER ;

CALL northwind.precioIva (100, 1.21, @pvp);

SELECT @pvp;

-- 4 crear un procedimiento que depende el idioma guarde un fichero de los paises que lo hablan 

use world;

DELIMITER XX 

DROP PROCEDURE IF EXISTS guardarPaisesPorIdioma; XX

CREATE PROCEDURE guardarPaisesPorIdioma(IN idioma VARCHAR(50))
BEGIN
    SELECT DISTINCT c.name, c.Continent, c.Region
    FROM country c
    INNER JOIN countrylanguage cl ON c.Code = cl.CountryCode
    WHERE cl.language = idioma 
    INTO OUTFILE 'C:/xampp/mysql/data/archivoidiomas.csv' 
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n';
END XX

DELIMITER ;

call world.guardarPaisesPorIdioma('Spanish');
