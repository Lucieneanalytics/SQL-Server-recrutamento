USE RH
GO

---Criação da Tabela : Status_candidatura
  
CREATE TABLE status_candidatura (
    id_status_candidatura SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);


-- Inserção dos dados fixos
INSERT INTO status_candidatura (descricao) VALUES
('Novo Candidato'),
('Triagem'),
('Teste'),
('Shortlist'),
('Entrevista com RH'),
('Entrevista Tecnica'),
('Entrevista com Gestor'),
('Oferta'),
('Contratado'),
('Declinou'),
('Reprovado');

SELECT * FROM status_candidatura;
