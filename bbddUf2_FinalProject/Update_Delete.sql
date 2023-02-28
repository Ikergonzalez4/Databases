-- Desactivar modo seguro sql para poder hacer los updates/deletes
SET SQL_SAFE_UPDATES = 0;

-- Actualitza el PVP de les tapes i begudes calentes; incrementeu-los el preu en un +3% i
-- un +5% respectivament. (Pista: calen 2 updates)

UPDATE carta_tapes SET pvp = pvp * 1.03 WHERE id_tapa IN (SELECT id_tapa FROM tapa);
UPDATE carta_begudes SET pvp = pvp * 1.05 WHERE id_beguda IN (SELECT id_beguda FROM beguda);


-- Actualitza els DNIs de totes les persones a les quals els hi falta la lletra al final;
-- afegintlos el caràcter ‘%’ al final. (Suposarem que els hi falta la lletra a tots els 
-- que tinguin una longitud de 8 caràcters)

UPDATE persona SET dni = dni + '%' WHERE LENGTH(dni) = 8;

-- Elimina les tapes que contenen ingredients picants.

DELETE t
FROM tapa t
INNER JOIN ingredients_tapa it ON t.id_tapa = it.id_tapa
INNER JOIN ingredient i ON it.id_ingredient = i.id_ingredient
WHERE i.es_picant = true
AND t.id_tapa NOT IN (
    SELECT id_tapa
    FROM carta_tapes
);


-- Esborra tots aquells clients que siguin menors d’edat i que hagin consumit alguna 
-- beguda alcohòlica il·legalment.

DELETE FROM persona
WHERE dni IN (
    SELECT cliente.dni_client
    FROM cliente
    INNER JOIN client_taula ON client_taula.dni_client = cliente.dni_client
    INNER JOIN comanda_begudes ON comanda_begudes.id_client_taula = client_taula.id_client_taula
    INNER JOIN carta_begudes ON carta_begudes.id_beguda = comanda_begudes.id_beguda
    INNER JOIN beguda ON beguda.id_beguda = carta_begudes.id_beguda
    WHERE es_major = false AND te_Alchol = true
);

-- El distribuïdor ‘Hijos de la Rivera’ ens ha fallat en el subministrament de begudes.
-- Esborra totes aquelles begudes que provenen d’aquest distribuïdor. 

DELETE FROM beguda
WHERE id_beguda IN (
  SELECT id_beguda
  FROM distro_beguda
  WHERE id_distribuidor IN (
    SELECT id_distribuidor
    FROM distribuidor
    WHERE nom_empresa = 'Hijos de la Rivera'
  )
);





