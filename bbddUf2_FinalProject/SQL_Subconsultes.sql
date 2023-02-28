-- 1. Retorna el nom o noms del bar amb la carta de begudes més extensa.

SELECT nom 
FROM bar 
WHERE id_bar IN (
    SELECT id_bar 
    FROM carta_begudes 
    GROUP BY id_bar 
    HAVING COUNT(*) = (
        SELECT MAX(num_bebidas) 
        FROM (
            SELECT id_bar, COUNT(*) as num_bebidas 
            FROM carta_begudes 
            GROUP BY id_bar
        ) as bebidas_por_bar
    )
);

-- 2. Els distribuïdors que distribueixen tots els ingredients existents.

SELECT nom_empresa
FROM distribuidor d
WHERE NOT EXISTS (
    SELECT i.id_ingredient
    FROM ingredient i
    WHERE NOT EXISTS (
        SELECT 1
        FROM distribuidor dist
        WHERE dist.id_distribuidor = d.id_distribuidor
        AND dist.id_ingredient = i.id_ingredient
    )
);


-- 3. Retorna les comandes de begudes que contenen begudes alcohòliques de taules que
-- siguin per fumadors i aptes per grups grans (més de 5 persones). (Pista: IN o NOT IN)

SELECT cb.id_beguda, cb.id_bar, cb.id_client_taula, cb.data_hora_comanda, cb.quantitat
FROM comanda_begudes cb
WHERE cb.id_beguda IN (
    SELECT b.id_beguda
    FROM beguda b
    WHERE b.te_Alchol = 1
) AND cb.id_client_taula IN (
    SELECT t.numero_taula
    FROM taula t
    WHERE t.es_fumadors = 1 AND t.num_cadires > 5 AND t.id_bar = cb.id_bar
);

-- 4. Llista el nom de les tapes que compleixen les següents condicions:
-- a. Tenen més 3 ingredients d’importació.
-- b. Estan presents a les cartes de més d’un bar.

SELECT nom
FROM tapa
WHERE id_tapa IN (
  SELECT id_tapa
  FROM ingredients_tapa
  WHERE id_ingredient IN (
    SELECT id_ingredient
    FROM ingredient
    WHERE es_importacio = 1
  )
  GROUP BY id_tapa
  HAVING COUNT(*) > 3
);


-- 5. Retorna el nom o noms dels distribuïdors amb menys begudes diferents distribuïdes.

SELECT nom_empresa 
FROM distribuidor 
WHERE id_distribuidor = (
    SELECT DISTINCT id_distribuidor 
    FROM distro_beguda 
    GROUP BY id_distribuidor 
    ORDER BY COUNT(DISTINCT id_beguda) ASC 
    LIMIT 1
);



