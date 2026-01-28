USE RH
GO

--TABELA: Fonte de recrutamento

--  Criação da tabela
CREATE TABLE fonte_recrutamento (
id_fonte_recrutamento SMALLINT IDENTITY(1,1) PRIMARY KEY,
descricao VARCHAR (50) NOT NULL 
);

-- Inserção dos dados fixos
INSERT INTO fonte_recrutamento (descricao) VALUES 
('LinkedIn'),
('Indeed'),
('Glassdoor'),
('Hunting'),
('Indicações de Funcionários'),
('Agências de Recrutamento'),
('Feiras de Emprego'),
('Redes Sociais (Facebook, Instagram, etc.)'),
('Nossa página de carreira'),
('Universidade'),
('Pipe'),
('GitHub'),
('Meetup'),
('Bootcamps'),
('Hackathons');

--Analise do Resultado 
SELECT * FROM fonte_recrutamento
