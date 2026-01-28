USE RH
go

  --- Criação da Tebela: CANDIDATO
  
CREATE TABLE candidato (
    id_candidato SMALLINT IDENTITY(2000,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,

    genero VARCHAR(50) NOT NULL CHECK (
        genero IN ('Feminino','Masculino','Não-binário','Prefiro não informar','Outro')
    ),

    etnia VARCHAR(50) NOT NULL CHECK (
        etnia IN ('Branca','Preta','Parda','Indígena','Amarela','Não informado')
    ),

    cidade_residencia VARCHAR(100),
    uf CHAR(2),

    id_escolaridade SMALLINT NOT NULL,
    curso_formacao VARCHAR(100),

    id_nivel_ingles SMALLINT NOT NULL,
    id_nivel_senioridade SMALLINT NOT NULL,

    pretensao_salarial DECIMAL(10,2),

    id_modelo_trabalho SMALLINT NOT NULL,
    id_tipo_contrato SMALLINT NOT NULL,

    disponibilidade_inicio DATE,

    id_fonte_recrutamento SMALLINT NOT NULL,

    data_cadastro DATE DEFAULT GETDATE(),
    
    CONSTRAINT fk_cand_escolaridade FOREIGN KEY (id_escolaridade)
        REFERENCES escolaridade(id_escolaridade),

    CONSTRAINT fk_cand_ingles FOREIGN KEY (id_nivel_ingles)
        REFERENCES nivel_ingles(id_nivel_ingles),

    CONSTRAINT fk_cand_senioridade FOREIGN KEY (id_nivel_senioridade)
        REFERENCES senioridade(id_senioridade),

    CONSTRAINT fk_cand_modelo FOREIGN KEY (id_modelo_trabalho)
        REFERENCES modelo_de_trabalho(id_modelo_trabalho),

    CONSTRAINT fk_cand_contrato FOREIGN KEY (id_tipo_contrato)
        REFERENCES contrato(id_contrato),

    CONSTRAINT fk_cand_fonte FOREIGN KEY (id_fonte_recrutamento)
        REFERENCES fonte_recrutamento(id_fonte_recrutamento)
);

--INSERÇÃO DE DADOS NA TABELA CANDIDATO 

SET NOCOUNT ON;
DECLARE @j INT = 1;
DECLARE @v_nome VARCHAR(100), @v_perfil INT;
DECLARE @v_id_senioridade_cand SMALLINT, @v_id_escolaridade_cand SMALLINT;
DECLARE @v_curso VARCHAR(100), @v_pretensao DECIMAL(10,2), @v_salario_base DECIMAL(10,2);
DECLARE @v_data_nasc_cand DATE;
DECLARE @v_data_base_inicio DATE = '20250102';

WHILE @j <= 4000
BEGIN
    BEGIN TRY
        -- Gerando Nome Real (VARCHAR)
        SET @v_nome = 
            CHOOSE((ABS(CHECKSUM(NEWID())) % 20) + 1, 'Lucas', 'Ana', 'Bruno', 'Carla', 'Diego', 'Fernanda', 'Gabriel', 'Helena', 'Igor', 'Juliana', 'Ricardo', 'Beatriz', 'Thiago', 'Vanessa', 'Leonardo', 'Camila', 'Rodrigo', 'Larissa', 'Marcelo', 'Aline') + ' ' +
            CHOOSE((ABS(CHECKSUM(NEWID())) % 20) + 1, 'Silva', 'Santos', 'Oliveira', 'Souza', 'Rodrigues', 'Ferreira', 'Alves', 'Pereira', 'Lima', 'Gomes', 'Costa', 'Ribeiro', 'Martins', 'Carvalho', 'Almeida', 'Lopes', 'Soares', 'Fernandes', 'Vieira', 'Barbosa');

        SET @v_perfil = CASE WHEN @j <= 400 THEN 1 WHEN @j <= 800 THEN 2 ELSE 3 END;

        -- Regras por Perfil
        IF @v_perfil = 1 -- Aprendiz
        BEGIN
            SET @v_id_escolaridade_cand = (ABS(CHECKSUM(NEWID())) % 6) + 1; 
            SET @v_curso = (CASE WHEN @v_id_escolaridade_cand <= 4 THEN 'Ensino Médio' ELSE 'Ensino Superior' END);
            SET @v_id_senioridade_cand = 500;
            SET @v_pretensao = 900 + (RAND() * 900); 
            SET @v_data_nasc_cand = DATEADD(DAY, - (5110 + (ABS(CHECKSUM(NEWID())) % 3285)), '2025-01-02');
        END
        ELSE IF @v_perfil = 2 -- Estagiário
        BEGIN
            SET @v_id_escolaridade_cand = 6; 
            SET @v_curso = 'Ensino Superior (Cursando)';
            SET @v_id_senioridade_cand = 501;
            SET @v_pretensao = 1500 + (RAND() * 1500); 
            SET @v_data_nasc_cand = DATEADD(DAY, - (6570 + (ABS(CHECKSUM(NEWID())) % 4380)), '2025-01-02');
        END
        ELSE -- Profissional (18 a 70 anos)
        BEGIN
            SET @v_id_escolaridade_cand = (ABS(CHECKSUM(NEWID())) % 6) + 7; 
            SET @v_id_senioridade_cand = (ABS(CHECKSUM(NEWID())) % 26) + 502; 
            SELECT @v_salario_base = ISNULL(salario_medio, 4500) FROM senioridade WHERE id_senioridade = @v_id_senioridade_cand;
            SET @v_pretensao = @v_salario_base * (1 + (RAND() * 0.20)); 
            SET @v_curso = ISNULL(CHOOSE((ABS(CHECKSUM(NEWID())) % 21) + 1, 'Administração', 'Banco de Dados', 'Gestão de RH', 'Gestão Financeira', 'Ciências Contábeis', 'Economia', 'Gestão Comercial', 'Logística', 'Marketing', 'Processos Gerenciais', 'Análise e Desenvolvimento de Sistemas', 'Ciência da Computação', 'Sistemas de Informação', 'Engenharia de Software', 'Gestão da TI', 'Redes de Computadores', 'Segurança da Informação', 'Inteligência Artificial', 'Ciência de Dados', 'Análise de Sistemas', 'Gestão de Projetos'), 'Administração');
            SET @v_data_nasc_cand = DATEADD(DAY, - (6570 + (ABS(CHECKSUM(NEWID())) % 18980)), '2025-01-02');
        END

        INSERT INTO candidato (nome, data_nascimento, genero, etnia, cidade_residencia, uf, id_escolaridade, curso_formacao, id_nivel_ingles, id_nivel_senioridade, pretensao_salarial, id_modelo_trabalho, id_tipo_contrato, disponibilidade_inicio, id_fonte_recrutamento, data_cadastro) 
        VALUES (
            @v_nome, @v_data_nasc_cand, 
            ISNULL(CHOOSE((ABS(CHECKSUM(NEWID())) % 5) + 1, 'Feminino', 'Masculino', 'Não-binário', 'Outro', 'Prefiro não informar'), 'Masculino'),
            ISNULL(CHOOSE((ABS(CHECKSUM(NEWID())) % 6) + 1, 'Branca', 'Preta', 'Parda', 'Indígena', 'Amarela', 'Não informado'), 'Parda'),
            'São Paulo', 'SP', @v_id_escolaridade_cand, @v_curso, (ABS(CHECKSUM(NEWID())) % 6) + 1, @v_id_senioridade_cand, ROUND(@v_pretensao, 2), (ABS(CHECKSUM(NEWID())) % 3) + 1, (ABS(CHECKSUM(NEWID())) % 7) + 1, DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 45), GETDATE()), (ABS(CHECKSUM(NEWID())) % 15) + 1, 
            DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 322), @v_data_base_inicio)
        );

        SET @j = @j + 1;
    END TRY
    BEGIN CATCH
        -- Em caso de erro, o loop tenta novamente a mesma posição @j
    END CATCH
END

___

SELECT *
FROM candidato
