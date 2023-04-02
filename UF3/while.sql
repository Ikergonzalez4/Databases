USE northwind 

DELIMITER hola 
DROP PROCEDURE IF EXISTS ejemploWhile hola 

CREATE PROCEDURE ejemploWhile(IN x INT) 
BEGIN 
	while1:
	WHILE x > 0 DO 
		SELECT CONCAT('Faltan ', x ,' segundos para que explote');
        SET x = x -1;
	END WHILE while1;

	SELECT 'BOOOM ah!';
END hola
DELIMITER ;
    
CALL ejemploWhile(10);