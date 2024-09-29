CREATE DATABASE InfoTrack;
USE InfoTrack;

CREATE TABLE Zona (
    idZona INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Bairro (
    idBairro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    idZona INT,
    FOREIGN KEY (idZona) REFERENCES Zona(idZona)
);

CREATE TABLE Logradouro (
    idLogradouro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cep VARCHAR(9),
    numero VARCHAR(10),
    idBairro INT,
    FOREIGN KEY (idBairro) REFERENCES Bairro(idBairro)
);

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cnpj CHAR(14),
    telefone CHAR(15),
    idLogradouro INT,
    FOREIGN KEY (idLogradouro) REFERENCES Logradouro(idLogradouro)
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
    idCargo INT,
    FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
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
    idLogradouro INT,
    idLocal INT,
    FOREIGN KEY (idLogradouro) REFERENCES Logradouro(idLogradouro),
    FOREIGN KEY (idLocal) REFERENCES Local(idLocal)
);

CREATE TABLE Lembrete (
    idCrime VARCHAR(45),
    idUsuario INT,
    descricao TEXT,          
    PRIMARY KEY (idCrime, idUsuario),
    FOREIGN KEY (idCrime) REFERENCES Crime(idCrime),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);


CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    telefone VARCHAR(12),
    idCargo INT,
    FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
);

CREATE TABLE Local (
    idLocal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Crime (
    idCrime VARCHAR(45) PRIMARY KEY,
    natureza VARCHAR(45) NOT NULL,
    dataOcorrencia DATETIME NOT NULL,
    descricao VARCHAR(100),
    idLogradouro INT,
    idLocal INT,
    FOREIGN KEY (idLogradouro) REFERENCES Logradouro(idLogradouro),
    FOREIGN KEY (idLocal) REFERENCES Local(idLocal)
);

CREATE TABLE Lembrete (
    idCrime VARCHAR(45),
    idUsuario INT,
    descricao TEXT(50),
    PRIMARY KEY (idCrime, idUsuario),
    FOREIGN KEY (idCrime) REFERENCES Crime(idCrime),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);
