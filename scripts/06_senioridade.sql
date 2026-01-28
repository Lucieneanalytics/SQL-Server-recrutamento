USE RH
GO

--TABELA: senioridade 

CREATE TABLE senioridade (
    id_senioridade SMALLINT IDENTITY(500,1) PRIMARY KEY,
    descricao_senioridade VARCHAR(50) NOT NULL,
    nivel_ordem VARCHAR(50) NOT NULL,
    salario_minimo DECIMAL(10,2) NOT NULL,
    salario_medio DECIMAL(10,2) NOT NULL,
    salario_maximo DECIMAL(10,2) NOT NULL
);

INSERT INTO senioridade (descricao_senioridade, nivel_ordem, salario_minimo, salario_medio, salario_maximo) VALUES
('Aprendiz', 'Aprendiz', 1500.00, 1500.00, 1500.00),
('Estagiário', 'Estagiário', 2100.00, 2100.00, 2100.00),
('Júnior', 'Júnior 1', 3000.00, 3500.00, 3650.00),
('Júnior', 'Júnior 2', 4450.00, 4500.00, 4600.00),
('Júnior', 'Júnior 3', 5400.00, 5500.00, 5700.00),
('Júnior', 'Júnior 4', 6400.00, 6700.00, 7000.00),
('Pleno', 'Pleno 1', 6500.00, 6700.00, 6900.00),
('Pleno', 'Pleno 2', 7700.00, 7900.00, 8100.00),
('Pleno', 'Pleno 3', 8900.00, 9200.00, 9500.00),
('Pleno', 'Pleno 4', 10200.00, 10800.00, 10900.00),
('Sênior', 'Sênior 1', 11500.00, 11750.00, 11900.00),
('Sênior', 'Sênior 2', 12000.00, 12300.00, 12400.00),
('Sênior', 'Sênior 3', 12900.00, 13150.00, 13400.00),
('Sênior', 'Sênior 4', 14200.00, 14800.00, 14950.00),
('Especialista', 'Especialista 1', 15000.00, 15300.00, 15400.00),
('Especialista', 'Especialista 2', 16100.00, 16700.00, 17300.00),
('Especialista', 'Especialista 3', 17700.00, 18100.00, 18500.00),
('Especialista', 'Especialista 4', 19800.00, 20600.00, 21400.00),
('Tech Lead', 'Tech Lead 1', 15000.00, 15300.00, 15400.00),
('Tech Lead', 'Tech Lead 2', 16100.00, 16700.00, 17300.00),
('Tech Lead', 'Tech Lead 3', 17700.00, 18100.00, 18500.00),
('Coordenador', 'Coordenador 1', 14500.00, 15000.00, 15500.00),
('Coordenador', 'Coordenador 2', 15500.00, 16000.00, 16500.00),
('Coordenador', 'Coordenador 3', 16500.00, 17000.00, 17500.00),
('Gerente', 'Gerente 1', 21000.00, 21750.00, 22500.00),
('Gerente', 'Gerente 2', 23000.00, 23750.00, 24500.00),
('Gerente', 'Gerente 3', 25000.00, 25750.00, 26500.00),
('Diretor', 'Diretor', 28000.00, 29750.00, 30500.00);

--Analise do Resultado 
SELECT * FROM senioridade
