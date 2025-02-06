-- ===============================================< QUESTÃO 01 >========================================================
-- Crie um stored procedure que receba id de cliente, data inicial e data final, 
-- e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), 
-- mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado. 
-- No script, inclua o código de criação e o comando de chamada da procedure.
-- =====================================================================================================================
DELIMITER //
CREATE PROCEDURE questao1(v_cliente_id int, data_inicial datetime, data_final datetime)
BEGIN
	SELECT c.nome, v.id, v.valor_total, iv.nome_produto, iv.quantidade, iv.valor_unitario, iv.subtotal FROM venda v 
    JOIN cliente c ON v.cliente_id = c.id 
    JOIN item_venda iv ON iv.venda_id = v.id 
    WHERE v.cliente_id = v_cliente_id AND v.data BETWEEN data_inicial AND data_final;
END //
DELIMITER ;
call questao1(50,'2019-01-08', '2019-01-11 23:59');

-- ===============================================< QUESTÃO 02 >========================================================
-- Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”.
-- Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras na loja.  
-- Se não, é um cliente “REGULAR”. No script, inclua o código de criação e o comando de chamada da function.
-- =====================================================================================================================
DELIMITER //
CREATE FUNCTION questao2(v_cliente_id int)
	RETURNS VARCHAR(7) deterministic
BEGIN
	DECLARE tipo float;
    DECLARE cliente VARCHAR(7);
    SELECT sum(valor_total), cliente_id INTO tipo, cliente FROM venda where cliente_id = v_cliente_id group by cliente_id;
    if tipo > 10000 Then
		set cliente = 'PREMIUM';
	else
		set cliente = 'REGULAR';
	End if;
	RETURN cliente;
END //
DELIMITER ;
SELECT questao2(150);

-- ===============================================< QUESTÃO 03 >========================================================
-- Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, 
-- aplique automaticamente MD5() à coluna “senha”; utilize nesta atividade variáveis com NEW.
-- =====================================================================================================================
DELIMITER //
CREATE TRIGGER questao3 BEFORE INSERT
ON usuario
FOR EACH ROW
BEGIN
	SET NEW.senha = md5(NEW.senha);
END //
DELIMITER ;

