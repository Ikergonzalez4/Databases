CREATE TYPE CUSTOMER_T AS OBJECT (
    id      VARCHAR2(50),
    name    VARCHAR2(50),
    address VARCHAR2(200)
);

CREATE OR REPLACE TYPE CUSTOMER_T AS OBJECT (
    id      VARCHAR2(50),
    name    VARCHAR2(50),
    address VARCHAR2(200),
    MAP MEMBER FUNCTION map RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY CUSTOMER_T AS
    MAP MEMBER FUNCTION map RETURN VARCHAR2 IS
    BEGIN
        RETURN name;
    END;
END;

DECLARE
    c1 CUSTOMER_T := CUSTOMER_T('1', 'Juan', 'Calle 1');
    c2 CUSTOMER_T := CUSTOMER_T('2', 'Ana', 'Calle 2');
BEGIN
    IF c1.map < c2.map THEN
        DBMS_OUTPUT.PUT_LINE(c1.name || ' es menor que ' || c2.name);
    ELSE
        DBMS_OUTPUT.PUT_LINE(c2.name || ' es menor que ' || c1.name);
    END IF;
END;

CREATE OR REPLACE TYPE CUSTOMER_T AS OBJECT (
    id      VARCHAR2(50),
    name    VARCHAR2(50),
    address VARCHAR2(200),
    ORDER MEMBER FUNCTION order(other IN CUSTOMER_T) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY CUSTOMER_T AS
    ORDER MEMBER FUNCTION order(other IN CUSTOMER_T) RETURN NUMBER IS
    BEGIN
        IF name < other.name THEN
            RETURN -1;
        ELSIF name > other.name THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
END;

DECLARE
    c1 CUSTOMER_T := CUSTOMER_T('1', 'Juan', 'Calle 1');
    c2 CUSTOMER_T := CUSTOMER_T('2', 'Ana', 'Calle 2');
BEGIN
    IF c1.order(c2) < 0 THEN
        DBMS_OUTPUT.PUT_LINE(c1.name || ' es menor que ' || c2.name);
    ELSE
        DBMS_OUTPUT.PUT_LINE(c2.name || ' es menor que ' || c1.name);
    END IF;
END;
