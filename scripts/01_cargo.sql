-- ============================================================
-- Criação do Banco de Dados: RH
-- ============================================================
CREATE DATABASE RH;
GO

-- ============================================================
-- Criação da Tabela : CARGO
-- ============================================================

CREATE TABLE cargo (
id_cargo SMALLINT IDENTITY(100,1) PRIMARY KEY,
nome_cargo VARCHAR(50) NOT NULL
);

SELECT *
FROM sys.tables
WHERE name = 'cargo';

-- ============================================================
-- Inserir dados na tabela : CARGO
-- ============================================================

INSERT INTO cargo (nome_cargo) VALUES
('Analista de Inteligencia de IA'),
('Arquiteto de Solucoes'),
('Desenvolvedor Android'),
('Desenvolvedor de APIs'),
('Desenvolvedor de Back-end'),
('Desenvolvedor de Front-end'),
('Desenvolvedor Full Stack'),
('Desenvolvedor iOS'),
('Diretor de Tecnologia (CTO)'),
('Engenheiro de Machine Learning'),
('Engenheiro de Software'),
('Especialista em Inteligencia Artificial'),
('Estagiario - Dev'),
('Gerente de Desenvolvimento de Software'),
('Lider Tecnico'),
('UI Designer'),
('UX Designer'),
('UX Writing'),
('UX/UI Designer'),
('Administrador de Rede'),
('Arquiteto de Infraestrutura de TI'),
('Diretor de Infraestrutura'),
('Engenheiro de DevOps'),
('Engenheiro de Infraestrutura'),
('Especialista em Nuvem (Cloud Engineer)'),
('Especialista em Redes'),
('Estagiario Infra'),
('Gerente de Infraestrutura'),
('Tecnico de Suporte em TI'),
('Analista de Acesso'),
('Analista de Seguranca da Informacao'),
('Consultor de Seguranca da Informacao'),
('Diretor de Seguranca da Informacao'),
('Engenheiro de Cloud Security'),
('Gerente de Seguranca da Informacao'),
('Analista de Negocios'),
('Analista de Processos'),
('Coordenador de Projetos'),
('Diretor de Projetos'),
('Gerente de Projetos'),
('Product Owner (PO)'),
('Scrum Master'),
('Analista de Folha de Pagamento'),
('Diretor de Qualidade'),
('Engenheiro de Testes (QA Engineer)'),
('Gerente de Qualidade'),
('Testador de Software (QA)'),
('Administrador de Banco de Dados'),
('Analista de Business Intelligence (BI)'),
('Analista de Dados'),
('Analista de Governanca de Dados'),
('Arquiteto de Banco de Dados'),
('Diretor de Dados'),
('Engenheiro de Dados'),
('Gerente de Banco de Dados'),
('Analista de Beneficios'),
('Analista de RH'),
('Analista de Seleção'),
('Coordenador de RH'),
('Diretor de RH'),
('Gerente de RH'),
('HRBP'),
('Analista Contabil'),
('Analista Financeiro'),
('Analista de Contas a Pagar'),
('Diretor Financeiro (CFO)'),
('FP&A'),
('Gerente Financeiro'),
('Analista de Comunicacao Interna'),
('Analista de Midias Digitais'),
('Coordenador de Marketing'),
('Diretor de Marketing'),
('Gerente de Marketing'),
('Social Media'),
('Analista de Vendas'),
('Diretor Comercial'),
('Especialista em Customer Success'),
('Analista de Pre-Vendas'),
('Executivo de Vendas'),
('Gerente de Vendas'),
('Analista de Compliance'),
('Analista de Controles Internos'),
('Analista de Investigacoes Internas'),
('Diretor de Compliance'),
('Gerente de Compliance'),
('Advogado Corporativo'),
('Analista Juridico'),
('Assistente Juridico'),
('Diretor Juridico'),
('Estagiario Juridico'),
('Gerente Juridico'),
('Aprendiz');

SELECT * FROM cargo;
