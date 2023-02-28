INSERT INTO tapa (id_tapa, nom, descripcio_carta, temps_preparacio, es_calent, es_vegeta, es_individual)
VALUES 
(1, "Patatas bravas", "Patatas fritas", 15, 1, 0, 1),
(2, "Gambas al ajillo", "Gambas con ajo", 20, 1, 0, 0),
(3, "Espinacas a la crema", "Espinacas", 10, 1, 1, 1),
(4, "Ensalada César", "Ensalada de lechuga", 15, 0, 1, 1),
(5, "Pulpo a la gallega", "Pulpo con papas", 30, 1, 0, 0),
(6, "Hamburguesa vegetariana", "Hamburguesa vegetariana", 20, 1, 1, 1),
(7, "Croquetas de jamón", "Croquetas rellenas", 15, 1, 0, 1),
(8, "Tostadas con tomate y aceite", "Tostadas con tomate", 5, 0, 1, 1);

 
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (1, 'Distribuidora A', 'Juan Pérez', '555-555-5555', 'juan.perez@distribuidora-a.com', 'www.distribuidora-a.com');
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (2, 'Distribuidora B', 'María González', '555-555-5556', 'maria.gonzalez@distribuidora-b.com', 'www.distribuidora-b.com');
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (3, 'Frutas del Sur', 'Juan Pérez', '555-1234', 'info@frutasdelsur.com', 'www.frutasdelsur.com');
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (4, 'Coladores', 'Iker González', '545-5318', 'info@coladores.com', 'www.coladores.com');
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (5, 'Verduras del Norte', 'María González', '555-5678', 'info@verdurasdelnorte.com', 'www.verdurasdelnorte.com');
INSERT INTO distribuidor (id_distribuidor, nom_empresa, contacte_principal, telefon, email, web)
VALUES (6, 'Verduras del Sur', 'Mar González', '556-5678', 'info@verdurasdelsur.com', 'www.verdurasdelsur.com');

INSERT INTO beguda (id_beguda, nom, descripcio, es_calent, te_Alchol, quantitat_cl)
VALUES 
("12","Café", "Café con leche", 1, 0, 50),
("13","Té", "Té verde con limón", 1, 0, 50),
("11","Vino tinto", "Vino tinto de la región de Rioja", 0, 1, 75),
("14","Cerveza", "Cerveza", 0, 0, 33),
("15","Fanta", "Fanta de naranja", 0, 0, 33),
("16","Coca-Cola", "Coca-Cola", 0,0, 33),
("17","Wiskey", "Wiskey", 0, 1, 50),
("18","Ron", "Ron", 0, 1, 50);

INSERT INTO ingredient (id_ingredient, nom, descripcio, es_picant, es_importacio, cost_gram, id_distribuidor)
VALUES 
    (1,'Tomate', 'Fruta roja y redonda', false, false, 0.05, 1),
    (2,'Lechuga', 'Hoja verde y crujiente', false, false, 0.03, 2),
    (3,'Pimiento', 'Verdura de colores', false, false, 0.07, 3),
    (4,'Cebolla', 'Verdura blanca y dulce', false, false, 0.04, 4),
    (5,'Ajo', 'Bulbo picante y aromático', true, false, 0.06, 5),
    (6,'Pepinillo', 'Verdura verde y acida', false, true, 0.08, 6);

INSERT INTO ingredients_tapa (id_tapa, id_ingredient, quantitat)
VALUES 
(1, 1, 2),
(1, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 1, 1),
(6, 4, 1),
(1, 2, 2),
(2, 3, 1),
(8, 1, 3),
(3, 2, 3),
(5, 5, 2),
(2, 1, 2),
(3, 3, 1),
(4, 1, 4),
(1, 5, 3),
(3, 6, 1),
(2, 1, 2);


INSERT INTO distro_beguda (id_distribuidor, id_beguda, cost_venda)
VALUES 
(1, 12, .5),
(1, 11, 2.0),
(1, 13, 2.75),
(2, 14, 2.25);

INSERT INTO Persona VALUES("12345678A", "John", "Doe", "Smith", "john.doe@email.com");
INSERT INTO Persona VALUES("23456789B", "Jane", "Doe", "Johnson", "jane.doe@email.com");
INSERT INTO Persona VALUES("34567890C", "Robert", "Smith", "Williams", "robert.smith@email.com");
INSERT INTO Persona VALUES("45678901D", "Michael", "Johnson", "Brown", "michael.johnson@email.com");
INSERT INTO Persona VALUES("56789012E", "William", "Brown", "Davis", "william.brown@email.com");
INSERT INTO persona VALUES("67890123F", "David", "Davis", "Miller", "david.davis@email.com");
INSERT INTO persona VALUES("78901234G", "Richard", "Miller", "Wilson", "richard.miller@email.com");
INSERT INTO persona VALUES("89012345H", "Charles", "Wilson", "Anderson", "charles.wilson@email.com");
INSERT INTO persona VALUES("90123456I", "Joseph", "Anderson", "Thomas", "joseph.anderson@email.com");
INSERT INTO persona VALUES("01234567J", "Thomas", "Thomas", "Jackson", "thomas.thomas@email.com");
INSERT INTO persona VALUES("12345678K", "Christopher", "Jackson", "White", "christopher.jackson@email.com");
INSERT INTO persona VALUES("23456789L", "Matthew", "White", "Harris", "matthew.white@email.com");
INSERT INTO persona VALUES("34567890M", "Daniel", "Harris", "Martin", "daniel.harris@email.com");
INSERT INTO persona VALUES("45678901N", "Anthony", "Martin", "Thompson", "anthony.martin@email.com");
INSERT INTO persona VALUES("56789012O", "Donald", "Thompson", "Garcia", "donald.thompson@email.com");
INSERT INTO persona VALUES("67890123P", "Mark", "Garcia", "Martinez", "mark.garcia@email.com");

INSERT INTO carrec_empleat VALUES ("Programador", "Desenvolupador de software", 40, 1500);
INSERT INTO carrec_empleat VALUES ("Dissenyador gràfic", "Dissenyador d'imatges i elements gràfics", 30, 1200);

INSERT INTO localitat VALUES (1, "Barcelona", "Barcelona", "Catalunya", "Espanya", "Europa");
INSERT INTO localitat VALUES (2, "Madrid", "Madrid", "Comunidad de Madrid", "Espanya", "Europa");
INSERT INTO localitat VALUES (3, "Paris", "Ile-de-France", "Île-de-France", "França", "Europa");
INSERT INTO localitat VALUES (4, "Berlín", "Berlin", "Berlin", "Alemanya", "Europa");


-- NO FUNCIONAAAAAAAAAAAAAAAAA ==================================================================================================================
INSERT INTO empleat VALUES ('12345678A', '523656789096', 'ES6020078957564873146422' , 1000, 'Programador', '67890123P', 'Barcelona');
INSERT INTO empleat VALUES ('23456789B', '323436589001', 'ES6020078957564873146422', 2000, 'Programador', '67890123P', 'Madrid');
INSERT INTO empleat VALUES ('34567890C', '523456789096', 'ES6020078957566782346429', 1500, 'Programador', '67890123P', 'Paris');
INSERT INTO empleat VALUES ('45678901D', '623456489001', 'ES6020078957564873146428', 1700, 'Dissenyador gràfic', '67890123P', 'Barcelona');
INSERT INTO empleat VALUES  ('56789012E', '823456389001', 'ES6020078957564873146456', 1200, 'Dissenyador gràfic', '67890123P', 'Berlín');
INSERT INTO empleat VALUES ('67890123F', '223446789001', 'ES6020078957564873146421', 1600, 'Dissenyador gràfic', '67890123P', 'Berlín');

INSERT INTO cliente (dni_client, es_major) VALUES ('89012345H ', 1);
INSERT INTO cliente (dni_client, es_major) VALUES ('90123456I  ', 1);
INSERT INTO cliente (dni_client, es_major) VALUES ('01234567J  ', 2);
INSERT INTO cliente (dni_client, es_major) VALUES ('12345678K ', 1);

INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('1','cañita', 20, true, 1);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('2','esmec', 30, true, 2);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('3','totvar', 60, false, 4);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('4','sportiux', 30, true, 3);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('5','BARcelona', 40, true, 1);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('6','BAResme', 30, true, 2);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('7','Arenys de BAR', 20, false, 4);
INSERT INTO Bar (id_bar, nom, aforament_maxim, te_exterior, ubicacio) VALUES ('8','Bar', 60, true, 3);

INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (1, 1, 0, 0, 4);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (2, 1, 1, 0, 2);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (3, 2, 0, 0, 6);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (4, 2, 1, 0, 8);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (5, 3, 0, 0, 2);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (6, 3, 1, 0, 4);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (7, 4, 0, 1, 10);
INSERT INTO Taula (numero_taula, id_bar, es_exterior, es_fumadors, num_cadires)
VALUES (8, 4, 1, 1, 6);


INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (1, '01234567J', 1, 1, 0, '2023-02-12 10:34:00', '2023-02-12 12:12:00', 0);
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (2, '90123456I', 2, 1, 0, '2023-02-12 12:00:00', '2023-02-12 13:40:00', 0);

-- no === 
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (3, '67890123F', 3, 2, 0, '2023-02-12 12:00:00', '2023-02-12 14:06:00', 0);
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (4, '78901234G', 4, 3, 0, '2023-02-12 13:00:00', '2023-02-12 15:15:05', 0); 
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (5, '45678901D', 3, 3, 0, '2023-02-12 13:00:00', '2023-02-12 15:30:56', 0); 
-- si 
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (6, '12345678K', 1, 4, 0, '2023-02-12 13:00:00', '2023-02-12 16:04:00', 0); 

INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (7, '56789012E', 2, 4, 0, '2023-02-12 11:12:00', '2023-02-12 14:00:00', 0); 
INSERT INTO client_taula (id_client_taula, dni_client, numero_taula, id_bar, es_fumador, data_hora_arribada,  data_hora_sortida, ha_pagat)
VALUES (8, '67890123P', 4, 2, 0, '2023-02-12 13:20:00', '2023-02-12 15:50:00', 0); 


INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (12, 1, 1, '2022-02-19 10:00:00', 2);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (13, 2, 1, '2022-02-19 11:00:00', 3);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (11, 3, 2, '2022-02-19 12:00:00', 4);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (14, 4, 2, '2022-02-19 13:00:00', 5);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (15, 5, 3, '2022-02-19 14:00:00', 6);


INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (16, 6, 3, '2022-02-19 15:00:00', 7);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (17, 7, 4, '2022-02-19 16:00:00', 8);
INSERT INTO comanda_begudes (id_beguda, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (18, 8, 4, '2022-02-19 17:00:00', 9);

INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (1, 1, 1, '2023-02-12 10:45:00', 2);
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (2, 2, 2, '2022-01-01 11:00:00', 3);

-- ==== no
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (3, 3, 3, '2022-01-01 12:00:00', 4);
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (4, 4, 4, '2022-01-01 13:00:00', 5);
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (5, 5, 5, '2022-01-01 14:00:00', 6);
-- ====

INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (6, 6, 6, '2022-01-01 15:00:00', 7);
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (7, 7, 7, '2022-01-01 16:00:00', 8);
INSERT INTO Comanda_tapes (id_tapa, id_bar, id_client_taula, data_hora_comanda, quantitat)
VALUES (8, 8, 8, '2022-01-01 17:00:00', 9);

INSERT INTO carta_tapes (id_tapa,id_bar, cost, pvp)
VALUES 
(1, 1, 10, 20),
(2, 2, 10, 20),
(3, 3, 10, 20),
(4, 4, 10, 20),
(5, 5, 10, 20),
(6, 6, 10, 20),
(7, 7, 10, 20),
(8, 8, 10, 20);


