use northwind;

DELIMITER hola 
DROP PROCEDURE IF EXISTS selectTable hola 

CREATE PROCEDURE selectTable(IN tableName VARCHAR(30))
BEGIN 
    SET @sintaxi = CONCAT("SELECT * FROM ", tableName, ";");  
    
    PREPARE instruccion FROM @sintaxi;
    EXECUTE instruccion;
    DEALLOCATE PREPARE instruccion;
    
END hola 

DELIMITER ;

CALL selectTable('products')