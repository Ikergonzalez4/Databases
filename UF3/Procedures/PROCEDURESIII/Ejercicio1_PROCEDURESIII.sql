/*1. A la BD Sakila crearem un procediment showMeSomeActors() que tingui dos paràmetres INT d'entrada:
valor1 serà id numèric d'actor del primer actor a mostrar-li el nom
valor2 serà id numèric de l'últim a actor a mostrar a mostrar-li el nom
Useu un for-loop o un while i una variable @aux que us permeti iterar entre Valor1 i Valor2.
Feu SELECT sobre la taula actor fent WHERE per la columna actor_id.
El procediment ha de mostrar el nom i el cognom dels actors els actor_id dels quals estigui comprès entre valor1 i valor2.*/

use sakila;

DELIMITER //
DROP PROCEDURE IF EXISTS showMeSomeActors // 
CREATE PROCEDURE showMeSomeActors(IN valor1 INT, IN valor2 INT)
BEGIN
  DECLARE aux INT;
  SET aux = valor1;
  WHILE aux <= valor2 DO
    SELECT first_name, last_name FROM actor WHERE actor_id = aux;
    SET aux = aux + 1;
  END WHILE;
END //
DELIMITER ;

CALL showMeSomeActors(10, 20);

