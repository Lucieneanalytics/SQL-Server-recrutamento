USE RH
GO

--  Criação da tabela : MODELO DE TRABALHO

  
CREATE TABLE modelo_de_trabalho(
id_modelo_trabalho SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(25) NOT NULL
);

    -- Inserção dos dados fixos

    INSERT INTO modelo_de_trabalho (descricao) VALUES
    ('Presencial'),
    ('Híbrido'),
    ('Remoto');


    --Analise do Resultado 
    SELECT * FROM modelo_de_trabalho
