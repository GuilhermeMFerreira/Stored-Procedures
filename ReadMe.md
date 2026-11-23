# MySQL – Stored Procedures

Projeto desenvolvido como atividade prática de **Banco de Dados MySQL**, com o objetivo de estudar e aplicar o uso de *Stored Procedures* (procedimentos armazenados).

Neste projeto, é utilizado um banco de dados fictício de uma loja de tecnologia, chamado `loja_tech`, para realizar operações de atualização, validação e consulta de informações.

## Conteúdo

- [Objetivo](#objetivo)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Atividades Realizadas](#atividades-realizadas)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Como Executar](#como-executar)

## Objetivo

O projeto tem como finalidade praticar a criação e execução de procedimentos armazenados no MySQL, trabalhando com parâmetros de entrada e saída, condições, funções de agregação, atualização de registros e consultas ao banco de dados.

## Estrutura do Projeto

```text
mysql-stored-procedures/
│
├── 01_create_database.sql
├── 02_exercise_01.sql
├── 03_exercise_02.sql
└── README.md
```

## Atividades Realizadas

### Atividade 1 – Reajuste de Preços por Categoria

**Procedure:** `atualizar_preco_categoria`

Procedimento criado para modificar os preços dos produtos ativos de acordo com uma categoria selecionada.

**Funcionalidades:**

- Recebe o identificador da categoria e o percentual de alteração.
- Aceita aumentos de até 100%.
- Permite descontos de até 50%.
- Realiza alterações apenas nos produtos ativos.
- Confere se a categoria informada está cadastrada.
- Informa quantos produtos tiveram seus preços modificados.
- Retorna mensagens indicando sucesso ou possíveis erros.
- Armazena os registros da operação na tabela `log_operacoes`.

**Principais recursos utilizados:** `UPDATE`, `ROW_COUNT()`, `IF`, `ELSEIF` e parâmetros `IN` e `OUT`.

### Atividade 2 – Consulta do Histórico de Pedidos

**Procedure:** `consultar_extrato_cliente`

Procedimento desenvolvido para apresentar informações de um cliente e consultar seu histórico de compras.

**Funcionalidades:**

Retorna três conjuntos de resultados (*Result Sets*):

1. **Informações do cliente:** nome, e-mail, telefone e data de cadastro.
2. **Pedidos realizados:** número do pedido, data, situação e valor total.
3. **Resumo das compras:** número de pedidos, total gasto, média de valores e data da compra mais recente.

O procedimento também verifica a existência do cliente, apresentando uma mensagem de erro caso o registro não seja encontrado.

**Principais recursos utilizados:** `SELECT`, `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `IFNULL()` e estruturas condicionais.

## Tecnologias Utilizadas

- **MySQL:** sistema de gerenciamento do banco de dados.
- **MySQL Workbench:** ferramenta utilizada para criar, executar e testar os comandos SQL.

## Como Executar

1. Faça o download ou clone do repositório.
2. Abra o MySQL Workbench e conecte-se ao servidor MySQL.
3. Execute os arquivos SQL seguindo a ordem indicada:

| Ordem | Arquivo | Descrição |
|---|---|---|
| 1 | `create_database.sql` | Criação do banco de dados e das tabelas. |
| 2 | `exercise_01.sql` | Implementação da procedure de reajuste de preços. |
| 3 | `exercise_02.sql` | Implementação da procedure de consulta de pedidos. |

4. Depois de executar os arquivos, utilize os comandos `CALL` para testar os procedimentos armazenados.

## Exemplos:

### Exercício 1

1. Acréscimo de 10% na categoria 1

<img width="369" height="84" alt="image" src="https://github.com/user-attachments/assets/daff3192-4afe-4550-a046-934bd25537ef" />

2. Redução de 20% na categoria 3

<img width="382" height="86" alt="image" src="https://github.com/user-attachments/assets/c2d52066-c53b-48ae-8bd3-0f4e98b673e8" />

3. Tentativa de desconto inválido (-60%)

<img width="373" height="89" alt="image" src="https://github.com/user-attachments/assets/c42d723f-ce0f-49f3-9978-6d7c4059cf7a" />

### Exercício 2

1. Consulta para cliente válido

<img width="451" height="92" alt="image" src="https://github.com/user-attachments/assets/3cf11278-c627-45da-a74b-e6550a0b8469" />

<img width="394" height="98" alt="image" src="https://github.com/user-attachments/assets/4d05482d-5360-42f4-9415-21c2da411528" />

<img width="462" height="84" alt="image" src="https://github.com/user-attachments/assets/6c38b625-af82-4156-9cda-71af5991194b" />

2. Consulta para cliente inexistente

<img width="351" height="90" alt="image" src="https://github.com/user-attachments/assets/d5bc11cd-08d3-40e4-a50f-23d167427df3" />

---

Desenvolvido como atividade prática de Banco de Dados, utilizando MySQL Stored Procedures.  
