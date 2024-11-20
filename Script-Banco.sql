CREATE DATABASE InfoTrack;
USE InfoTrack;

CREATE TABLE Bairro (
    idBairro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Logradouro (
    idLogradouro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    numero VARCHAR(10),
    latitude varchar(12),
    longitude varchar(12),
    fkBairro INT,
    FOREIGN KEY (fkBairro) REFERENCES Bairro(idBairro)
);

CREATE TABLE Local (
    idLocal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Crime (
    idCrime INT AUTO_INCREMENT PRIMARY KEY,
    natureza VARCHAR(100) ,
    dataOcorrencia DATETIME,
    artigo VARCHAR(50),      
    fkLogradouro INT,
    fkLocal INT,
    FOREIGN KEY (fkLogradouro) REFERENCES Logradouro(idLogradouro),
    FOREIGN KEY (fkLocal) REFERENCES Local(idLocal)
);

CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    cnpj CHAR(14) NOT NULL,
    telefone CHAR(15)
);

INSERT INTO Empresa (nome, cnpj, telefone)
VALUES ('InfoTrack', '12345678000199', '11999999999'),
('Minsait', '12345678000199', '11955936541'),
('Sem Parar', '12345678000199', '11978642892'),
('C6 Bank', '99999999999999', '11940872213'),
('Stefanine', '78945612365478', '11955936550');

CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) CONSTRAINT chk_nome CHECK (nome IN ('Analista', 'Gerente', 'Administrador'))
);

ALTER TABLE Cargo ADD CONSTRAINT chk_nome_cargo CHECK (nome IN ('Analista', 'Gerente', 'Administrador'));
INSERT INTO Cargo (nome) VALUES ('Analista'), ('Gerente'), ('Administrador');

CREATE TABLE Usuario (
    idUsuario INT,
    email VARCHAR(80) NOT NULL,
    nome VARCHAR(80) NOT NULL,
    senha VARCHAR(60) NOT NULL, 
    telefone VARCHAR(15),        
    fkCargo INT NOT NULL,
    FOREIGN KEY (fkCargo) REFERENCES Cargo(idCargo),
    fkEmpresa INT NOT NULL,
    PRIMARY KEY (idUsuario, fkEmpresa),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

ALTER TABLE Usuario MODIFY COLUMN idUsuario INT auto_increment;

INSERT INTO Usuario (email, nome, senha, telefone, fkCargo, fkEmpresa)
VALUES 
    ('matheusFerro@infotrack.com', 'Matheus Ferro', 'Matheus10', '11999911111', 3, 1),
    ('brunoGomes@infotrack.com', 'Bruno Gomes', 'Bruno20', '11999922222', 3, 1),
    ('biancaRodrigues@infotrack.com', 'Bianca Rodrigues', 'Bianca30', '11999933333', 3, 1),
    ('alejandroCastor@infotrack.com', 'Alejandro Castor', 'Alejandro40', '11999944444', 3, 1),
    ('cintiaOhara@infotrack.com', 'Cintia Ohara', 'Cintia50', '11999955555', 3, 1);

CREATE TABLE Recomendacao (
    idRecomendacao INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    descricao TEXT,
    tipoRecomendacao VARCHAR(50),
    dataGeracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geradoPor VARCHAR(50) DEFAULT 'IA',
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);