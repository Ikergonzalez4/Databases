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


