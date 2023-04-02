USE mymovies;

DELIMITER XX
DROP PROCEDURE IF EXISTS getMvoiesByYear XX
CREATE PROCEDURE getMoviesByYear(IN start_year INT, IN end_year INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE movie_title VARCHAR(255);
    DECLARE release_year YEAR;
    DECLARE movies_cursor CURSOR FOR
        SELECT title, release_year FROM movies
        WHERE release_year BETWEEN start_year AND end_year
        ORDER BY release_year, title;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN movies_cursor;

    movies_loop: LOOP
        FETCH movies_cursor INTO movie_title, release_year;
        IF done THEN
            LEAVE movies_loop;
        END IF;

        SELECT CONCAT(movie_title, ' (', release_year, ')') AS 'Movie';
    END LOOP;

    CLOSE movies_cursor;
END XX

DELIMITER ;

CALL getMoviesByYear(1986, 2001);
