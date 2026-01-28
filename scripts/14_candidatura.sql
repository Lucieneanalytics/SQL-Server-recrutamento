USE RH
go

---Criação da tabela: candiatura 
  
CREATE TABLE candidatura (
    id_candidatura SMALLINT IDENTITY(500,1) PRIMARY KEY,
    id_candidato SMALLINT NOT NULL,
    id_vaga SMALLINT NOT NULL,
    data_aplicacao DATE NULL, -- pode ser NULL se desejar, ajuste conforme necessidade
    id_status_candidatura SMALLINT NOT NULL,
    id_fonte_recrutamento SMALLINT NOT NULL,

    -- Chaves estrangeiras com nomes
    CONSTRAINT fk_cand_candidato FOREIGN KEY (id_candidato)
        REFERENCES candidato(id_candidato),

    CONSTRAINT fk_cand_vaga FOREIGN KEY (id_vaga)
        REFERENCES vagas(id_vaga),

    CONSTRAINT fk_cand_status FOREIGN KEY (id_status_candidatura)
        REFERENCES status_candidatura(id_status_candidatura),

    CONSTRAINT fk_cand_fonte_2 FOREIGN KEY (id_fonte_recrutamento)
        REFERENCES fonte_recrutamento(id_fonte_recrutamento)
);

--INSERÇÃO DA CANDIDATURASS

SET NOCOUNT ON;

DECLARE @v_cand_id SMALLINT = 2000; 
DECLARE @v_vaga_id SMALLINT;
DECLARE @v_status_id SMALLINT;
DECLARE @v_fonte_id SMALLINT;
DECLARE @v_data_abertura DATE;
DECLARE @v_data_fechamento DATE;
DECLARE @v_senioridade_cand SMALLINT;
DECLARE @v_data_final_inscricao DATE;

WHILE @v_cand_id <= 5999
BEGIN
    BEGIN TRY
        -- 1. Pega os dados do candidato
        SELECT 
            @v_senioridade_cand = id_nivel_senioridade, 
            @v_fonte_id = id_fonte_recrutamento 
        FROM candidato 
        WHERE id_candidato = @v_cand_id;

        -- 2. Sorteia uma vaga compatível
      
        SELECT TOP 1 
            @v_vaga_id = id_vaga, 
            @v_data_abertura = data_abertura,
            @v_data_fechamento = data_fechamento 
        FROM vagas 
        WHERE 
            ((@v_senioridade_cand IN (500, 501) AND id_nivel_senioridade = @v_senioridade_cand)
            OR 
            (@v_senioridade_cand >= 502 AND id_nivel_senioridade >= 502))
        ORDER BY NEWID();

        -- 3. Define a data limite , Se não fechou, a data do script
        SET @v_data_final_inscricao = ISNULL(@v_data_fechamento, '2026-01-03');

        -- 4. Status
        SET @v_status_id = CASE 
            WHEN RAND() < 0.6 THEN 1 
            WHEN RAND() < 0.8 THEN (ABS(CHECKSUM(NEWID())) % 3) + 2 
            ELSE (ABS(CHECKSUM(NEWID())) % 3) + 5 
        END;

        -- 5. Inserção
        IF @v_vaga_id IS NOT NULL
        BEGIN
            INSERT INTO candidatura (id_candidato, id_vaga, data_aplicacao, id_status_candidatura, id_fonte_recrutamento)
            VALUES (
                @v_cand_id, 
                @v_vaga_id, 
                DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % (DATEDIFF(DAY, @v_data_abertura, @v_data_final_inscricao) + 1)), @v_data_abertura),
                @v_status_id, 
                @v_fonte_id
            );
        END

    END TRY
    BEGIN CATCH
        -- Silencia erros de duplicidade e continua
    END CATCH

    SET @v_cand_id = @v_cand_id + 1;
    SET @v_vaga_id = NULL; 
END

---Resultado 
SELECT *
FROM candidatura
