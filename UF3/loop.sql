USE northwind 

DELIMITER hola 
DROP PROCEDURE IF EXISTS ejemploLoop hola 

CREATE PROCEDURE ejemploLoop(IN dientes INT) 
BEGIN 
	loop1:
    LOOP 
		IF dientes <= 0 THEN 
			LEAVE loop1;
		END IF;
        SELECT "Como aun te quedan dientes, te lo quitaremos";
        SET dientes = dientes - 1;
	END LOOP loop1;
END hola
DELIMITER ;
    
CALL ejemploLoop(2);