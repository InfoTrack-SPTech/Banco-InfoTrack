CREATE DATABASE InfoTrack;
USE InfoTrack;

CREATE TABLE Zona (
    idZona INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE Bairro (
    idBairro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    fkZona INT NOT NULL,
    FOREIGN KEY (fkZona) REFERENCES Zona(idZona)
);

CREATE TABLE Logradouro (
    idLogradouro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cep VARCHAR(9),
    numero VARCHAR(10),
    fkBairro INT NOT NULL,
    FOREIGN KEY (fkBairro) REFERENCES Bairro(idBairro)
);

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cnpj CHAR(14) NOT NULL,
    telefone CHAR(15)
);

CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE Usuario (
    idUsuario INT,
    nome VARCHAR(45) NOT NULL,
    senha VARCHAR(60) NOT NULL, 
    telefone VARCHAR(15),        
    fkCargo INT NOT NULL,
    FOREIGN KEY (fkCargo) REFERENCES Cargo(idCargo),
    fkEmpresa INT NOT NULL,
    PRIMARY KEY (idUsuario, fkEmpresa),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

ALTER TABLE Usuario MODIFY COLUMN idUsuario INT auto_increment;

CREATE TABLE Local (
    idLocal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE Crime (
    idCrime INT AUTO_INCREMENT PRIMARY KEY,
    natureza VARCHAR(45) ,
    dataOcorrencia DATETIME,
    descricao VARCHAR(255),      
    fkLogradouro INT NOT NULL,
    fkLocal INT NOT NULL,
    FOREIGN KEY (fkLogradouro) REFERENCES Logradouro(idLogradouro),
    FOREIGN KEY (fkLocal) REFERENCES Local(idLocal)
);

CREATE TABLE Lembrete (
    fkUsuario INT NOT NULL,
    fkEmpresa INT NOT NULL,
    fkCrime INT NOT NULL,
    Parametro1 VARCHAR(45),
    Parametro2 DOUBLE,
    PRIMARY KEY (fkUsuario, fkEmpresa, fkCrime),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkCrime) REFERENCES Crime(idCrime)
);

