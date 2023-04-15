CREATE DATABASE if not exists test2
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE test2;

DROP table test2.log;
CREATE TABLE test2.log (
    Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha_dia DATE NOT NULL,
    fecha_hora TIME NOT NULL, 
    nombre VARCHAR(255) NOT NULL,  
    pID VARCHAR(255) NOT NULL,
    mensaje text,
    fin_de_semana boolean
);


DROP TABLE test2.registre;
CREATE TABLE test2.registre (
	Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_fitxer VARCHAR(255) NOT NULL,
    data_hora DATETIME,
    num_filas INT
);

DROP TABLE test2.MD_process;
CREATE TABLE test2.MD_process (
	Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	pID VARCHAR(255) NOT NULL,
	mensaje text
);

DROP TABLE test2.control;
CREATE TABLE test2.control(
	Id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	valor_vell VARCHAR(255),
    valor_nou VARCHAR(255),
    hora_canvi time,
    user_responsable VARCHAR(255)
);

SET GLOBAL local_infile = 1;
GRANT SUPER ON *.* TO 'root'@'localhost';

DELIMITER //
DROP PROCEDURE IF EXISTS e4 //
CREATE PROCEDURE e4()
BEGIN
    -- Declare variables to store the filename and table name
    DECLARE filename VARCHAR(255);
    DECLARE tablename VARCHAR(255);
	DECLARE get_date DATETIME DEFAULT CURRENT_TIMESTAMP;
    DECLARE num_filas INT DEFAULT 0;

    
    -- Set the filename and table name
    SET filename = 'a.csv'; -- Fitxer del dia anterior, sha de canviar
    SET tablename = 'test2.log';
    
    -- Build the LOAD DATA INFILE statement using a prepared statement
	SET @stmt = CONCAT('LOAD DATA INFILE \'C:/Users/ikerg/Desktop/', filename, '\' IGNORE INTO TABLE ', tablename, ' FIELDS TERMINATED BY \';\' OPTIONALLY ENCLOSED BY """" LINES TERMINATED BY \'\n\' (fecha_dia, fecha_hora, nombre, pID, mensaje)');
    
    -- Prepare and execute the statement
    PREPARE stmt FROM @stmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    UPDATE test2.log
    
    SET fin_de_semana = CASE
        WHEN WEEKDAY(fecha_dia) = 5 OR WEEKDAY(fecha_dia) = 6 THEN 1 
        ELSE 0
    END;
        
	INSERT INTO registre(nom_fitxer, data_hora, num_filas) 
		VALUES (filename, get_date, (SELECT MAX(Id) FROM log));
        
END //

DELIMITER ;
call e4();

SELECT * from registre;
select * from log;
delete from log;
delete from registre;

-- 3

DELIMITER //
DROP PROCEDURE IF EXISTS extraccion //
CREATE PROCEDURE extraccion()
BEGIN
	DECLARE fitxero VARCHAR(255);
	DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT * from registre;
	
    SET fitxero = 'file5.csv';
    
    OPEN cur;
        
    set @extraccion = concat('SELECT * INTO OUTFILE "C:/Users/ikerg/Desktop/', 
                    fitxero, '" FIELDS TERMINATED BY "," 
                    OPTIONALLY ENCLOSED BY """" 
                    LINES TERMINATED BY "\n" 
                    FROM registre;');
    
	PREPARE stmt FROM @extraccion;
	EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    CLOSE cur;
    
END //
DELIMITER ;
call extraccion();

-- 4

INSERT INTO md_process (pID, id, mensaje)
SELECT pID, ROW_NUMBER() OVER(ORDER BY pID), mensaje
FROM log
GROUP BY pID;


SELECT * from md_process;
DELETE from md_process;

-- 5


-- 6
DELIMITER //
CREATE TRIGGER modificacio
AFTER INSERT ON test2.md_process
FOR EACH ROW
BEGIN
	 INSERT INTO test2.control (valor_vell, valor_nou, hora_canvi, user_responsable)
    VALUES ();
END;
END //
DELIMITER //

SELECT * from control;
select * from md_process;

-- 7


DELIMITER //
DROP EVENT table_backup //
CREATE EVENT table_backup
ON SCHEDULE
  EVERY 1 day STARTS '2023-04-14 16:22:00'
DO BEGIN
  DECLARE done BOOLEAN DEFAULT FALSE;
  DECLARE table_name VARCHAR(255);
  DECLARE backup_name VARCHAR(255);
  DECLARE cur_tables CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_schema = 'test2' AND table_type = 'BASE TABLE';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  SET @backup_time = DATE_FORMAT(NOW(), '%Y%m%d%H%i%s');
 
  OPEN cur_tables;
  read_loop: LOOP
    FETCH cur_tables INTO table_name;
    IF done THEN
      LEAVE read_loop;
    END IF;
   
    SET backup_name = CONCAT(table_name, '_', @backup_time);
    
   
    SET @sql = CONCAT('CREATE TABLE test2.', backup_name, ' LIKE test2.', table_name);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('INSERT INTO test2.', backup_name, ' SELECT * FROM test2.', table_name);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
   
  END LOOP;

  CLOSE cur_tables;
END //
DELIMITER ;
