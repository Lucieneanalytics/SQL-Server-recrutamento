USE RH
  go
  
-- ============================================================
-- Criação da Tabela : vagas
-- ============================================================

CREATE TABLE vagas (
    id_vaga SMALLINT IDENTITY(2000,1) PRIMARY KEY,
    id_cargo SMALLINT NOT NULL,
    id_departamento SMALLINT NOT NULL,
    id_recrutador SMALLINT NOT NULL,  
    cidade VARCHAR(100),
    uf CHAR(2),
    id_modelo_trabalho SMALLINT NOT NULL,
    id_nivel_ingles SMALLINT NOT NULL,
    id_nivel_senioridade SMALLINT NOT NULL,
    id_tipo_contrato SMALLINT NOT NULL,
    id_escolaridade SMALLINT NOT NULL,
    carga_horaria INT CHECK (carga_horaria IN (30,40)),
    status_vaga VARCHAR(30) NOT NULL CHECK (
        status_vaga IN ('Aberta','Em aprovação','Fechada','Congelada')
    ),
    data_abertura DATE NOT NULL,
    data_fechamento DATE NULL,
    quantidade_posicoes SMALLINT DEFAULT 1 CHECK (quantidade_posicoes > 0),
    id_fonte_divulgacao SMALLINT NULL,
    data_criacao DATE DEFAULT GETDATE(),
    id_solicitante INT NOT NULL,

    -- Chaves estrangeiras com nomes para facilitar manutenção
    CONSTRAINT fk_vagas_cargo FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    CONSTRAINT fk_vagas_departamento FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento),
    CONSTRAINT fk_vagas_recrutador FOREIGN KEY (id_recrutador) REFERENCES recrutador(id_recrutador),
    CONSTRAINT fk_vagas_modelo_trabalho FOREIGN KEY (id_modelo_trabalho) REFERENCES modelo_de_trabalho(id_modelo_trabalho),
    CONSTRAINT fk_vagas_nivel_ingles FOREIGN KEY (id_nivel_ingles) REFERENCES nivel_ingles(id_nivel_ingles),
    CONSTRAINT fk_vagas_senioridade FOREIGN KEY (id_nivel_senioridade) REFERENCES senioridade(id_senioridade),
    CONSTRAINT fk_vagas_tipo_contrato FOREIGN KEY (id_tipo_contrato) REFERENCES contrato(id_contrato),
    CONSTRAINT fk_vagas_escolaridade FOREIGN KEY (id_escolaridade) REFERENCES escolaridade(id_escolaridade),
    CONSTRAINT fk_vagas_fonte_divulgacao FOREIGN KEY (id_fonte_divulgacao) REFERENCES fonte_recrutamento(id_fonte_recrutamento),
    CONSTRAINT fk_vagas_solicitante FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante)
);

/* ========================================
Esqueci de incluir duas colunas importantes na tabela vagas
======================================== */



-- ============================================================
--  CRIAÇÃO DE COLUMA SALARIO MINIMO E MAXIMO
-- ============================================================

ALTER TABLE vagas 
ADD salario_vaga DECIMAL(10,2) NOT NULL DEFAULT 0;
ALTER TABLE vagas 
ADD salario_maximo DECIMAL(10,2) NOT NULL DEFAULT 0;

-- ============================================================
--  INSERÇÃO DE DADOS NA TABELA : VAGAS
-- ===========================================================

SET NOCOUNT ON;  -- usei essa regra para não exibir a mensagem "x linhas afetedas a cada inserção. Economiza memória do Banco de Dados 

DELETE FROM vagas; ---- Limpa a tabela antes de começar para evitar dados duplicados
  - Utilizei  esta variável como um mecanismo de contagem programada. 
-- Através do @i, eu gerencio as 900 iterações do loop, garantindo 
-- que cada regra de negócio seja aplicada individualmente a cada vaga..
DECLARE @i INT = 1;

-- variáveis de escopo local que atuarão como buffer de memória (temporário)
-- permitem que eu processe e valide as regras de negócio de cada vaga 
-- individualmente antes de realizar a inserção definitiva no banco de dados.

-- Estrutura de Relacionamentos (Chaves Estrangeiras)
DECLARE @v_id_cargo SMALLINT,
        @v_id_depto SMALLINT,
        @v_id_solicitante INT;

-- Definições de Perfil e Classificações
DECLARE @v_id_senioridade SMALLINT,
        @v_id_contrato SMALLINT,
        @v_id_escolaridade SMALLINT,
        @v_id_ingles SMALLINT;

-- Indicadores de Jornada e Status operacional
DECLARE @v_carga_horaria INT,
        @v_status VARCHAR(30);

-- Variáveis Financeiras (Cálculo de Faixas Salariais)
DECLARE @v_s_min DECIMAL(10,2),
        @v_s_max DECIMAL(10,2),
        @v_salario_final DECIMAL(10,2);

-- Controle Temporal e Motores de Aleatoriedade
DECLARE @v_data_abertura DATE,
        @v_data_fechamento DATE,
        @v_rand FLOAT;


-- início do loop de automação. 
-- repetir o processamento das regras de negócio até que eu atinja a meta 
-- de 900 registros inseridos com sucesso.
WHILE @i <= 900
BEGIN

    -- ============================================================
    -- BLOCO A: DEFINIÇÃO DO DEPARTAMENTO (Respeitando Percentuais)
    -- ============================================================
    
    -- 1. A Fatia dos Diretores (1% = 9 vagas)
    -- A Lógica: Como o loop começa no 1, as primeiras 9 voltas (1 a 9) caem aqui.
    -- O Departamento: O cálculo (% 12) + 114 sorteia um número entre 114 e 125. 
    -- Somente teve uma vaga de Diretor 
    IF @i <= 9 
        SET @v_id_depto = (ABS(CHECKSUM(NEWID())) % 12) + 114 --criação de um número aleatório grande e positivo para eu poder controlar depois com % e +

    -- 2. A Fatia "Core" (81% = 729 vagas)
    -- A Lógica: Da vaga nº 10 até a 738 (9 + 729 = 738), o script entra neste bloco.
    -- O Departamento: O cálculo (% 6) + 114 limita o sorteio apenas aos IDs 114, 115, 116, 117, 118 e 119. 
    -- Isso garante que a grande massa de Analistas fique nos departamentos que você chamou de "Core".
    ELSE IF @i <= 738 
        SET @v_id_depto = (ABS(CHECKSUM(NEWID())) % 6) + 114 

    -- 3. A Fatia de "Apoio" (3% = 27 vagas)
    -- A Lógica: Da vaga 739 até a 765 (738 + 27 = 765).
    -- O Departamento: O cálculo (% 6) + 120 sorteia apenas entre os IDs 120 até 125 
    -- (RH, Financeiro, Marketing, Vendas, Compliance e Jurídico).
    ELSE IF @i <= 765 
        SET @v_id_depto = (ABS(CHECKSUM(NEWID())) % 6) + 120 

    -- 4. Especialistas, Tech Leads e Estagiários (10% = 90 vagas)
    -- A Lógica: Da vaga 766 até a 855. Aqui o script agrupa os 4% de Especialistas 
    -- e os 6% de Estagiários/Aprendizes que você destinou ao Core.
    -- O Departamento: Novamente trava o sorteio entre 114 e 119.
    ELSE IF @i <= 855 
        SET @v_id_depto = (ABS(CHECKSUM(NEWID())) % 6) + 114 

    -- 5. O Restante (Aprendizes e Gerentes)
    -- A Lógica: Para todas as vagas restantes (de 856 até 900), o script usa o ELSE.
    -- O Departamento: Abre novamente para qualquer departamento (114 a 125) 
    -- para distribuir os Aprendizes e Gerentes finais.
    ELSE 
        SET @v_id_depto = (ABS(CHECKSUM(NEWID())) % 12) + 114;


    -- ============================================================
    -- BLOCO B: REGRAS 1 e 2 (CARGO E SOLICITANTE POR DEPTO)
    -- ============================================================

    -- REGRA 2: Garante que o ID_CARGO selecionado pertença obrigatoriamente ao ID_DEPARTAMENTO sorteado no Bloco A.
    -- O comando SELECT TOP 1 com ORDER BY NEWID() sorteia um cargo aleatório, mas APENAS dentro da lista permitida (WHERE).
    SET @v_id_cargo = (SELECT TOP 1 id_cargo FROM cargo WHERE 
        (@v_id_depto = 114 AND id_cargo BETWEEN 100 AND 118) OR -- Dev Software
        (@v_id_depto = 115 AND id_cargo BETWEEN 119 AND 128) OR -- Infraestrutura
        (@v_id_depto = 116 AND id_cargo BETWEEN 129 AND 134) OR -- Segurança
        (@v_id_depto = 117 AND id_cargo BETWEEN 135 AND 141) OR -- Projetos
        (@v_id_depto = 118 AND id_cargo BETWEEN 143 AND 146) OR -- Qualidade/QA
        (@v_id_depto = 119 AND id_cargo BETWEEN 147 AND 154) OR -- Banco de Dados
        (@v_id_depto = 120 AND (id_cargo = 142 OR id_cargo BETWEEN 155 AND 161)) OR -- RH (inclui Analista Folha 142)
        (@v_id_depto = 121 AND id_cargo BETWEEN 162 AND 167) OR -- Financeiro
        (@v_id_depto = 122 AND id_cargo BETWEEN 168 AND 173) OR -- Marketing
        (@v_id_depto = 123 AND (id_cargo BETWEEN 174 AND 179 OR id_cargo = 191)) OR -- Vendas (inclui Aprendiz 191)
        (@v_id_depto = 124 AND id_cargo BETWEEN 180 AND 184) OR -- Compliance
        (@v_id_depto = 125 AND id_cargo BETWEEN 185 AND 190)    -- Jurídico
        ORDER BY NEWID());

    -- REGRA 1: O Solicitante (gestor) deve ser vinculado ao mesmo departamento da vaga.
    -- Filtreia a tabela de solicitantes pelo @v_id_depto para garantir que o "dono" da vaga seja da área correta.
    SET @v_id_solicitante = (SELECT TOP 1 id_solicitante FROM solicitante 
                             WHERE id_departamento = @v_id_depto 
                             ORDER BY NEWID());

    -- ============================================================
    -- BLOCO C: REGRAS 3 A 6 (COMPATIBILIDADE CARGO X SENIORIDADE)
    -- ============================================================
    
    -- REGRA 3: Tratamento para o cargo de Aprendiz (ID 191)
    IF @v_id_cargo = 191 
    BEGIN
        SET @v_id_senioridade = 500; -- Senioridade fixa: Aprendiz
        SET @v_id_contrato = 5;      -- Tipo Contrato: Aprendiz (Regra 8)
        SET @v_carga_horaria = 30;   -- Carga horária fixa: 30h (Regra 3)
        -- Regra 9: Escolaridade entre 3 e 6 (Fundamental Completo a Superior Incompleto)
        SET @v_id_escolaridade = (ABS(CHECKSUM(NEWID())) % 4) + 3; 
        -- Regra 11: Inglês nível 1 a 3
        SET @v_id_ingles = (ABS(CHECKSUM(NEWID())) % 3) + 1; 
    END

    -- REGRA 4: Tratamento para Estagiários (IDs 112, 126, 189)
    ELSE IF @v_id_cargo IN (112, 126, 189) 
    BEGIN
        SET @v_id_senioridade = 501; -- Senioridade fixa: Estagiário
        SET @v_id_contrato = 4;      -- Tipo Contrato: Estágio (Regra 8)
        SET @v_carga_horaria = 30;   -- Carga horária fixa: 30h (Regra 4)
        SET @v_id_escolaridade = 6;  -- Escolaridade fixa: Superior Incompleto (Regra 9)
        SET @v_id_ingles = (ABS(CHECKSUM(NEWID())) % 3) + 1; -- Regra 11: Inglês nível 1 a 3
    END

    -- REGRA 5 e 6: Tratamento para os demais cargos (CLT / Regulares)
    ELSE 
    BEGIN
        SET @v_id_contrato = 1;      -- Tipo Contrato: CLT (Regra 8)
        SET @v_carga_horaria = 40;   -- Carga horária padrão: 40h (Regra 5)
        -- Regra 9: Escolaridade entre 5 e 12 (Ensino Médio a Doutorado)
        SET @v_id_escolaridade = (ABS(CHECKSUM(NEWID())) % 8) + 5; 
        -- Regra 11: Inglês nível 3 a 6 (Intermediário a Fluente)
        SET @v_id_ingles = (ABS(CHECKSUM(NEWID())) % 4) + 3; 
        
        -- BLOCO DE COMPATIBILIDADE CARGO X SENIORIDADE (Regra 6)
        -- Busca o nome do cargo para decidir qual nível de senioridade atribuir
        DECLARE @nome_cargo VARCHAR(100) = (SELECT nome_cargo FROM cargo WHERE id_cargo = @v_id_cargo);
        
        SET @v_id_senioridade = CASE 
            -- Diretores, CTOs e CFOs recebem senioridade fixa 527
            WHEN @nome_cargo LIKE '%Diretor%' OR @nome_cargo LIKE '%CTO%' OR @nome_cargo LIKE '%CFO%' THEN 527
            -- Gerentes recebem senioridade entre 524 e 526
            WHEN @nome_cargo LIKE '%Gerente%' THEN (ABS(CHECKSUM(NEWID())) % 3) + 524
            -- Coordenadores recebem senioridade entre 521 e 523
            WHEN @nome_cargo LIKE '%Coordenador%' THEN (ABS(CHECKSUM(NEWID())) % 3) + 521
            -- Liderança Técnica recebe senioridade entre 518 e 520
            WHEN @nome_cargo LIKE '%Tech Lead%' OR @nome_cargo LIKE '%Arquiteto%' OR @nome_cargo LIKE '%Lider%' THEN (ABS(CHECKSUM(NEWID())) % 3) + 518
            -- Analistas e demais cargos sorteiam entre Júnior 1 e Pleno 4 (502 a 509)
            ELSE (ABS(CHECKSUM(NEWID())) % 8) + 502 END;
    END


   -- ============================================================
    -- BLOCO D: REGRA 7 (SALÁRIO) E STATUS/DATAS (REGRAS 12, 14)
    -- ============================================================
    
    -- REGRA 7: Busca os limites salariais na tabela 'senioridade' com base no ID definido no Bloco C.
    SELECT @v_s_min = salario_minimo, @v_s_max = salario_maximo 
    FROM senioridade 
    WHERE id_senioridade = @v_id_senioridade;

    -- REGRA 7 (Continuação): Cálculo do salário final.
    -- Se for Aprendiz (500) ou Estagiário (501), o salário é o valor mínimo fixo da tabela.
    -- Para os demais, sorteia um valor aleatório entre o mínimo e o máximo da faixa.
    SET @v_salario_final = CASE 
        WHEN @v_id_senioridade IN (500,501) THEN @v_s_min 
        ELSE @v_s_min + (RAND() * (@v_s_max - @v_s_min)) 
    END;

    -- REGRA 12: Definição do Status da Vaga por probabilidade.
    -- 90% das vagas (0.00 a 0.90) = 'Fechada'
    -- 1% das vagas (0.90 a 0.91) = 'Em aprovação'
    -- 8% das vagas (0.91 a 0.99) = 'Congelada'
    -- 1% das vagas (0.99 a 1.00) = 'Aberta'
    SET @v_rand = RAND();
    SET @v_status = CASE 
        WHEN @v_rand <= 0.90 THEN 'Fechada' 
        WHEN @v_rand <= 0.91 THEN 'Em aprovação' 
        WHEN @v_rand <= 0.99 THEN 'Congelada' 
        ELSE 'Aberta' END;

    -- REGRA 14: Definição das Datas de Abertura e Fechamento.
    -- Sorteia uma data de abertura aleatória entre 02/01/2025 e 20/11/2025.
    SET @v_data_abertura = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % DATEDIFF(DAY, '2025-01-02', '2025-11-20')), '2025-01-02');

    -- Se a vaga estiver 'Fechada' ou 'Congelada', sorteia uma data de fechamento em 2026.
    -- Caso contrário (Aberta ou Em Aprovação), a data de fechamento permanece NULL (Vazia).
    IF @v_status IN ('Fechada', 'Congelada') 
        SET @v_data_fechamento = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % DATEDIFF(DAY, '2026-02-01', '2026-11-15')), '2026-02-01');
    ELSE 
        SET @v_data_fechamento = NULL;


    -- ============================================================
    -- BLOCO E: INSERT FINAL
    -- ============================================================

    INSERT INTO vagas (
        id_cargo, 
        id_departamento, 
        id_recrutador, 
        cidade, 
        uf, 
        id_modelo_trabalho, 
        id_nivel_ingles, 
        id_nivel_senioridade, 
        id_tipo_contrato, 
        id_escolaridade, 
        carga_horaria, 
        salario_vaga, 
        salario_maximo, 
        status_vaga, 
        data_abertura, 
        data_fechamento, 
        quantidade_posicoes, 
        id_fonte_divulgacao, 
        id_solicitante, 
        data_criacao
    ) VALUES (
        @v_id_cargo, 
        @v_id_depto, 
        -- Sorteia um recrutador aleatório da tabela para cada vaga
        (SELECT TOP 1 id_recrutador FROM recrutador ORDER BY NEWID()), 
        'São Paulo', -- Regra 13: Cidade fixa
        'SP',        -- Regra 13: UF fixa
        -- Regra 15: Modelo de trabalho aleatório (Híbrido, Remoto, Presencial)
        (SELECT TOP 1 id_modelo_trabalho FROM modelo_de_trabalho ORDER BY NEWID()),
        @v_id_ingles, 
        @v_id_senioridade, 
        @v_id_contrato, 
        @v_id_escolaridade,
        @v_carga_horaria, 
        ROUND(@v_salario_final, 2), -- Grava o salário com 2 casas decimais
        @v_s_max,                   -- Salário teto da senioridade para fins de auditoria
        @v_status, 
        @v_data_abertura, 
        @v_data_fechamento, 
        1, -- Quantidade de posições sempre 1 por linha
        -- Regra 10: Fonte de recrutamento aleatória entre IDs 1 e 15
        (ABS(CHECKSUM(NEWID()) % 15) + 1), 
        @v_id_solicitante, 
        @v_data_abertura -- Data de criação igual à data de abertura
    );

    -- Incrementa o contador para que o loop avance para a próxima vaga (até chegar a 900)
    SET @i = @i + 1;

END -- Fim do bloco WHILE. O script volta ao início até completar as 900 inserções.

-- Seleciona todas as colunas da tabela vagas
SELECT * 
FROM vagas;
