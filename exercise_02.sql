DELIMITER $$

DROP PROCEDURE IF EXISTS sp_obter_historico_cliente$$

CREATE PROCEDURE sp_obter_historico_cliente(
    IN p_cliente_id INT
)
bloco_extrato: BEGIN

    DECLARE v_cliente_cadastrado BOOLEAN DEFAULT FALSE;

    -- Valida se o parâmetro foi enviado e se o registro existe
    IF p_cliente_id IS NOT NULL THEN
        SELECT EXISTS(
            SELECT 1 
            FROM clientes 
            WHERE id_cliente = p_cliente_id
        ) INTO v_cliente_cadastrado;
    END IF;

    -- Saída antecipada caso o cliente não seja localizado
    IF NOT v_cliente_cadastrado THEN
        SELECT 'Falha: Nenhum cliente localizado com o ID informado.' AS aviso;
        LEAVE bloco_extrato;
    END IF;

    -- 1º Retorno: Informações cadastrais
    SELECT
        nome AS cliente_nome,
        email AS cliente_email,
        telefone AS cliente_telefone,
        criado_em AS cadastrado_desde
    FROM clientes
    WHERE id_cliente = p_cliente_id;

    -- 2º Retorno: Lista cronológica de compras
    SELECT
        id_pedido AS cod_pedido,
        data_pedido AS data_compra,
        status AS situacao,
        valor_total AS total_pedido
    FROM pedidos
    WHERE id_cliente = p_cliente_id
    ORDER BY data_pedido DESC, id_pedido DESC;

    -- 3º Retorno: Indicadores consolidados
    SELECT
        COUNT(id_pedido) AS qtd_compras,
        COALESCE(SUM(valor_total), 0.00) AS montante_gasto,
        ROUND(COALESCE(AVG(valor_total), 0.00), 2) AS media_por_pedido,
        COALESCE(DATE_FORMAT(MAX(data_pedido), '%d/%m/%Y %H:%i'), 'Sem pedidos') AS data_ultima_compra
    FROM pedidos
    WHERE id_cliente = p_cliente_id;

END$$

DELIMITER ;

-- ==========================================
-- EXECUÇÃO DOS TESTES
-- ==========================================

-- Consulta para cliente válido
CALL sp_obter_historico_cliente(1);

-- Consulta para cliente inexistente
CALL sp_obter_historico_cliente(150);