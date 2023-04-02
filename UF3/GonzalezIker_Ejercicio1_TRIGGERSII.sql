use mymovies;

DELIMITER XX
DROP TRIGGER IF EXISTS before_mvoies_update XX
CREATE TRIGGER before_movies_update
BEFORE UPDATE ON movies
FOR EACH ROW
BEGIN
    DECLARE version_id INT;
    
    SELECT MAX(version) INTO version_id FROM movies_version WHERE id = OLD.id;
    
    SET version_id = COALESCE(version_id, 0) + 1;
    
    INSERT INTO movies_version (id, name, year, stockUnits, price, hora, version)
    VALUES (OLD.id, OLD.name, OLD.year, OLD.stockUnits, OLD.price, NOW(), version_id);
END XX 

DELIMITER ;
