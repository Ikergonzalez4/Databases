-- Selecciona les tapes tals que el seu nom contingui ‘de la casa’, que estiguin fetes amb
-- més de 4 ingredients i que el seu temps de preparació sigui superior a 1h.  

select nom
from tapa
inner join ingredients_tapa on ingredients_tapa.id_tapa = tapa.id_tapa
where nom like '%de la casa%' AND quantitat > 4 AND temps_preparacio > 60;

SELECT nom, temps_preparacio
FROM tapa
WHERE nom LIKE '%de la casa%' AND temps_preparacio > '01:00:00';

-- Retorna el nom del(s) distribuïdor(s) que no subministren cap ingredient. Fes servir
-- conjunts i/o usant JOIN’s

select nom
from distribuidor
inner join ingredient on ingredient.id_distribuidor = distribuidor.id_distribuidor
where es_importacio = false;

-- Retorna el nom i cognom d’aquells clients que també són treballadors, que tinguin un
-- email vàlid (l’email ha de contenir una @ per ser considerat vàlid) i que hagin tingut un
-- ascens (suposem que ha ascendit quan el sou extra és diferent de nul). Fes servir
-- conjunts.

SELECT nom, cognom1
FROM persona
JOIN cliente ON persona.dni = cliente.dni_client
UNION
SELECT nom, cognom1
FROM persona
JOIN empleat ON persona.dni = empleat.dni_empleat
WHERE email LIKE '%@%' AND quantitat_sou_extra IS NOT NULL;

-- Retorna la mitjana de nombre de cadires que tenen les taules de cada bar. Considera
--  només les taules que estan a l’interior.

SELECT AVG(num_cadires)
from taula 
where es_exterior = true;

-- Retorna el recompte de quants ingredients hi ha que siguin picants i d’importació que
-- en la seva descripció hi contingui la paraula “fire”.
SELECT COUNT(distinct id_ingredient)
from ingredient
where es_picant = true AND es_importacio = true AND descripcio like '%fire%';

-- Mostra tota la informació que apareix a les cartes (incloent el nom de la tapa i/o de la
-- beguda), tenint en compte només els productes calents, que siguin individuals i les
-- begudes no alcohòliques. Fes servir conjunts.


SELECT *
from tapa
inner join carta_tapes on carta_tapes.id_tapa = tapa.id_tapa
where es_calent = true AND es_individual = true 
UNION 
select *, nom 
from beguda
inner join carta_begudes on carta_begudes.id_beguda = beguda.id_beguda
WHERE te_alchol = false;

-- Retorna les 10 primeres begudes ordenades en primer lloc pel marge de benefici (PVP
-- cost) de major a menor i en segon lloc pel seu nom de la A a la Z. Sabries retornar els
-- 10 resultats següents? Com?
SELECT nom, (pvp - cost) AS media 
from beguda 
inner join carta_begudes on carta_begudes.id_beguda = beguda.id_beguda
order by media desc, nom asc 
limit 10;
-- para los 10 siguientes offset 10 

--  Mostra el nom dels ingredients amb més de 5 lletres, que la primera lletra sigui una vocal
-- i que siguin d’importació

SELECT nom 
from ingredient
where length(nom) > 5 AND 'a%' OR'e%' OR 'i%' OR 'o%' OR 'u%' 
AND es_importacio = true;  


-- Per a cada bar, feu el recompte del número de tapes de menjar diferents que té cada un
-- d’ells ordenats de forma descendent pel nombre de tapes. Volem el bar que en té més
-- en primer lloc.

SELECT COUNT(DISTINCT tapa.id_tapa) AS numero_tapes, bar.id_bar 
FROM bar
INNER JOIN carta_tapes ON carta_tapes.id_bar = bar.id_bar
INNER JOIN tapa ON tapa.id_tapa = carta_tapes.id_tapa  
GROUP BY bar.id_bar
ORDER BY numero_tapes DESC;


-- Troba els clients que han consumit durant la primera quinzena del mes de gener i que
-- van marxar sense pagar. Mostra el DNI, nom i cognoms en un sol camp i amb el següent
-- format:
-- ‘12345678A - Nom Cognom1 Cognom2’
-- Ordena’ls pel Cognom1, Cognom2 i Nom de forma ascendent

SELECT dni, nom, cognom1, cognom2 
FROM persona
INNER JOIN cliente ON cliente.dni_client = persona.dni
INNER JOIN client_taula ON client_taula.dni_client = cliente.dni_client
WHERE client_taula.dni_client IS NOT NULL 
  AND client_taula.data_hora_arribada BETWEEN '2023-01-00 00:00:00' AND '2023-01-00 23:59:59' 
  AND client_taula.data_hora_sortida BETWEEN '2023-01-15 00:00:00' AND '2023-01-15 23:59:59' 
  AND client_taula.ha_pagat = false 
ORDER BY cognom1, cognom2, nom ASC;



-- Mostra per cada bar, la tapa de menjar més venuda durant l’any anterior (fes que
-- aquesta consulta sigui vàlida any rere any). Sabries fer el mateix pel mes anterior? Com?
-- año
SELECT b.nom, t.nom AS tapa_mes_venuda
FROM bar b
INNER JOIN carta_tapes ct ON b.id_bar = ct.id_bar
INNER JOIN tapa t ON ct.id_tapa = t.id_tapa
INNER JOIN comanda_tapes c ON ct.id_bar = c.id_bar AND ct.id_tapa = c.id_tapa
WHERE YEAR(c.data_hora_comanda) = YEAR(NOW()) - 1
GROUP BY b.id_bar
HAVING COUNT(DISTINCT ct.id_tapa) = (
    SELECT COUNT(DISTINCT ct2.id_tapa)
    FROM carta_tapes ct2
    WHERE ct2.id_bar = b.id_bar
)
ORDER BY b.nom;
-- mes
SELECT b.nom, t.nom AS tapa_mes_venuda
FROM bar b
INNER JOIN carta_tapes ct ON b.id_bar = ct.id_bar
INNER JOIN tapa t ON ct.id_tapa = t.id_tapa
INNER JOIN comanda_tapes c ON ct.id_bar = c.id_bar AND ct.id_tapa = c.id_tapa
WHERE YEAR(c.data_hora_comanda) = YEAR(NOW()) AND MONTH(c.data_hora_comanda) = MONTH(NOW()) - 1
GROUP BY b.id_bar, t.id_tapa
HAVING COUNT(*) = (
    SELECT MAX(tapes_venudes)
    FROM (
        SELECT COUNT(*) AS tapes_venudes
        FROM comanda_tapes c2
        WHERE YEAR(c2.data_hora_comanda) = YEAR(NOW()) AND MONTH(c2.data_hora_comanda) = MONTH(NOW()) - 1
        GROUP BY c2.id_bar, c2.id_tapa
    ) t2
)
ORDER BY b.nom;




-- Mostra el DNI, email i el país de procedència de cadascun dels caps que no tenen sou
-- extra i que en la descripció del càrrec contingui la paraula ‘xef’. Asdfas

select dni_empleat, email, lloc_naixement 
from empleat 
inner join persona on persona.dni = empleat.dni_empleat 
inner join carrec_empleat on carrec_empleat.nom_carrec = empleat.dni_empleat
where quantitat_sou_extra = 0 AND descripcio like '% xef %';

-- Retorna una llista de totes les persones de la base de dades (DNI, noms i cognoms); i en
-- el cas de que siguin treballadors, retorna també el seu Sou_extra i Num_CC. Usa els
-- JOINs adequats

select dni, nom, cognom1, cognom2, quantitat_sou_extra, num_cc
from persona 
left join empleat on empleat.dni_empleat = persona.dni 
UNION 
select dni, nom, cognom1, cognom2, null, null 
from persona 
left join cliente on cliente.dni_client = persona.dni;

 -- Mostra quins clients majors d’edat hi havia ahir a la nit (suposem la nit comença a les
-- 21h, han arribat o marxat després d’aquesta hora) al bar ‘La Rovira’. Usa els JOINs
-- adequats.

SELECT cliente.dni_client
FROM cliente 
INNER JOIN client_taula ON client_taula.dni_client = cliente.dni_client
INNER JOIN taula ON taula.id_bar = client_taula.id_bar
INNER JOIN bar ON bar.id_bar = taula.id_bar
WHERE es_major = true 
AND data_hora_arribada BETWEEN '2023-01-01 21:00:00' AND '2023-01-01 23:59:59' 
AND data_hora_sortida BETWEEN '2023-01-01 21:00:00' AND '2023-01-01 23:59:59'
AND nom = 'La Rovira'; 



