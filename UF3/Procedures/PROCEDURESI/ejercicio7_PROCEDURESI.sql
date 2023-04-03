use world;

DELIMITER hola 
DROP PROCEDURE IF EXISTS selectTable hola 

CREATE PROCEDURE selectTable(IN exportProducts VARCHAR(30))
BEGIN 	
	SET @nombreFichero = REPLACE(REPLACE(CONCAT(exportProducts ,REPLACE(now(), ":", ""),".csv"), ' ', '_'), '-','');
    SET @sintaxi = CONCAT("SELECT *
					FROM countrylanguage 
					INTO OUTFILE '",@nombreFichero, "'",
					" CHARACTER SET utf8mb4
					FIELDS TERMINATED BY ';'
					OPTIONALLY ENCLOSED BY '""'
					LINES TERMINATED BY '\\n';"); 
    PREPARE instruccion FROM @sintaxi;
    EXECUTE instruccion;
    DEALLOCATE PREPARE instruccion;
    
END hola 

DELIMITER ;

CALL selectTable('countrylanguage');


SELECT @@DATADIR ;




