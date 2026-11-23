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

**Exemplos de execução:**

```sql
-- Atividade 1
CALL atualizar_preco_categoria(1, 10, @quantidade, @mensagem);

SELECT @quantidade AS produtos_alterados,
       @mensagem AS resultado;

-- Atividade 2
CALL consultar_extrato_cliente(1);
```

---

Desenvolvido como atividade prática de Banco de Dados, utilizando MySQL Stored Procedures.  