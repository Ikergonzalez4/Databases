USE mymovies;

DELIMITER XX
DROP PROCEDURE IF EXISTS getMoviesByName XX
CREATE PROCEDURE getMoviesByName(IN search_text VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE movie_title VARCHAR(255);
    DECLARE release_year YEAR;
    DECLARE movies_cursor CURSOR FOR
        SELECT title, release_year FROM movies
        WHERE title LIKE CONCAT('%', search_text, '%')
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

CALL getMoviesByName('Superman');

