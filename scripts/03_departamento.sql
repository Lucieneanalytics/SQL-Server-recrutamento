USE RH
GO

IF OBJECT_ID('departamento', 'U') IS NOT NULL
    DROP TABLE departamento;

TRUNCATE TABLE departamento
-- ============================================================
-- Script de criação da tabela de Domínio
-- TABELA: Departamento 
-- ============================================================

-- Criação da tabela
CREATE TABLE departamento (
    id_departamento SMALLINT IDENTITY(1,1) PRIMARY KEY,  
    nome_departamento VARCHAR(50) NOT NULL
);

--Inserção dos dados fixos 
INSERT INTO departamento (nome_departamento) VALUES
('Desenvolvimento de Software'),
('Infraestrutura'),
('Segurança da Informação'),
('Gestão de Projetos'),
('Qualidade'),
('Banco de Dados'),
('Recursos Humanos'),
('Financeiro'),
('Marketing'),
('Vendas'),
('Compliance'),
('Jurídico');


--Analise do Resultado 
SELECT * FROM departamento;
GO
