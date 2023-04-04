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



