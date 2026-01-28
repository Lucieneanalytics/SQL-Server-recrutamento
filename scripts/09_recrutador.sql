USE RH
GO

--TABELA: Recrutador  

CREATE TABLE recrutador (
    id_recrutador SMALLINT IDENTITY(1,1) PRIMARY KEY,
    nome_recrutador VARCHAR(50)
);

-- Inserção dos dados fixos
INSERT INTO recrutador (nome_recrutador) VALUES
('Robson Jose'),
('Larissa Paula'),
('Gabriel Viana'),
('Rafael Ribeiro'),
('Eliza Albuquerque'),
('Mariana Costa'),
('Fabiano Ferreira'),
('Marisa Martins');

-- Análise do Resultado 
SELECT * FROM recrutador;

