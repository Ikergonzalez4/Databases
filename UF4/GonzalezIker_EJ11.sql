CREATE OR REPLACE TYPE noticia_t AS OBJECT (
  id NUMBER,
  title VARCHAR2(100),
  content VARCHAR2(4000),
  publication_date DATE,

  STATIC FUNCTION insert_news(
    p_id NUMBER,
    p_title VARCHAR2,
    p_content VARCHAR2,
    p_pub_date DATE
  ) RETURN NUMBER
) NOT FINAL;

/

CREATE OR REPLACE TYPE BODY noticia_t AS
  STATIC FUNCTION insert_news(
    p_id NUMBER,
    p_title VARCHAR2,
    p_content VARCHAR2,
    p_pub_date DATE
  ) RETURN NUMBER IS
  BEGIN
    INSERT INTO noticias_obj (id, title, content, publication_date)
    VALUES (p_id, p_title, p_content, p_pub_date);
    RETURN SQL%ROWCOUNT;
  END insert_news;
END;

/

DECLARE
  n NUMBER;
BEGIN
  n := noticia_t.insert_news(1, 'Nueva noticia', 'Contenido de la nueva noticia', SYSDATE);
  DBMS_OUTPUT.PUT_LINE('Filas afectadas: ' || n);
END;

/

SELECT * FROM noticias_obj;
