CREATE DATABASE InfoTrack;
USE InfoTrack;

CREATE TABLE Zona (
    idZona INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Bairro (
    idBairro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    fkZona INT,
    FOREIGN KEY (fkZona) REFERENCES Zona(idZona)
);

CREATE TABLE Logradouro (
    idLogradouro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cep VARCHAR(9),
    numero VARCHAR(10),
    fkBairro INT,
    FOREIGN KEY (fkBairro) REFERENCES Bairro(idBairro)
);

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cnpj CHAR(14),
    telefone CHAR(15),
    fkLogradouro INT,
    FOREIGN KEY (fkLogradouro) REFERENCES Logradouro(idLogradouro)
);

CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    senha VARCHAR(60) NOT NULL, 
    telefone VARCHAR(15),        
    fkCargo INT,
    FOREIGN KEY (fkCargo) REFERENCES Cargo(idCargo)
);

CREATE TABLE Local (
    idLocal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Crime (
    idCrime VARCHAR(45) PRIMARY KEY,
    natureza VARCHAR(45) NOT NULL,
    dataOcorrencia DATETIME NOT NULL,
    descricao VARCHAR(255),      
    fkLogradouro INT,
    fkLocal INT,
    FOREIGN KEY (fkLogradouro) REFERENCES Logradouro(idLogradouro),
    FOREIGN KEY (fkLocal) REFERENCES Local(idLocal)
);

CREATE TABLE Lembrete (
    fkCrime VARCHAR(45),
    fkUsuario INT,
    descricao TEXT,          
    PRIMARY KEY (fkCrime, fkUsuario),
    FOREIGN KEY (fkCrime) REFERENCES Crime(idCrime),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);