
USE RH
GO

-- ============================================================
-- TABELA: Nivel de Inglês 
-- ============================================================

--  Criação da tabela
CREATE TABLE nivel_ingles(
    id_nivel_ingles SMALLINT IDENTITY(1,1) PRIMARY KEY,  
    descricao VARCHAR(50) NOT NULL                     
);

-- Inserção dos dados fixos
INSERT INTO nivel_ingles (descricao) VALUES
('A1 - Iniciante'),
('A2 - Elementar'),
('B1 - Intermediário'),
('B2 - Intermediário Avançado'),
('C1 - Avançado'),
('C2 - Proficiência');

--Analise do Resultado 
SELECT * FROM nivel_ingles;

