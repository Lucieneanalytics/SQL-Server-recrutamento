USE RH

-- ============================================================
-- Criação da Tabela : CONTRATO 
-- ============================================================

SELECT *
FROM sys.tables
WHERE name = 'CONTRATO';

CREATE TABLE contrato (
id_contrato SMALLINT IDENTITY(1,1) PRIMARY KEY,
tipo_contrato VARCHAR (50) NOT NULL 
);

-- ============================================================
-- Inserir dados  : CONTRATO 
-- ============================================================

INSERT INTO contrato (tipo_contrato) VALUES
('Determinado'),
('Indeterminado'),
('Temporario'),
('Estagio'),
('Aprendiz'),
('Autonomo'),
('PJ');

SELECT * FROM contrato;

