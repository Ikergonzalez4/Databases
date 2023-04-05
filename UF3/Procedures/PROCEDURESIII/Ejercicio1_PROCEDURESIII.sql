/*1. A la BD Sakila creeu un procediment anomenat insertMyself que rebi els paràmetres d'entrada:
nom VARCHAR(45), cognom VARCHAR(45), data TIMESTAMP i x INT.

Aquest procediment inserirà x vegades l'actor amb nom i cognom dins de la taula Sakila.actor.
Com que actor_id és INT AUTOINCREMENTAL, no hem d'especificar el seu valor. És a dir, usarem un insert indirecte.*/

use sakila;

DELIMITER // 
DROP PROCEDURE IF EXISTS insertMyself // 
CREATE PROCEDURE insertMyself(IN p_nom VARCHAR(45), IN p_cognom VARCHAR(45), IN p_data TIMESTAMP, IN p_x INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  
  WHILE i < p_x DO
    INSERT INTO Sakila.actor (first_name, last_name, last_update)
    VALUES (p_nom, p_cognom, p_data);
    SET i = i + 1;
  END WHILE;
END;
DELIMITER ;

CALL insertMyself('John', 'Doe', NOW(), 5);
