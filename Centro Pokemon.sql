CREATE DATABASE IF NOT EXISTS db_centro_pokemon;
USE db_centro_pokemon;

-- Tabela endereço 
create table if not exists tbEndereco (
id_endereco INT NOT NULL AUTO_INCREMENT,
regiao VARCHAR(80) NOT NULL,
logradouro VARCHAR(80) NOT NULL,
numero INT NOT NULL,
complemento VARCHAR(80) NULL,
bairro VARCHAR(80) NOT NULL,
cidade VARCHAR(80) NOT NULL,
rota VARCHAR(80) NULL,
PRIMARY KEY(id_endereco)
) ENGINE = InnoDB;

-- Tabela treinador
CREATE TABLE IF NOT EXISTS tbTreinador(
id_treinador INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
data_nascimento DATE NOT NULL,
id_endereco INT NOT NULL, 
PRIMARY KEY(id_treinador),
CONSTRAINT fk_treinador_endereco
	FOREIGN KEY (id_endereco)
	REFERENCES tbendereco (id_endereco)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela telefone
CREATE TABLE IF NOT EXISTS tbTelefone(
id_telefone INT NOT NULL AUTO_INCREMENT,
numero INT NOT NULL,
DDD INT NOT NULL,
id_treinador INT NOT NULL,
PRIMARY KEY (id_telefone),
CONSTRAINT fk_telefone_treinador
	FOREIGN KEY (id_treinador)
    REFERENCES tbtreinador (id_treinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela pokemon
CREATE TABLE IF NOT EXISTS tbPokemon(
id_pokemon INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
especie VARCHAR(80) NOT NULL,
natureza VARCHAR(80) NOT NULL,
hp_total INT NOT NULL,
nivel INT NOT NULL,
tipo_primario VARCHAR(80) NOT NULL,
tipo_secundario VARCHAR(80) NULL,
id_treinador INT NOT NULL,
PRIMARY KEY (id_pokemon),
CONSTRAINT fk_pokemon_treinador
	FOREIGN KEY (id_treinador)
    REFERENCES tbtreinador (id_treinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela centro pokemon
CREATE TABLE IF NOT EXISTS tbCentro_Pokemon(
id_centro INT NOT NULL AUTO_INCREMENT,
codigo_pia INT NOT NULL,
id_endereco INT NOT NULL,
PRIMARY KEY (id_centro),
CONSTRAINT fk_centro_endereco
	FOREIGN KEY (id_centro)
    REFERENCES tbEndereco (id_endereco)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela urbano
CREATE TABLE IF NOT EXISTS tbUrbano(
id_centro INT NOT NULL,
PRIMARY KEY (id_centro),
CONSTRAINT fk_urbano_centro
	FOREIGN KEY (id_centro)
    REFERENCES tbcentro_pokemon (id_centro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela selvagem
CREATE TABLE IF NOT EXISTS tbSelvagem(
id_centro INT NOT NULL,
PRIMARY KEY (id_centro),
CONSTRAINT fk_selvagem_centro
	FOREIGN KEY (id_centro)
    REFERENCES tbcentro_pokemon (id_centro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela enfermeira
CREATE TABLE IF NOT EXISTS tbEnfermeira(
id_enfermeira INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
senha_hash VARCHAR(80) NOT NULL,
id_centro INT NOT NULL,
id_endereco INT NOT NULL,
PRIMARY KEY (id_enfermeira),
CONSTRAINT fk_enfermeira_centro
	FOREIGN KEY (id_centro)
    REFERENCES tbcentro_pokemon (id_centro)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT fk_enfermeira_endereco
	FOREIGN KEY (id_endereco)
    REFERENCES tbendereco (id_endereco)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)ENGINE = InnoDB;

-- Tabela dependente
CREATE TABLE IF NOT EXISTS tbDependente (
id_dependente INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
id_enfermeira INT NOT NULL,
PRIMARY KEY (id_dependente),
CONSTRAINT fk_dependente_enfermeira
	FOREIGN KEY (id_enfermeira)
	REFERENCES tbEnfermeira (id_enfermeira)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela associativa consulta
CREATE TABLE IF NOT EXISTS tbConsulta (
data_hora DATETIME NOT NULL,
descricao VARCHAR(1000) NOT NULL,
hp_atual INT NOT NULL,
condicao VARCHAR(80) NOT NULL,
id_pokemon INT NOT NULL,
id_centro INT NOT NULL,
id_enfermeira INT NOT NULL,
PRIMARY KEY (data_hora, id_pokemon, id_centro, id_enfermeira),
CONSTRAINT fk_consulta_pokemon
	FOREIGN KEY (id_pokemon)
	REFERENCES tbPokemon (id_pokemon)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
CONSTRAINT fk_consulta_centro
	FOREIGN KEY (id_centro)
	REFERENCES tbCentro_Pokemon (id_centro)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
CONSTRAINT fk_consulta_enfermeira
	FOREIGN KEY (id_enfermeira)
	REFERENCES tbEnfermeira (id_enfermeira)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
) ENGINE = InnoDB;

-- insert
-- Tabela endereco
INSERT INTO tbEndereco (logradouro, bairro, cidade, complemento, numero, regiao, rota) 
VALUES ('Avenida Pallet Town, 
Numero 10', 
'Bairro do Centro', 
'Cidade de Pallet', 
'Proximo ao laboratorio do Professor Oak', 
10, 
'Regiao de Kanto', 
NULL);

INSERT INTO tbEndereco (logradouro, bairro, cidade, complemento, numero, regiao, rota) 
VALUES ('Estrada da Rota Um, Sem Numero', 
'Bairro da Floresta', 
'Cidade de Viridian Outskirts', 
'Kilometro 4 da via principal', 
0, 
'Regiao de Kanto', 
1);

INSERT INTO tbEndereco (logradouro, bairro, cidade, complemento, numero, regiao, rota) 
VALUES ('Praca da Alvorada, Numero 500', 'Bairro Comercial', 'Cidade de Celadon', 'Ao lado do Shopping de Celadon', 500, 'Regiao de Kanto', NULL);

INSERT INTO tbEndereco (logradouro, bairro, cidade, complemento, numero, regiao, rota) 
VALUES ('Trilha da Floresta de Viridian', 'Área de Preservacao', 'Floresta Fechada', 'Proximo ao lago dos Gyarados', 0, 'Regiao de Kanto', 2);

-- Tabela treinador
INSERT INTO tbTreinador (nome, data_nascimento, id_endereco) 
VALUES ('Ash Ketchum da Cidade de Pallet', 
'1997-04-01', 
1);

INSERT INTO tbTreinador (nome, data_nascimento, id_endereco) 
VALUES ('Gary Oak da Cidade de Pallet', '1997-04-02', 1);

-- Tabela telefone
INSERT INTO tbTelefone (numero, ddd, id_treinador) 
VALUES (988887777, 11, 1);

INSERT INTO tbTelefone (numero, ddd, id_treinador) 
VALUES (977776666, 11, 2);

-- Tabela pokemon
INSERT INTO tbPokemon (nome, especie, natureza, hp_total, nivel, tipo_primario, tipo_secundario, id_treinador) 
VALUES ('Pikachu do Ash', 
'Mouse Pokemon', 'Jolly', 120, 25, 'Electric', NULL, 1);

INSERT INTO tbPokemon (nome, especie, natureza, hp_total, nivel, tipo_primario, tipo_secundario, id_treinador) 
VALUES ('Charizard do Ash', 'Flame Pokemon', 'Adamant', 280, 50, 'Fire', 'Flying', 1);

-- Tabela centro pokemon
INSERT INTO tbCentro_Pokemon (codigo_pia, id_endereco) 
VALUES (1001, 1);

INSERT INTO tbCentro_Pokemon (codigo_pia, id_endereco) 
VALUES (1002, 2);

INSERT INTO tbCentro_Pokemon (id_centro, codigo_pia, id_endereco) 
VALUES (3, 1003, 3);

INSERT INTO tbCentro_Pokemon (id_centro, codigo_pia, id_endereco) 
VALUES (4, 1004, 4);

-- Tabela urbano
INSERT INTO tbUrbano (id_centro) VALUES (1);
INSERT INTO tbUrbano (id_centro) VALUES (3);

-- Tabela selvagem
INSERT INTO tbSelvagem (id_centro) VALUES (2);
INSERT INTO tbSelvagem (id_centro) VALUES (4);

-- Tabela enfermeira
INSERT INTO tbEnfermeira (nome, senha_hash, id_centro, id_endereco) 
VALUES ('Nurse Joy de Pallet Town', 'HashCriptografadoGeradoPeloSistemaParaAjoy12345678', 1, 1);

INSERT INTO tbEnfermeira (nome, senha_hash, id_centro, id_endereco) 
VALUES ('Nurse Joy de Viridian City', 'SenhaSeguraComAlgoritmoDeHashComSaltParaSeguranca99', 2, 2);

-- Tabela dependente
INSERT INTO tbDependente (nome, id_enfermeira) 
VALUES ('Joyzinha Junior de Pallet', 1);

INSERT INTO tbDependente (nome, id_enfermeira) 
VALUES ('Joyzinha Sobrinha de Viridian', 2);

-- Tabela consulta
INSERT INTO tbConsulta (data_hora, descricao, hp_atual, condicao, id_pokemon, id_centro, id_enfermeira)
VALUES ('2026-06-17 10:00:00', 'Pokemon deu entrada exausto apos batalha na Rota 1. Aplicado restaurador de HP.', 45, 'Normal', 1, 1, 1);

INSERT INTO tbConsulta (data_hora, descricao, hp_atual, condicao, id_pokemon, id_centro, id_enfermeira)
VALUES ('2026-06-17 11:30:00', 'Pokemon envenenado por um Beedrill selvagem. Administrado Antidoto e repouso.', 120, 'Poison', 2, 2, 2);