/*-1. A la BD Sakila creeu un procediment anomenat insertMyself que rebi els paràmetres d'entrada:
nom VARCHAR(45), cognom VARCHAR(45), data TIMESTAMP i x INT.

Aquest procediment inserirà x vegades l'actor amb nom i cognom dins de la taula Sakila.actor.
Com que actor_id és INT AUTOINCREMENTAL, no hem d'especificar el seu valor. És a dir, usarem un insert indirecte.*/

use sakila;

DELIMITER //
DROP PROCEDURE IF EXISTS insertMyself //
CREATE PROCEDURE insertMyself(IN nom VARCHAR(45), IN cognom VARCHAR(45), IN data TIMESTAMP, IN x INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < x DO
        INSERT INTO actor(first_name, last_name, last_update)
        VALUES(nom, cognom, data);
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL insertMyself('Iker', 'Gonzalez', '2023-04-06 12:00:00', 3);
SELECT * FROM actor;


