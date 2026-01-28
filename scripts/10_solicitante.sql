USE RH
go

---Criação da Tabela : Solicitante 
  
CREATE TABLE solicitante (
    id_solicitante INT IDENTITY(1,1) PRIMARY KEY,
    nome_solicitante VARCHAR(100) NOT NULL,
    id_departamento SMALLINT NOT NULL,
    CONSTRAINT fk_solicitante_departamento FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

---Inserção de dados

INSERT INTO solicitante (nome_solicitante, id_departamento) VALUES
('João Pereira', 114),
('Maria Fernandes', 115),
('Carlos Almeida', 116),
('Fernanda Rocha', 117),
('Ricardo Martins', 118),
('Ana Carolina Souza', 119),
('Bruno Henrique Lima', 120),
('Gabriela Mendes', 121),
('Felipe Costa', 122),
('Vanessa Martins', 123),
('Thiago Ferreira', 124),
('Mariana Oliveira', 125),
('André Barbosa', 114),
('Patrícia Rocha', 115),
('Eduardo Carvalho', 116),
('Camila Santos', 117),
('Rafael Lima', 118),
('Juliana Almeida', 119),
('Leonardo Souza', 120),
('Larissa Fernandes', 121),
('Gustavo Ribeiro', 122),
('Bianca Martins', 123),
('Matheus Pereira', 124),
('Camila Rodrigues', 125),
('Vinícius Alves', 114);

--Analise do Resultado 
SELECT * FROM solicitante
