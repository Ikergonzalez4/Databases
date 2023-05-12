CREATE OR REPLACE TYPE categoria_T AS OBJECT (
    id          NUMBER,
    nombre      VARCHAR2(50),
    descripcion VARCHAR2(2000),
    MEMBER FUNCTION map RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY categoria_T AS
    MEMBER FUNCTION map RETURN VARCHAR2 IS
    BEGIN
        RETURN nombre;
    END;
END;

CREATE OR REPLACE TYPE proveedor_T AS OBJECT (
    id          NUMBER,
    nombre      VARCHAR2(50),
    cif         VARCHAR2(50),
    direccion   VARCHAR2(200),
    telefono    VARCHAR2(20),
    email       VARCHAR2(50),
    MEMBER FUNCTION map RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY proveedor_T AS
    MEMBER FUNCTION map RETURN VARCHAR2 IS
    BEGIN
        RETURN cif;
    END;
END;

CREATE OR REPLACE TYPE noticia_T AS OBJECT (
    id              NUMBER,
    titulo          VARCHAR2(200),
    texto           VARCHAR2(4000),
    fecha_publicacion   DATE,
    MEMBER FUNCTION order(other IN noticia_T) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY noticia_T AS
    MEMBER FUNCTION order(other IN noticia_T) RETURN NUMBER IS
    BEGIN
        IF fecha_publicacion < other.fecha_publicacion THEN
            RETURN -1;
        ELSIF fecha_publicacion > other.fecha_publicacion THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
END;
