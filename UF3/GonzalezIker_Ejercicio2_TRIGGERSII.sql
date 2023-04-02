use mymovies;

/*CREATE TABLE movies_per_year (
    year INT,
    countmovies INT,
    PRIMARY KEY (year)
);*/

DELIMITER XX
DROP TRIGGER IF EXISTS after_movies_insert XX 
CREATE TRIGGER after_movies_insert
AFTER INSERT ON movies
FOR EACH ROW
BEGIN
    DECLARE count INT;
    
    SELECT countmovies INTO count FROM movies_per_year WHERE year = NEW.year;
    
    IF count IS NULL THEN
        INSERT INTO movies_per_year (year, countmovies) VALUES (NEW.year, 1);
    
    ELSE
        UPDATE movies_per_year SET countmovies = countmovies + 1 WHERE year = NEW.year;
    END IF;
END XX

DELIMITER ;

-- SHOW TRIGGERS;
