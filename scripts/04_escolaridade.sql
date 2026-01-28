USE RH
GO

============================================================
-TABELA: Escolaridade 

--  Criação da tabela
CREATE TABLE escolaridade(
id_escolaridade SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- Inserção dos dados fixos

INSERT INTO escolaridade (descricao) VALUES
('Ensino Fundamental Incompleto'),
('Ensino Fundamental Completo'),
('Ensino Médio Incompleto'),
('Ensino Médio Completo'),
('Técnico'),
('Graduação Incompleta'),
('Graduação Completa'),
('Pós-Graduação Incompleta'),
('Pós-Graduação Completa'),
('MBA'),
('Mestrado'),
('Doutorado');

--Analise do Resultado 
SELECT * FROM escolaridade 
