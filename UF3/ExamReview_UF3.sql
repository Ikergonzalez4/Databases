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

-- NSERT INTO <tabla> SELECT <atributos> FROM <tabla_con_datos>
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
