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
    latitude VARCHAR(12),
    longitude VARCHAR(12),
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
	   ('Stefanini', '78945612365478', '11955936541'),
	   ('C6 Bank', '88888888888888', '11940872213'),
	   ('Sem Parar', '74125896369852', '11978642892'),
	   ('Minsait', '99999999999999', '11955936550');

CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
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

CREATE VIEW TopBairrosCrimes AS
SELECT 
    b.nome AS Bairro, 
    COUNT(c.idCrime) AS TotalCrimes
FROM 
    Bairro b
JOIN 
    Logradouro l ON b.idBairro = l.fkBairro
JOIN 
    Crime c ON l.idLogradouro = c.fkLogradouro
GROUP BY 
    b.idBairro, b.nome
ORDER BY 
    TotalCrimes DESC
LIMIT 5;

------------------------------------------------------------------------------

CREATE VIEW TopRuasCrimes AS
SELECT 
    l.nome AS Rua, 
    COUNT(c.idCrime) AS TotalCrimes
FROM 
    Logradouro l
JOIN 
    Crime c ON l.idLogradouro = c.fkLogradouro
WHERE 
    l.nome <> 'VEDAÇÃO DA DIVULGAÇÃO DOS DADOS RELATIVOS'
GROUP BY 
    l.idLogradouro, l.nome
ORDER BY 
    TotalCrimes DESC
LIMIT 10;



CREATE VIEW periodoCrime AS
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM dataOcorrencia) BETWEEN 0 AND 5 THEN 'Madrugada'
        WHEN EXTRACT(HOUR FROM dataOcorrencia) BETWEEN 6 AND 10 THEN 'Manhã'
        WHEN EXTRACT(HOUR FROM dataOcorrencia) BETWEEN 11 AND 11 THEN 'Tarde'
        WHEN EXTRACT(HOUR FROM dataOcorrencia) BETWEEN 12 AND 23 THEN 'Noite'
    END AS periodo,
    COUNT(*) * 1.0 / COUNT(DISTINCT DATE(dataOcorrencia)) AS valores
FROM Crime
GROUP BY periodo
ORDER BY FIELD(periodo, 'Madrugada', 'Manhã', 'Tarde', 'Noite');

----------------------------------------------

create view totalMeses as
SELECT 
    t1.tipoLocal as local,
    t1.ano,
    MONTHNAME(DATE(CONCAT(t1.ano, '-', t1.mes, '-01'))) AS mes,
    SUM(t1.totalCrimes) AS totalOcorrencias
FROM (
    SELECT 
        CASE 
            WHEN L.nome IN ('Casa', 'Apartamento', 'Casas', 'Moradia', 'Garagem coletiva de prédio', 
                             'Residência', 'Edícula/Fundos', 'Condomínio Residencial', 'Sítio', 'Chácara', 
                             'Chácaras', 'Loteamento') THEN 'Residencial'
            ELSE 'Comercial'
        END AS tipoLocal,
        YEAR(C.dataOcorrencia) AS ano,
        MONTH(C.dataOcorrencia) AS mes,
        COUNT(C.idCrime) AS totalCrimes
    FROM 
        Crime C
    JOIN 
        Local L ON C.fkLocal = L.idLocal
    WHERE 
        C.natureza IN ('Furto', 'Roubo')
        AND YEAR(C.dataOcorrencia) = YEAR(CURDATE()) 
        AND MONTH(C.dataOcorrencia) BETWEEN 1 AND 6  -- Meses de janeiro a junho
    GROUP BY 
        tipoLocal, YEAR(C.dataOcorrencia), MONTH(C.dataOcorrencia)
) AS t1
GROUP BY 
    t1.tipoLocal, t1.ano, t1.mes
ORDER BY 
    t1.tipoLocal, t1.ano, t1.mes;


SET lc_time_names = 'pt_BR';


