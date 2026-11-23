DELIMITER $$

DROP PROCEDURE IF EXISTS sp_obter_historico_cliente$$

CREATE PROCEDURE sp_obter_historico_cliente(
    IN p_cliente_id INT
)
bloco_extrato: BEGIN

    DECLARE v_cliente_cadastrado BOOLEAN DEFAULT FALSE;

    IF p_cliente_id IS NOT NULL THEN
        SELECT EXISTS(
            SELECT 1 
            FROM clientes 
            WHERE id_cliente = p_cliente_id
        ) INTO v_cliente_cadastrado;
    END IF;

    IF NOT v_cliente_cadastrado THEN
        SELECT 'Falha: Nenhum cliente localizado com o ID informado.' AS aviso;
        LEAVE bloco_extrato;
    END IF;

    SELECT
        nome AS cliente_nome,
        email AS cliente_email,
        telefone AS cliente_telefone,
        criado_em AS cadastrado_desde
    FROM clientes
    WHERE id_cliente = p_cliente_id;

    SELECT
        id_pedido AS cod_pedido,
        data_pedido AS data_compra,
        status AS situacao,
        valor_total AS total_pedido
    FROM pedidos
    WHERE id_cliente = p_cliente_id
    ORDER BY data_pedido DESC, id_pedido DESC;

    SELECT
        COUNT(id_pedido) AS qtd_compras,
        COALESCE(SUM(valor_total), 0.00) AS montante_gasto,
        ROUND(COALESCE(AVG(valor_total), 0.00), 2) AS media_por_pedido,
        COALESCE(DATE_FORMAT(MAX(data_pedido), '%d/%m/%Y %H:%i'), 'Sem pedidos') AS data_ultima_compra
    FROM pedidos
    WHERE id_cliente = p_cliente_id;

END$$

DELIMITER ;
-- exercicio 02

-- consulta para cliente válido
CALL sp_obter_historico_cliente(1);

-- consulta para cliente inexistente
CALL sp_obter_historico_cliente(150);
