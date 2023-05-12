CREATE OR REPLACE TYPE PRODUCTO_T AS OBJECT (
    id          NUMBER,
    nombre      VARCHAR2(50),
    descripcion VARCHAR2(2000),
    price       NUMBER, -- Nuevo atributo "price"
    tax         NUMBER, -- Nuevo atributo "tax" (porcentaje)
    MEMBER FUNCTION precio_final RETURN NUMBER
);

precio_final = price + (price * tax / 100)

CREATE OR REPLACE TYPE BODY PRODUCTO_T AS
    MEMBER FUNCTION precio_final RETURN NUMBER IS
    BEGIN
        RETURN price + (price * tax / 100);
    END;
END;

DECLARE
    p PRODUCTO_T;
    precio_final NUMBER;
BEGIN
    p := PRODUCTO_T(1, 'Producto 1', 'Descripción del producto 1', 5.25, 21);
    precio_final := p.precio_final;
    DBMS_OUTPUT.PUT_LINE('Precio final: ' || precio_final);
END;

Precio final: 6.3575
