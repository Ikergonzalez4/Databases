use world;

SET GLOBAL event_scheduler = ON;

DELIMITER :) 
DROP EVENT IF EXISTS backupDiario :) 

CREATE EVENT IF NOT EXISTS backupDiario  
ON SCHEDULE EVERY 1 DAY 
STARTS '2023-03-25 00:00:00'
ENDS '2023-05-31'
DO BEGIN 
	CALL world.ejercicio1();
END :) 

CREATE EVENT IF NOT EXISTS backupDiario32
ON SCHEDULE AT NOW()
DO BEGIN 
	CALL world.ejercicio1();
END :) 

DELIMITER ;
show events;