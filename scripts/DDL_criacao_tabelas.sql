
-- ============================================================
-- Criação do Banco de Dados: RH
-- ============================================================
CREATE DATABASE RH;
GO

USE RH;
GO

/* =====================================================
   CRIAÇÃO DAS TABELAS DE DOMÍNIO
   ===================================================== */

CREATE TABLE departamento (
    id_departamento SMALLINT IDENTITY(114,1) PRIMARY KEY,
    nome_departamento VARCHAR(50) NOT NULL
);

CREATE TABLE contrato (
    id_contrato SMALLINT IDENTITY(1,1) PRIMARY KEY,
    tipo_contrato VARCHAR(50) NOT NULL
);

CREATE TABLE senioridade (
    id_senioridade SMALLINT IDENTITY(500,1) PRIMARY KEY,
    descricao_senioridade VARCHAR(50) NOT NULL,
    nivel_ordem VARCHAR(50) NOT NULL,
    salario_minimo DECIMAL(10,2) NOT NULL,
    salario_medio  DECIMAL(10,2) NOT NULL,
    salario_maximo DECIMAL(10,2) NOT NULL
);

CREATE TABLE cargo (
    id_cargo SMALLINT IDENTITY(100,1) PRIMARY KEY,
    nome_cargo VARCHAR(50) NOT NULL
);

CREATE TABLE escolaridade (
    id_escolaridade SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE fonte_recrutamento (
    id_fonte_recrutamento SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE modelo_de_trabalho (
    id_modelo_trabalho SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(25) NOT NULL
);

CREATE TABLE nivel_ingles (
    id_nivel_ingles SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE status_candidatura (
    id_status_candidatura SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE recrutador (
    id_recrutador SMALLINT IDENTITY(1,1) PRIMARY KEY,
    nome_recrutador VARCHAR(50) NOT NULL
);

/* =====================================================
   TABELAS COM CHAVES ESTRANGEIRAS
   ===================================================== */

CREATE TABLE solicitante (
    id_solicitante INT IDENTITY(1,1) PRIMARY KEY,
    nome_solicitante VARCHAR(100) NOT NULL,
    id_departamento SMALLINT NOT NULL,
    CONSTRAINT fk_solicitante_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

CREATE TABLE vaga (
    id_vaga INT IDENTITY(1,1) PRIMARY KEY,
    id_cargo SMALLINT NOT NULL,
    id_departamento SMALLINT NOT NULL,
    id_recrutador INT NOT NULL,
    id_senioridade SMALLINT NOT NULL,
    id_contrato SMALLINT NOT NULL,
    id_modelo_trabalho SMALLINT NOT NULL,
    id_nivel_ingles SMALLINT NOT NULL,
    id_escolaridade SMALLINT NOT NULL,
    id_fonte_recrutamento SMALLINT NOT NULL,
    cidade VARCHAR(100),
    uf CHAR(2),
    carga_horaria INT,
    status_vaga VARCHAR(20) NOT NULL,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    quantidade_posicoes SMALLINT DEFAULT 1,

    CONSTRAINT fk_vaga_cargo FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    CONSTRAINT fk_vaga_departamento FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento),
    CONSTRAINT fk_vaga_recrutador FOREIGN KEY (id_recrutador) REFERENCES recrutador(id_recrutador),
    CONSTRAINT fk_vaga_senioridade FOREIGN KEY (id_senioridade) REFERENCES senioridade(id_senioridade),
    CONSTRAINT fk_vaga_contrato FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato),
    CONSTRAINT fk_vaga_modelo FOREIGN KEY (id_modelo_trabalho) REFERENCES modelo_de_trabalho(id_modelo_trabalho),
    CONSTRAINT fk_vaga_ingles FOREIGN KEY (id_nivel_ingles) REFERENCES nivel_ingles(id_nivel_ingles),
    CONSTRAINT fk_vaga_escolaridade FOREIGN KEY (id_escolaridade) REFERENCES escolaridade(id_escolaridade),
    CONSTRAINT fk_vaga_fonte FOREIGN KEY (id_fonte_recrutamento) REFERENCES fonte_recrutamento(id_fonte_recrutamento)
);
