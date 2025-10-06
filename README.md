# 🔧 Projeto Conceitual de Banco de Dados para Oficina Mecânica

Este repositório contém o **projeto conceitual de um banco de dados** para um sistema de **gerenciamento de ordens de serviço (OS)** em uma **oficina mecânica**.  
O modelo foi **criado do zero**, com base em uma narrativa que descreve o fluxo de trabalho real de uma oficina, buscando representar com fidelidade os processos de atendimento, execução e controle de serviços.

---

## 🧾 Narrativa do Sistema

O sistema foi projetado para **controlar e gerenciar ordens de serviço** (OS) dentro de uma oficina mecânica.  
O fluxo ocorre da seguinte forma:

1. **Clientes** levam seus **veículos** à oficina para **consertos ou revisões periódicas**.
2. Cada **veículo** é designado a uma **equipe de mecânicos**, que identifica os serviços a serem realizados e emite uma **Ordem de Serviço (OS)** com **data prevista de entrega**.
3. A partir da OS, calcula-se o **valor total**, somando:
   - O custo da **mão de obra** (com base em uma tabela de referência de serviços).
   - O valor das **peças utilizadas**.
4. O **cliente autoriza** a execução dos serviços.
5. A **mesma equipe** avalia, executa e finaliza os serviços dentro do prazo estabelecido.

Cada **mecânico** possui:

- Código
- Nome
- Endereço
- Especialidade

Cada **Ordem de Serviço (OS)** possui:

- Número
- Data de emissão
- Valor total
- Status
- Data de conclusão prevista

---

## 🧩 Descrição do Esquema

O modelo de dados foi estruturado para representar todas as **entidades** e **processos** da narrativa, garantindo **integridade**, **consistência** e **relacionamentos bem definidos** entre as informações.

---

## 🧱 Entidades Principais

### 👤 Cliente

Armazena os **dados cadastrais** dos proprietários dos veículos.

### 🚗 Veículo

Contém as informações de cada veículo que entra na oficina.  
Cada veículo está **vinculado a um único cliente**, mas um cliente pode possuir **vários veículos**.

### 🧑‍🔧 Mecânico

Guarda os dados individuais dos mecânicos, incluindo nome, endereço e **especialidade**.  
Cada mecânico pertence a **uma única equipe**.

### 👥 Equipe

Agrupa os mecânicos, facilitando a **distribuição de tarefas** e **atribuição de responsabilidades**.  
Uma equipe pode ter **vários mecânicos**.

### 🧾 Ordem de Serviço (OrdemServico)

Entidade central do sistema.  
Conecta o **veículo**, a **equipe responsável**, e contém informações sobre:

- Datas (emissão e previsão de conclusão)
- Status
- Valor total da OS

### 🧰 Serviço

Tabela de **referência** para os tipos de serviços prestados, armazenando:

- Descrição
- Valor de mão de obra

### ⚙️ Peça

Tabela de **referência** para as peças disponíveis em estoque, com:

- Descrição
- Valor unitário

---

## ⚙️ Premissas Adotadas

Durante o desenvolvimento do modelo, foram estabelecidas as seguintes regras e decisões de projeto:

### 🔗 Relacionamento Cliente ↔ Veículo

- Um **cliente** pode ter **vários veículos**.
- Um **veículo** pertence a **apenas um cliente**.  
  ➡️ Relacionamento **1:N**.

### 📚 Tabelas de Referência

- Os **serviços** e **peças** foram definidos como tabelas próprias (`Servico` e `Peca`).
- Isso permite **centralizar o controle de preços** e padronizar os registros utilizados nas ordens de serviço.

### 💰 Valor da Ordem de Serviço

- O campo `ValorTotal` foi criado na tabela `OrdemServico`.
- Seu valor é **calculado dinamicamente** a partir da soma:
  - Dos **serviços executados** (`Servicos_OS`).
  - Das **peças utilizadas** (`Pecas_OS`).

### 🔄 Status da Ordem de Serviço

Foi criado o campo `StatusOS` do tipo **ENUM**, com possíveis estados:

- `Aguardando Aprovação`
- `Aprovada`
- `Em Execução`
- `Concluída`

Esse controle permite acompanhar o **progresso da OS** durante todo o ciclo de trabalho.

### 🧑‍🔧 Mecânicos e Equipes

- Cada **mecânico** pertence a **uma única equipe**.
- Uma **equipe** pode conter **vários mecânicos**.  
  ➡️ Relacionamento **1:N** entre Equipe e Mecânico.

---

## 🧠 Benefícios do Modelo

✅ Estrutura realista e aderente ao funcionamento de oficinas mecânicas  
✅ Controle claro do ciclo de vida da OS  
✅ Gestão integrada de clientes, veículos, equipes e serviços  
✅ Cálculo automatizado de valores  
✅ Base sólida para implementação física (SQL)

---

## 🧰 Tecnologias e Ferramentas Utilizadas

- **MySQL** para modelagem e implementação
- **Mermaid Chart** para criação do diagrama ER
- **SQL padrão** para definição das tabelas e relacionamentos

---

**Autor:** Douglas Galhardo  
📧 [douglasgalhardo1994@gmail.com](mailto:douglasgalhardo1994@gmail.com)
