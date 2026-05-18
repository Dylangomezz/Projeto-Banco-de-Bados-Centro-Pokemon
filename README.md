# 🏥 Centro Pokémon - Sistema de Banco de Dados

![Pokémon Banner](https://img.shields.io/badge/Project-Pokémon%20Center-red?style=for-the-badge&logo=pokemon)
![Database](https://img.shields.io/badge/Database-Relational-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-green?style=for-the-badge)

Sistema de gerenciamento para Centros Pokémon desenvolvido como projeto acadêmico do curso de **Sistemas para Internet do Instituto Federal de Brasília (IFB)**. O objetivo do projeto é modelar e estruturar um banco de dados capaz de registrar treinadores, pokémons, enfermeiras e consultas realizadas nos Centros Pokémon.

---

## 📌 Sumário
- [Propósito do Documento](#-propósito-do-documento)
- [Escopo do Produto](#-escopo-do-produto)
- [Requisitos do Sistema](#-requisitos-do-sistema)
- [Modelagem Conceitual (DER)](#-modelagem-conceitual-der)
- [Modelagem Lógica (Modelo Relacional)](#-modelagem-lógica-modelo-relacional)
- [Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [Objetivo Acadêmico](#-objetivo-acadêmico)
- [Autores](#-autores)

---

## 🎯 Propósito do Documento
Inspirado nos mangás, animes e jogos da franquia, este projeto visa criar um banco de dados robusto para automatizar, padronizar e facilitar o registro de Pokémons e Treinadores, além de monitorar os atendimentos médicos realizados nas clínicas.

## 🌐 Escopo do Produto
O sistema é projetado para apoiar o trabalho das enfermeiras antes, durante e após os tratamentos. Ele permite:
* Registrar novos treinadores e Pokémons.
* Consultar e atualizar dados de forma sincronizada em toda a rede de Centros Pokémon.
* Manter histórico de consultas e relatórios de uso.
* Garantir conformidade com as normas da **PIA (Pokémon Inspection Agency)**.

---

## 📋 Requisitos do Sistema

### Requisitos Funcionais (Resumo)
* **RF.1 & RF.2:** Cadastro completo de Pokémons (Código, Espécie, Tipo Primário/Secundário, Natureza, HP Total, Nível) e Treinadores (Identificação, Nome, Data de Nascimento, Telefone e Endereço).
* **RF.4:** Gerenciamento de consultas médicas (Registrar HP atual, condições especiais, status e descrição do tratamento).
* **RF.5 & RF.6:** Controle de acesso restrito para Enfermeiras através de autenticação (Login/Senha).

### Requisitos Não Funcionais Críticos
* **Segurança:** Armazenamento de senhas criptografadas (Hash com Salt) e timeout de sessão inativa após 10 minutos.
* **Desempenho & Sincronização:** Resposta de consultas em até 3 segundos e sincronização de dados entre os centros em tempo real (atraso máximo de 5 segundos).
* **Auditoria:** Registro histórico (Log) de todas as inserções, alterações e exclusões por pelo menos 5 anos.

---

## 🗺️ Modelagem Conceitual (DER)
O modelo conceitual foi estruturado mapeando as entidades básicas do universo de negócios do Centro Pokémon. 

### Entidades Principais:
1. **Pokémon:** Possui relacionamento `(1,n)` com Treinador.
2. **Treinador:** Entidade central conectada a Pokémons, Telefones e Endereço.
3. **Centro Pokémon:** Possui especializações do tipo **Urbano** e **Selvagem**.
4. **Enfermeira:** Associada a um Centro e com possibilidade de possuir **Dependentes**.
5. **Consulta (Entidade Associativa):** Conecta de forma histórica as entidades *Pokémon*, *Centro Pokémon* e *Enfermeira*.

---

## 📐 Modelagem Lógica (Modelo Relacional)

O mapeamento do DER gerou a seguinte estrutura de chaves primárias (`PK`) e estrangeiras (`FK`):

```sql
-- Representação lógica das tabelas
tbPokémon (ID_Pokémon [PK], Nome, Espécie, Natureza, HP_Total, Nível, Tipo_Primario, Tipo_Secundario, ID_Treinador [FK])
tbTreinador (ID_Treinador [PK], Nome, Data_Nascimento, ID_Endereço [FK])
tbTelefone (ID_Telefone [PK], Numero, DDD, ID_Treinador [FK])
tbEndereço (ID_Endereço [PK], Logradouro, Bairro, Cidade, Complemento, Numero, Região, Rota)
tbCentro_Pokémon (ID_Centro [PK], Codigo_PIA)
tbUrbano (ID_Urbano [PK], ID_Centro [FK])
tbSelvagem (ID_Selvagem [PK], ID_Centro [FK])
tbEnfermeira (ID_Enfermeira [PK], Nome, ID_Centro [FK], ID_Endereço [FK])
tbDependente (ID_Dependente [PK], Nome, ID_Enfermeira [FK])
tbConsulta (Data_Hora_Consulta [PK], Descrição, HP_Atual, Condição, ID_Pokémon [FK], ID_Centro [FK], ID_Enfermeira [FK]) 
```
---

## 🛠️ Tecnologias Utilizadas
* Modelagem Entidade Relacionamento (DER)
* Modelo Relacional
* Banco de Dados Relacional
* SQL
* BrModelo

---

## 🎯 Objetivo Acadêmico
Este projeto foi desenvolvido para a disciplina de Banco de Dados no Instituto Federal de Brasília, com foco em:
Modelagem conceitual
Modelagem lógica
Normalização
Regras de negócio
Estruturação de banco relacional

---

## 👥 Autores
Trabalho desenvolvido pelos estudantes do IFB - Campus Brasília:
* **Céu Tavares**
* **Dominique Nazareth**
* **Dylan Gomes**
* **Jéssica Freitas**

**Orientador**: Prof. Hugo do Carmo Mendes Cesar

---

## 🏫 Instituição
**Instituto Federal de Brasília - Campus Brasília
 Curso: Tecnólogo em Sistemas para Internet**
