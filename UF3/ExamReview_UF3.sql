/*APUNTES UF3*/

-- IMPORTS

load data infile '/ruta/fichero.csv' -- ruta donde quieres que vaya el fichero 
into table product -- tabla en la que se quiere inserir
fields terminated by ',' -- como estaran separados los campos del fichero csv 
enclosed by '"' -- como estan encapsulados los campos
lines terminated by '\n' -- lineas terminadas en nuevos caracteres 
ignore 1 rows; -- ignorar 1 linea 

-- EXPORTS 

select * from products where stock < 10  -- consutla 
into outfile '/ruta/fichero.csv' -- ruta donde quieres que vaya el fichero 
fields terminated by ';'  -- como estaran separados los campos del fichero csv 
enclosed by '"' -- como estan encapsulados los campos
lines terminated by '\n'; -- lineas terminadas en nuevos caracteres

-- CREATE LIKE 
/*El comando CREATE LIKE se usa para crear una tabla copiando la estructura de
columnas de otra tabla ya existente. No copia las FKs pero sí la PK de la tabla de
origen*/

-- CREATE TABLE <tabla_a_crear> LIKE <tabla_de_origen>;ç
CREATE TABLE bkp_alumno LIKE alumno;

-- CREATE AS SELECT 
/*La instrucción CREATE as SELECT nos permite crear una tabla nueva copiando
la estructura y también los datos de otra table ya existente. Notar que ésta
operación no copia las FKs ni la PK en la tabla nueva.*/

/*CREATE TABLE <tabla_a_crear> AS SELECT <columnas>
FROM <tabla_de_origen>
WHERE <condiciones>;*/
CREATE TABLE Products_bck as SELECT * FROM Products;

-- INSERT INTO SELECT 
/*El comando INSERT INTO SELECT se usa para insertar información a una tabla
a partir de una selección hecha a otra u otras tablas.
*/
-- INSERT INTO <tabla> SELECT <atributos> FROM <tabla_con_datos>
INSERT INTO bkp_alumno SELECT * FROM alumno;
INSERT INTO bkp_alumno SELECT * FROM lsonline.alumno
WHERE es_mayor IS TRUE;

SELECT * FROM information_schema.tables; -- information schema sirve para saber todas las bases de datos y todas las tablas del sistema 

SELECT table_name FROM information_schema.tables
WHERE table_schema = "lsonline"
AND table_type = "base table";

-- STORED PROCEDURES

-- STORED PROCEDURE SIN PARAMETROS DE ENTRADA

use nothwind; -- tendremos que usar una base de datos donde almacenaras los procedures

DELIMITER XX  
DROP PROCEDURE IF EXISTS student_info XX 
CREATE PROCEDURE student_info()
BEGIN 
	select * from student ;  	
END XX 
DELIMITER ;

CALL northwind.student_info; -- llamada al procedure con el nombre de la base de datos donde esta creado 

-- STORED PROCEDURE CON PARAMETROS DE ENTRADA

use nothwind;

DELIMITER XX  
DROP PROCEDURE IF EXISTS getUserById XX 
CREATE PROCEDURE getUserById(IN ID VARCHAR(5)) -- parametro de entrada ID tipo varchar 
BEGIN 
	SELECT * FROM usuarios WHERE usuario = ID; 	
END XX 
DELIMITER ;

CALL northwind.getUserById('15'); -- llamada al procedure con el parametro de entrada 'ID' 15

-- STORED PROCEDURE CON PARAMETROS DE SALIDA

use nothwind;

DELIMITER XX
DROP PROCEDURE IF EXISTS spGetAverageMarks XX
CREATE PROCEDURE spGetAverageMarks(OUT average DECIMAL(5,2)) -- parametro de salida tipo decimal 
BEGIN
    SELECT AVG(total_marks) INTO average FROM studentMarks;
END XX
DELIMITER ;

CALL northwind.spGetAverageMarks(@average_marks); -- en los procedure con parametro de salida hay que usar @ para la variable de salida

-- STORED PROCEDURE CON PARAMETROS INOUT

use northwind;

DELIMITER XX
DROP PROCEDURE IF EXISTS spUpdateCounter XX 
CREATE PROCEDURE spUpdateCounter(INOUT counter INT, IN increment INT) -- parametro inout es un parametro que junta los dos 
BEGIN
    SET counter = counter + increment;
END XX
DELIMITER ;

SET @counter=10;
CALL northwind.spUpdateCounter(@counter,3); -- el counter estamos estableciento que es 10 y el incremento es de 
-- 10 por lo que sera 13 el resultado de counter al ejecutar el procedure 
 
 -- STORED PROCEDURE CON PARAMETROS DE ENTRADA Y DE SALIDA 
 
 use northwind;
 
DELIMITER XX
DROP PROCEDURE IF EXISTS spCountOfBelowAverage XX
CREATE PROCEDURE spCountOfBelowAverage(OUT countBelowAverage INT)
BEGIN
    DECLARE avgMarks DECIMAL(5,2) DEFAULT 0;
    SELECT AVG(total_marks) INTO avgMarks FROM studentMarks;
    SELECT COUNT(*) INTO countBelowAverage FROM studentMarks WHERE total_marks < avgMarks;
END XX
DELIMITER ;

CALL northwind.spCountOfBelowAverage(@countBelowAverage); 

/*---- CONDICIONALES ----*/

-- IF 

/* 
IF condicion THEN sentencias_a_ejecutar;
[ELSEIF condicion THEN sentencias_a_ejecutar;] ...
[ELSE sentencias_a_ejecutar;]
END IF;
*/

DELIMITER XX
DROP PROCEDURE IF EXISTS calculo XX
CREATE PROCEDURE calculo(IN param1 INTEGER)
BEGIN
DECLARE var1 CHAR(10);
	IF param1=1 THEN
		SELECT ‘opcion_if’;
		SET var1 = ‘opcion_if’;
		ELSE
		SELECT ‘opcion_else’;
		SET var1 = ‘opcion_else’;
	END IF;
INSERT INTO table1 VALUES (var1);

END XX
DELIMITER ;

-- CASE 

/* 
CASE variable_de_condicion
WHEN condicion THEN sentencias_a_ejecutar;
[WHEN condicion THEN sentencias_a_ejecutar;] ...
[ELSE sentencias_a_ejecutar;]
END CASE; 	
*/

DELIMITER XX
DROP PROCEDURE IF EXISTS calculo2 XX
CREATE PROCEDURE calculo2(IN param1 INTEGER)
BEGIN
	CASE param1
		WHEN 1 THEN
		SELECT ‘opcion_1’;
		WHEN 2 THEN
		SELECT ‘opcion_2’;
		WHEN 3 THEN
		SELECT ‘opcion_3’;
		ELSE SELECT ‘ninguna_opcion’;
	END CASE;
END XX
DELIMITER ;

-- WHILE 


/*
[etiqueta :] WHILE condicion DO
sentencias_a_ejecutar;
END WHILE [etiqueta] ;
*/

DELIMITER XX
DROP PROCEDURE IF EXISTS calculo3 XX
CREATE PROCEDURE calculo3()
BEGIN
DECLARE var1 INTEGER DEFAULT 5;
	WHILE var1>0 DO
		SELECT var1;
		SET var1=var1-1;
	END WHILE;
END XX
DELIMITER ;

-- LOOP 

/*
etiqueta: LOOP
//posible cuerpo del loop-1
IF done=1 THEN
LEAVE etiqueta;
END IF;
//posible cuerpo del loop-2
END LOOP etiqueta;
*/

DELIMITER XX
DROP PROCEDURE IF EXISTS calculo4 XX
CREATE PROCEDURE calculo4()
BEGIN
	DECLARE incremento;
	SET incremento = 0;
	label4: LOOP
		SET incremento = incremento + 1;
		IF incremento > 10 THEN
			LEAVE label4;
		END IF;
	END LOOP label4;
END XX
DELIMITER ;


/*---- CURSORES Y HANDLERS ----


-- DECLARE 

DECLARE nombre_cursor CURSOR FOR instruccion_select -- crea el cursor 

-- OPEN 

OPEN nombre_cursor -- abre el cursor

-- FETCH

FETCH [[NEXT] FROM ] nombre_cursor
	INTO nombre_var [,nombre_var] ... -- Obtiene cada una de las filas del resultado secuencialmente, cuando se estan
    -- recorriendo filas y no quedan se lanza el error NOT FOUND 
    
-- CLOSE

CLOSE nombre_cursor -- cierra el cursor 

-- HANDLER 

-- Cuando no quedann registros y va a salir el error NOT FOUND se soluciona con un handler

DECLARE done INT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; -- lo que hace es coger el error y continuar la ejecucion 	
	IF done THEN 
		LEAVE nombre_loop;
	END IF;/*
    
/*---- EVENTS --- */ 

SET GLOBAL event_scheduler = ON; -- activar scheduler para crear eventos 

CREATE EVENT insertar_usuario 
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO INSERT INTO usuarios(nombre, apellidos, username, email) VALUES('Codigo 4 test', 'Facilito', 'codigofacilito', 'ikergcAK@gmail.com');

SHOW EVENTS; -- mostrar todos los eventos creados 

/* ---- TRIGGERS ---- */ -- INSERT -- DELETE -- UPDATE -- SIEMPRE TIENE QUE TENER UNO PEGADO DE BEFORE O AFTER 


-- NEW - AFTER (Se ejecuta el trigger despues de modificar la tabla) 

DELIMITER // 
CREATE TRIGGER log_alumnos 
AFTER INSERT ON alumno -- este trigger lo que hace es un registro de la fecha cuando se crea un nuevo usuario 
FOR EACH ROW 
BEGIN
	INSERT INTO acciones (accion) 
    VALUE (CONCAT('Se ha creado un registro en alumno con nombre: ', NEW.nombre, ' con id: ', NEW.id )); 
END // 
DELIMITER ;

-- NEW/OLD - BEFORE (Se ejecuta el trigger antes de modificar la tabla) 

DELIMITER //  
CREATE TRIGGER actualizar_precio
BEFORE UPDATE ON producto -- este trigger lo que hace es cojer el coste, multiplicarlo por 2 y asignarselo al precio  
FOR EACH ROW 
BEGIN
	IF NEW.coste <> OLD.coste 
		THEN 
			SET NEW.precio = OLD.coste * 2;
		END IF;
END // 
DELIMITER ;


/*1. Dins de la base dades world, crea un procedure que permeti inserir dades noves 
dins de la taula City.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS insertCity // 
CREATE PROCEDURE insertCity(IN cityName CHAR(35), IN countryCode CHAR(3), IN district CHAR(20), IN population INT(11))
BEGIN
  INSERT INTO City(Name, CountryCode, District, Population) -- vamos a insertar en los campos: 
  VALUES(cityName, countryCode, district, population); -- los valores especificados en el metodo call 
END//
DELIMITER ;

CALL insertCity('New York', 'USA', 'New York', 8537673); -- cityName: New York countryCode: USA district: New York population: 8537673

select ID from city;
show create table city;

/*2. A la BD World, crea un procediment que donada una ciutat,
retorni el recompte dels seus habitants per pantalla juntament amb el seu país.*/

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS getCityPopulation // 
CREATE PROCEDURE getCityPopulation(IN cityName VARCHAR(35))
BEGIN
  DECLARE cityPopulation INT; -- se declaran las variables locales 
  DECLARE countryCode CHAR(3);
  DECLARE countryName VARCHAR(50);
  
  SELECT Population, CountryCode INTO cityPopulation, countryCode FROM city WHERE `Name` = cityName;
  -- Population variable de world y CountryCode INTO cityPopulation, countryCode (variables locales) 
  
  SELECT `Name` INTO countryName FROM country WHERE `Code` = countryCode;
  -- Name variable de world  INTO countryName (variable local) 
  
  SELECT CONCAT(cityName, ' is located in ', countryName, ' and has a population of ', cityPopulation) AS Resultado;
  -- crear cadena de texto del cityName, countryName y cityPopulation junto a texto 
  
END // 
DELIMITER ;

CALL world.getCityPopulation('Kabul'); -- buscamos por cityName 

select * from country; 
SELECT * FROM city WHERE Name = 'Kabul';

/*3. A la BD northwind, crea el procediment calcIVA a la base de dades de procediments que donats 2 paràmetres 
d'entrada FLOAT (preu i iva) i un de sortida amb el preu final incrementat amb l'¡mpost.
Fés un CALL amb una variable no declarada.*/

use northwind;
DELIMITER // 
DROP PROCEDURE IF EXISTS calcIVA // 
CREATE PROCEDURE calcIVA(IN iva FLOAT, IN precio FLOAT, OUT precio_final FLOAT) 
BEGIN
	SET precio_final = precio * iva; -- multiplicamos el precio * iva y le asignamos el valor a precio_final 
END //
DELIMITER ;

SET @precio_final = 0; -- establecemos que precio_final es 0 
CALL calcIVA(100, 1.2, @precio_final); -- la variable precio_final como es de salida va con @ 
SELECT @precio_final;

/*4. A la BD World, Crea un procediment que donada una llengua,
guardi en un fitxer els països que la parlen. */

DELIMITER //
DROP PROCEDURE IF EXISTS countriesByLanguage // 
CREATE PROCEDURE countriesByLanguage(IN language VARCHAR(50))
BEGIN
  SELECT DISTINCT c.Name
  FROM country c
  JOIN countrylanguage cl ON c.Code = cl.CountryCode
  WHERE cl.Language = language
  INTO OUTFILE 'C:/Users/ikerg/Desktop/SQL/countriesByLanguage_Spanish.txt';
END//
DELIMITER ;

CALL countriesByLanguage('Spanish');

select * from countrylanguage;


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

/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage.
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS export_countrylanguage // 
CREATE PROCEDURE export_countrylanguage(IN file_name VARCHAR(255))
BEGIN
	SELECT * FROM CountryLanguage INTO OUTFILE 'file_name';
END //
DELIMITER ;


CALL world.export_countrylanguage('fitxer.csv');

/*8. Crea un procedure que faci backup de totes les taules de la BD world
incloent les dades. El nom de les taules noves ha d'incloure "_YYYYMMDD" amb la data del dia actual.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS backup_world_tables;
CREATE PROCEDURE backup_world_tables()
BEGIN
    DECLARE table_name VARCHAR(255);
    DECLARE backup_table_name VARCHAR(255);
    DECLARE today DATE;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_schema = 'world' AND table_type = 'BASE TABLE';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET today = CURRENT_DATE();
    
    OPEN cur;
    tables_loop: LOOP
        FETCH cur INTO table_name;
        IF done THEN
            LEAVE tables_loop;
        END IF;
        
        SET backup_table_name = CONCAT(table_name, '_', DATE_FORMAT(today, '%Y%m%d'));
        
        SET @sql = CONCAT('CREATE TABLE ', backup_table_name, ' LIKE ', table_name);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        SET @sql = CONCAT('INSERT INTO ', backup_table_name, ' SELECT * FROM ', table_name);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

CALL backup_world_tables();

/*9. Usant PL/SQL desenvolupeu una calculadora usant CASE i IF.
En una base de dades qualsevol, crear un procedure amb 4 paràmetres de tipus FLOAT: (IN pNum1, IN pNum2, IN pOperacio, OUT pResultat).
Segons el valor de la pOperacio (+, -, *, /) el procedure farà una acció o una altra i retornarà la variable resultat.
Heu d'evitar que el programa falli al fer una divisió per 0. Mostra ERROR i retorna el valor -1.*/


use world; 

DELIMITER // 
DROP PROCEDURE IF EXISTS calc // 
CREATE PROCEDURE calc(IN pNum1 FLOAT, IN pNum2 FLOAT, IN pOperacio char(1), OUT pResultat FLOAT) 
BEGIN
SET pResultat = 0;
	CASE pOperacio
		WHEN '+' THEN 	
			SET pResultat = pNum1 + pNum2;
		WHEN '-' THEN
			SET pResultat = pNum1 - pNum2;
		WHEN '*' THEN
			SET pResultat = pNum1 * pNum2;
		WHEN '/' THEN
            IF pNum2 != 0 THEN
				SET pResultat = pNum1 / pNum2;
			ELSE
                SELECT 'ERROR' INTO pResultat;
			END IF;
		ELSE SELECT 'INVALID OPERATION' INTO pResultat;
	END CASE;
END // 
DELIMITER ;

CALL calc(10, 5, '*', @result);
SELECT @result;


/*10. Exercicis de loops i for's: A la BD northwind, fer un bucle que recorri tota la taula Categories 
i busqui si hi ha una categoria de nom "Seafood". (fer servir la BBDD Northwind) fer sense cursors)
Passos marcats:

a) Fer loop de 1 a 10 o amb núm total de categories
b) Buscar nom categoria on l'id = contador de loop
c) Verificar si la la categoria = seafood
d) En cas afirmatiu, mostrar missatge, sinó seguir buscant*/

use northwind;

DELIMITER //
DROP PROCEDURE IF EXISTS find_seafood_category //
CREATE PROCEDURE find_seafood_category (OUT category_id INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total_categories INT DEFAULT (SELECT COUNT(*) FROM categories);
    SET category_id = -1;
    
    label1: LOOP
        IF i > total_categories THEN
            LEAVE label1;
        END IF;
        
        IF (SELECT CategoryName FROM categories WHERE CategoryID = i) = 'Seafood' THEN
            SET category_id = i;
            SELECT CONCAT('Seafood category found at CategoryID ', i) AS message;
            LEAVE label1;
        END IF;
        
        SET i = i + 1;
    END LOOP label1;
END //
DELIMITER ;

SET @result = -1;
CALL find_seafood_category(@result);
SELECT @result AS category_id;


/* ==== PROCEDURES III ==== */

/*1. A la BD Sakila creeu un procediment anomenat insertMyself que rebi els paràmetres d'entrada:
nom VARCHAR(45), cognom VARCHAR(45), data TIMESTAMP i x INT.

Aquest procediment inserirà x vegades l'actor amb nom i cognom dins de la taula Sakila.actor.
Com que actor_id és INT AUTOINCREMENTAL, no hem d'especificar el seu valor. És a dir, usarem un insert indirecte.*/

use sakila;

DELIMITER // 
DROP PROCEDURE IF EXISTS insertMyself // 
CREATE PROCEDURE insertMyself(IN p_nom VARCHAR(45), IN p_cognom VARCHAR(45), IN p_data TIMESTAMP, IN p_x INT)
BEGIN
  DECLARE i INT DEFAULT 0; -- variable para el loop declarada en 0 
  
  WHILE i < p_x DO -- itera desde i(0) hasta p_x(numero que le ponemos en el call)
    INSERT INTO Sakila.actor (first_name, last_name, last_update) -- inserta en 
    VALUES (p_nom, p_cognom, p_data); -- los valores que pondremos en el call 
    SET i = i + 1; -- suma uno a i para seguir iterando 
  END WHILE; -- cierre del loop whiñe 
END;
DELIMITER ;

CALL insertMyself('John', 'Doe', NOW(), 5); -- first_name: John last_name: Doe p_data: Now() numero de iteracion: 5

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

/*3. A la BD northwind, crea el procediment calcIVA a la base de dades de procediments que donats 2 paràmetres d'entrada FLOAT 
(preu i iva) i un de sortida amb el preu final incrementat amb l'¡mpost.
Fés un CALL amb una variable no declarada.*/

use northwind;

DELIMITER // 
DROP PROCEDURE IF EXISTS calcIVA // 
CREATE PROCEDURE calcIVA(IN cost FLOAT, IN iva FLOAT, OUT finalCost FLOAT) 
BEGIN
	SET finalCost = cost * iva;
END // 
DELIMITER ;

SET @finalCost = 0;
CALL northwind.calcIVA(10,2,@finalCost);
SELECT @finalCost;

/*4. A la BD World, Crea un procediment que donada una llengua,
guardi en un fitxer els països que la parlen. */

use world;

DELIMITER // 
DROP PROCEDURE IF EXISTS exportLanguages // 
CREATE PROCEDURE exportLanguages(IN lang CHAR(30)) 
BEGIN
	DECLARE countries_list VARCHAR(500); -- se decara una lista que sera lo que exportemos y donde se guarde la consulta select
    
    SELECT GROUP_CONCAT(DISTINCT c.Name SEPARATOR '\n') INTO countries_list -- introducimos el select en la variable creada
    FROM countrylanguage cl
    INNER JOIN country c ON cl.CountryCode = c.Code 
    WHERE cl.Language = lang AND cl.IsOfficial = 'T';
    
    SELECT countries_list INTO OUTFILE 'C:/Users/ikerg/Desktop/paises2.txt'; -- hacemos el export hacia el fichero paises2.txt
END // 
DELIMITER ;

CALL exportLanguages('Spanish');

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

/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage.
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/

use world;

DELIMITER //
DROP PROCEDURE IF EXISTS exportCountryLanguage // 
CREATE PROCEDURE exportCountryLanguage(IN filename VARCHAR(100))
BEGIN
   SET @sql = CONCAT("SELECT * INTO OUTFILE '", filename, "' ",
                     "FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ",
                     "LINES TERMINATED BY '\n' FROM CountryLanguage");
   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL exportCountryLanguage('C:/Users/ikerg/Desktop/countrylanguage.csv');

    
