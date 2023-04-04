/*9. Usant PL/SQL desenvolupeu una calculadora usant CASE i IF.
En una base de dades qualsevol, crear un procedure amb 4 paràmetres de tipus FLOAT: (IN pNum1, IN pNum2, IN pOperacio, OUT pResultat).
Segons el valor de la pOperacio (+, -, *, /) el procedure farà una acció o una altra i retornarà la variable resultat.
Heu d'evitar que el programa falli al fer una divisió per 0. Mostra ERROR i retorna el valor -1.*/


use world; 

DELIMITER // 
DROP PROCEDURE IF EXISTS calc // 
CREATE PROCEDURE calc(IN pNum1 FLOAT, IN pNum2 FLOAT, IN pOperacio char(1), OUT pResultat FLOAT) 
BEGIN
SET pResultat = 0;
	CASE pOperacio
		WHEN '+' THEN 	
			SET pResultat = pNum1 + pNum2;
		WHEN '-' THEN
			SET pResultat = pNum1 - pNum2;
		WHEN '*' THEN
			SET pResultat = pNum1 * pNum2;
		WHEN '/' THEN
            IF pNum2 != 0 THEN
				SET pResultat = pNum1 / pNum2;
			ELSE
                SELECT 'ERROR' INTO pResultat;
			END IF;
		ELSE SELECT 'INVALID OPERATION' INTO pResultat;
	END CASE;
END // 
DELIMITER ;

CALL calc(10, 5, '*', @result);
SELECT @result;
