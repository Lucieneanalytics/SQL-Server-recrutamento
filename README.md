# SQL-Server-recrutamento
______________________________
Este projeto faz parte do meu portfólio de dados e foca na estruturação, modelagem e geração de dados para área de Recrutamento e Seleção. 
O objetivo foi criar um ambiente robusto que simula o dia a dia de um ecossistema de Seleção, desde a abertura de vagas até a gestão de candidaturas.

______________________________
🚀 **Destaques do Projeto**

**Modelagem Relacional:** Criação de 13 tabelas normalizadas com chaves primárias e estrangeiras.

**Automação de Dados (T-SQL)**: Desenvolvimento de scripts complexos com loops (WHILE) e lógica condicional para gerar 900 vagas e 4.000 candidatos de forma realista.

**Lógica de Negócio Integrada:** O gerador de dados respeita regras como faixas salariais por senioridade, requisitos de escolaridade e fluxos de status.
______________________________
📈 **Estrutura do Banco de Dados**

O banco de dados foi modelado para suportar todas as etapas do processo seletivo. Abaixo, as principais tabelas:

🔹 **Tabelas de Domínio (Dimensões)**

Cargo: Catálogo completo de funções (Tech, RH, Financeiro, etc.).

Departamento: Áreas estruturais da empresa.

Senioridade: Definição de níveis e faixas salariais (Mínimo, Médio e Máximo).

Escolaridade / Nível de Inglês: Requisitos técnicos e acadêmicos.

Status Candidatura: Etapas do funil (Triagem, Entrevista, Oferta).

🔸 **Tabelas Transacionais (Fatos)**

Vagas: Conecta requisitos, solicitantes e recrutadores.

Candidato: Perfil completo, incluindo pretensão salarial e demografia.

Candidatura: O coração do projeto, onde o candidato é vinculado à vaga e percorre o processo.
______________________________
🛠️ **Tecnologias Utilizadas**

**Banco de Dados:** SQL Server

**Ferramenta de Modelagem**: dbdiagram.io

**Linguagem de Script:** Transact-SQL (T-SQL) para automação de inserts e lógica de negócio.
