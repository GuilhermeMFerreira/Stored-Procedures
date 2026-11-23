DELIMITER $$

DROP PROCEDURE IF EXISTS sp_reajustar_precos_por_categoria$$

CREATE PROCEDURE sp_reajustar_precos_por_categoria(
    IN p_categoria_id INT,
    IN p_taxa_ajuste DECIMAL(5,2),
    OUT p_total_afetados INT,
    OUT p_status_msg VARCHAR(255)
)
proc_principal: BEGIN

    DECLARE v_fator_calculo DECIMAL(10,4);
    DECLARE v_categoria_valida BOOLEAN DEFAULT FALSE;

    SET p_total_afetados = 0;
    SET p_status_msg = '';

    IF p_categoria_id IS NULL OR p_taxa_ajuste IS NULL THEN
        SET p_status_msg = 'Falha: Os parâmetros de categoria e percentual são obrigatórios.';
        LEAVE proc_principal;
    END IF;

    IF p_taxa_ajuste NOT BETWEEN -50.00 AND 100.00 THEN
        SET p_status_msg = 'Falha: O percentual deve estar entre -50% (desconto) e 100% (acréscimo).';
        LEAVE proc_principal;
    END IF;

    IF p_taxa_ajuste = 0 THEN
        SET p_status_msg = 'Aviso: Percentual zerado. Nenhuma alteração foi aplicada.';
        LEAVE proc_principal;
    END IF;

    SELECT EXISTS(
        SELECT 1 
        FROM categorias 
        WHERE id_categoria = p_categoria_id
    ) INTO v_categoria_valida;

    IF NOT v_categoria_valida THEN
        SET p_status_msg = 'Falha: A categoria informada não existe no cadastro.';
        LEAVE proc_principal;
    END IF;

    SET v_fator_calculo = 1 + (p_taxa_ajuste / 100);

    UPDATE produtos
    SET preco = ROUND(preco * v_fator_calculo, 2)
    WHERE id_categoria = p_categoria_id
      AND ativo = 1;

    SET p_total_afetados = ROW_COUNT();

    SET p_status_msg = CASE 
        WHEN p_total_afetados > 0 THEN 
            CONCAT('Concluído: ', p_total_afetados, ' item(ns) reajustado(s) em ', p_taxa_ajuste, '%.')
        ELSE 
            'Aviso: A categoria não possui produtos ativos para reajuste.'
    END;

    INSERT INTO log_operacoes (tabela_afetada, operacao, descricao)
    VALUES (
        'produtos',
        'UPDATE',
        CONCAT('ID Categoria: ', p_categoria_id, ' | Taxa: ', p_taxa_ajuste, '% | Afetados: ', p_total_afetados)
    );

END$$

DELIMITER ;
--exemplos:

-- 1. Acréscimo de 10% na categoria 1
CALL sp_reajustar_precos_por_categoria(1, 10.00, @qtd, @msg);
SELECT @qtd AS total_alterado, @msg AS mensagem_retorno;

-- 2. Redução de 20% na categoria 3
CALL sp_reajustar_precos_por_categoria(3, -20.00, @qtd, @msg);
SELECT @qtd AS total_alterado, @msg AS mensagem_retorno;

-- 3. Tentativa de desconto inválido (-60%)
CALL sp_reajustar_precos_por_categoria(1, -60.00, @qtd, @msg);
SELECT @qtd AS total_alterado, @msg AS mensagem_retorno;
