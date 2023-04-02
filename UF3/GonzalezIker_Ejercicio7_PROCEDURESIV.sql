USE mymovies;

DELIMITER XX
DROP PROCEDURE IF EXISTS calculateRevenue XX
CREATE PROCEDURE calculateRevenue (IN p_movie_id INT, OUT p_revenue DECIMAL(10,2))
BEGIN
    DECLARE v_stock_units INT;
    DECLARE v_price DECIMAL(10,2);

    SELECT stockUnits, price INTO v_stock_units, v_price
    FROM movies
    WHERE movieID = p_movie_id;

    SET p_revenue = v_stock_units * v_price;

END XX
DELIMITER ;


SET @X = 36;
CALL calculateRevenue(@X, @revenue);
SELECT @revenue;


