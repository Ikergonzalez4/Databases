DROP DATABASE IF EXISTS LSG_Bars;
CREATE DATABASE IF NOT EXISTS LSG_Bars
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE LSG_Bars;


CREATE TABLE IF NOT EXISTS tapa(
id_tapa int primary key,
nom VARCHAR(30) NOT NULL,
descripcio_carta VARCHAR(30),
temps_preparacio DATETIME,
es_calent boolean,
es_vegeta boolean,
es_individual boolean
);

CREATE TABLE IF NOT EXISTS distribuidor(
id_distribuidor int primary key NOT NULL CHECK (id_distribuidor > 0),
nom_empresa VARCHAR(30) NOT NULL,
contacte_principal VARCHAR(30),
telefon VARCHAR(30),
email VARCHAR(30),
web VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS ingredient(
id_ingredient int primary key ,
nom VARCHAR(30) NOT NULL,
descripcio VARCHAR(30),
es_picant boolean,
es_importacio boolean,
cost_gram DECIMAL (10,2) CHECK (cost_gram >= 0),
id_distribuidor INT NOT NULL,
CONSTRAINT FK_ingrediente_distribuidor11 FOREIGN KEY (id_distribuidor) REFERENCES distribuidor (id_distribuidor)
);

CREATE TABLE IF NOT EXISTS beguda(
id_beguda int primary key NOT NULL CHECK (id_beguda > 0),
nom VARCHAR(30) NOT NULL,
descripcio VARCHAR(30),
es_calent boolean,
te_Alchol boolean,
quantitat_cl int
);

CREATE TABLE IF NOT EXISTS distro_beguda(
id_distribuidor int NOT NULL CHECK (id_distribuidor > 0),
CONSTRAINT FK_distribuidor9 FOREIGN KEY (id_distribuidor) REFERENCES distribuidor (id_distribuidor),
id_beguda int NOT NULL CHECK (id_beguda > 0),
CONSTRAINT FK_beguda9 FOREIGN KEY (id_beguda) REFERENCES beguda (id_beguda),
cost_venda DECIMAL (10,2) CHECK (cost_venda >= 0)
);


CREATE TABLE IF NOT EXISTS ingredients_tapa (
id_tapa int NOT NULL CHECK (id_tapa > 0),
constraint FK_tapa12 foreign key (id_tapa) references tapa (id_tapa),
id_ingredient int CHECK (id_ingredient > 0),
constraint FK_ingredient12 foreign key (id_ingredient) references ingredient (id_ingredient),
quantitat int
);

CREATE TABLE IF NOT EXISTS persona(
dni VARCHAR(9) primary key NOT NULL,
nom VARCHAR(30) NOT NULL,
cognom1 VARCHAR(30) NOT NULL,
cognom2 VARCHAR(30) NOT NULL,
email VARCHAR(30) unique NOT NULL
);

CREATE TABLE IF NOT EXISTS localitat(
id_lloc int primary key NOT NULL CHECK (id_lloc > 0),
nom_localitat VARCHAR(30),
provincia VARCHAR(30),
comunitat_autonoma VARCHAR(30),
pais VARCHAR(30),
continent VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS carrec_empleat(
nom_carrec VARCHAR(30) primary key,
descripcio VARCHAR(30),
hores_contracte int,
sou_base DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS empleat(
dni_empleat VARCHAR(9) NOT NULL primary key,
constraint FK_Persona1 foreign key (dni_empleat) references persona (dni),
num_ss VARCHAR(12),
num_cc VARCHAR(24),
quantitat_sou_extra DECIMAL(10,2),
nom_carrec VARCHAR(30),
constraint FK_carrec_empleat1 foreign key (nom_carrec) references carrec_empleat (nom_carrec),
dni_cap VARCHAR(9) NOT NULL,
constraint FK_empleat1 foreign key (dni_cap) references empleat (dni_empleat),
lloc_naixement int,
constraint FK_localitat12 foreign key (lloc_naixement) references localitat (id_lloc)
);


CREATE TABLE IF NOT EXISTS bar(
id_bar int primary key NOT NULL CHECK (id_bar > 0),
nom VARCHAR(30),
aforament_maxim int,
te_exterior boolean,
ubicacio int NOT NULL CHECK (ubicacio > 0),
CONSTRAINT FK_Localitat foreign key (ubicacio) references localitat (id_lloc)
);

CREATE TABLE IF NOT EXISTS taula(
numero_taula int primary key,
id_bar int NOT NULL CHECK (id_bar > 0),
constraint FK_bar2 foreign key (id_bar) references bar (id_bar),
es_exterior boolean,
es_fumadors boolean,
num_cadires int
);

CREATE TABLE IF NOT EXISTS cliente(
dni_client VARCHAR(9) primary key,
constraint FK_persona2 foreign key (dni_client) references persona (dni),
es_major boolean
);


CREATE TABLE IF NOT EXISTS client_taula(
id_client_taula int primary key NOT NULL CHECK (id_client_taula > 0),
dni_client VARCHAR(9),
constraint FK_cliente3 foreign key (dni_client) references cliente (dni_client),
numero_taula int,
constraint FK_taula3 foreign key (numero_taula) references taula (numero_taula),
id_bar int NOT NULL CHECK (id_bar > 0),
constraint FK_bar3 foreign key (id_bar) references bar (id_bar),
es_fumador boolean DEFAULT false,
data_hora_arribada datetime,
data_hora_sortida datetime,
ha_pagat boolean
);
CREATE TABLE IF NOT EXISTS comanda_tapes(
id_tapa int NOT NULL CHECK (id_tapa > 0),
constraint FK_tapa4 foreign key (id_tapa) references tapa (id_tapa),
id_bar int NOT NULL CHECK (id_bar > 0),
constraint FK_bar4 foreign key (id_bar) references bar (id_bar),
id_client_taula int NOT NULL CHECK (id_client_taula > 0),
constraint FK_client_taula4 foreign key (id_client_taula) references client_taula (id_client_taula),
data_hora_comanda datetime,
quantitat int NOT NULL
);
CREATE TABLE IF NOT EXISTS comanda_begudes(
id_beguda int NOT NULL CHECK (id_beguda > 0),
constraint FK_beguda5 foreign key (id_beguda) references beguda (id_beguda),
id_bar int NOT NULL CHECK (id_bar > 0),
constraint FK_bar5 foreign key (id_bar) references bar (id_bar),
id_client_taula int NOT NULL CHECK (id_client_taula > 0),
constraint FK_client_taula5 foreign key (id_client_taula) references client_taula (id_client_taula),
data_hora_comanda datetime,
quantitat int
);

CREATE TABLE IF NOT EXISTS carta_begudes (
id_beguda INT NOT NULL CHECK (id_beguda > 0),
CONSTRAINT FK_beguda8 FOREIGN KEY (id_beguda)
REFERENCES beguda (id_beguda),
id_bar INT NOT NULL CHECK (id_bar > 0),
CONSTRAINT FK_bar8 FOREIGN KEY (id_bar)
REFERENCES bar (id_bar),
cost DECIMAL(10 , 2 ) NOT NULL,
pvp DECIMAL NOT NULL
);
CREATE TABLE IF NOT EXISTS carta_tapes(
id_tapa int NOT NULL CHECK (id_tapa > 0),
constraint FK_tapa10 foreign key (id_tapa) references tapa (id_tapa),
id_bar int NOT NULL CHECK (id_bar > 0),
constraint FK_bar10 foreign key (id_bar) references bar (id_bar),
cost DECIMAL(10,2) NOT NULL,
pvp DECIMAL NOT NULL
);

