use world;

DELIMITER XX
DROP PROCEDURE IF EXISTS  world.exercisi1 XX
CREATE PROCEDURE world.exercisi1()
BEGIN
	DECLARE semafor INT DEFAULT 0;
    DECLARE vTableName VARCHAR(64);
    
    DECLARE curTable CURSOR FOR( SELECT table_name -- aixo es el cursor, enseña totes les taules de la bdd
									FROM INFORMATION_SCHEMA.TABLES
									WHERE table_schema = 'world');
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET semafor = 1;
    OPEN curTable;
    pikachu: 
    LOOP
    
		FETCH curTable INTO vTableName;
        
		IF semafor = 1 THEN
			LEAVE pikachu;

		END IF;
        
        SET @isodate = null;
        CALL getIsoDate(@isodate);
        
		SELECT vTableName as NomTaulaActual
        ,CONCAT(vTableName,'_',@isodate) as NomTaulaCrear;
        
        set @sintaxi = CONCAT('CREAR TABLE IF NOT EXISTS world.', vTableName,'_',@isodate, 'AS SELECT * FROM world.', vTableName);
        
        -- TEST 
        SELECT @sintaxi;
        -- END TEST 
        
        PREPARE execucio FROM @sintaxi;
        EXECUTE execucio;
        DEALLOCATE PREPARE execucio;

    END LOOP pikachu;
    
    CLOSE curTable;

END XX

DELIMITER ;

CREATE TABLE world.country_bck AS SELECT * FROM world.country;

select curdate();
select now();

DELIMITER raba
DROP PROCEDURE IF EXISTS getISODate raba

CREATE PROCEDURE getIsoDate (OUT isodate VARCHAR (8))
BEGIN
	SET isodate = (SELECT concat(year(now()),
			IF(length(month(now())) = 2,month(now()),concat('0', month(now()))),
			IF(length(DAY(now())) = 2,day(now()),concat('0', day(now())))));

END raba

DELIMITER ;

SET @isodate = null;


CALL world.exercisi1();