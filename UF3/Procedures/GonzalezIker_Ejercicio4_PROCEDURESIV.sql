USE northwind;

DELIMITER XX
DROP PROCEDURE IF EXISTS comprovar_customer_id XX
CREATE PROCEDURE comprovar_customer_id(IN p_customer_id CHAR(5), OUT p_contact_name VARCHAR(30))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE customer_id CHAR(5);
    DECLARE contact_name VARCHAR(30);
    DECLARE customers_cursor CURSOR FOR
        SELECT CustomerID, ContactName FROM Customers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN customers_cursor;

    customer_loop: LOOP
        FETCH customers_cursor INTO customer_id, contact_name;
        IF done THEN
            SET p_contact_name = 'No existeix el CustomerID ' + p_customer_id;
            LEAVE customer_loop;
        END IF;

        IF customer_id = p_customer_id THEN
            SET p_contact_name = contact_name;
            LEAVE customer_loop;
        END IF;
    END LOOP;

    CLOSE customers_cursor;
END XX

DELIMITER ;


set @p_contact_name = '0';
call northwind.comprovar_customer_id('2', @p_contact_name);
select @p_contact_name;
