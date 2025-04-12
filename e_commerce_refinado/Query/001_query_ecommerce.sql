-- Active: 1744307256991@@localhost@3306@e_commerce

--- CLAUSULAS PROPOSTA PELO DESAFIO:

--============== SELECT Statement (Recuperações simples) =====================
-- Todos os produtos com seu nome e valor, formatando o valor como R$XX,XX.(Atributo derivado)
SELECT nome_produto AS produto, CONCAT('R$', valor) FROM produto ;

-- Nomes e emails dos clientes cadastrados em 2023.
SELECT nome_completo, email, data_cadastro FROM cliente WHERE YEAR(data_cadastro) = '2023';

-- Lista dos tipos de formas de pagamento distintas cadastradas no sistema.
SELECT DISTINCT tipo AS Formas_pagamento FROM forma_pagamento ;

-- Quantos vendedores parceiros existem cadastrados.
SELECT COUNT(id_vendedor) AS Total_vendedores FROM vendedor_parceiro 



--==================== WHERE Statement (Filtros) =======================
-- Lista de clientes Pessoa Física (pf) com data de nascimento após 1990.
SELECT nome_completo, pf.data_nascimento  FROM cliente c, pessoa_fisica pf WHERE  c.tipo_cliente = 'pf' and pf.data_nascimento LIKE '199%';  

-- Pedidos com valor total superior a R$ 500,00 (soma itens). 
SELECT pe.id_pedido, pg.valor  FROM pedido pe, pagamento pg WHERE  pe.id_pedido = pg.id_pedido AND pg.valor > '500.00';  

-- Filtro de produtos com estoque abaixo de 30 unidades em qualquer armazém.
SELECT p.nome_produto AS Produto, ep.quantidade FROM produto p, estoque_produto ep WHERE ep.quantidade <= '30' ORDER BY ep.quantidade;

-- Lista de endereços de clientes no estado de SP (UF = 'SP').
SELECT c.nome_completo, e.cep, e.uf AS UF FROM cliente c, endereco_cliente ec, endereco e WHERE c.id_cliente = ec.id_cliente AND ec.id_endereco = e.id_endereco AND e.uf = 'SP';



--================== Atributos Derivados (Expressões) ========================
-- Valor total de cada pedido (soma de preco_unitario * quantidade).
SELECT pe.id_pedido, po.nome_produto, ip.preco_unitario, ip.quantidade, (ip.preco_unitario * ip.quantidade) AS valor_total FROM pedido pe, item_pedido ip, produto po WHERE pe.id_pedido = ip.id_pedido AND ip.id_produto = po.id_produto

-- CPF dos clientes com máscara (ex: XXX.XXX.XXX-XX).
SELECT c.nome_completo, CONCAT(
    SUBSTRING(pf.cpf, 1, 3), '.',
    SUBSTRING(pf.cpf, 4, 3), '.',
    SUBSTRING(pf.cpf, 7, 3), '-',
    SUBSTRING(pf.cpf, 10, 2)
) AS cpf_formatado FROM cliente c, pessoa_fisica pf WHERE c.id_cliente = pf.id_cliente;

-- Coluna faixa_etaria para clientes PF: "Jovem" (<30), "Adulto" (30-60), "Sênior" (>60).
SELECT c.nome_completo, YEAR(NOW()) - YEAR(pf.data_nascimento) AS Idade 
FROM cliente c INNER 
JOIN pessoa_fisica pf ON c.id_cliente = pf.id_cliente ; -- Descobrir as idades

SELECT c.nome_completo, YEAR(NOW()) - YEAR(pf.data_nascimento) AS Idade, 
CASE 
    WHEN YEAR(NOW()) - YEAR(pf.data_nascimento) < '30' THEN 'Jovem'
    WHEN YEAR(NOW()) - YEAR(pf.data_nascimento) >= '30' THEN 'Adulto'
    WHEN YEAR(NOW()) - YEAR(pf.data_nascimento) <= '60' THEN 'Adulto'
    WHEN YEAR(NOW()) - YEAR(pf.data_nascimento) > '60' THEN 'Adulto'
    ELSE  NULL
END AS Faixa_etaria
FROM cliente c INNER JOIN pessoa_fisica pf ON c.id_cliente = pf.id_cliente 

-- Calculo do prazo de entrega em dias (diferença entre data_entrega e data_solicitacao).
SELECT e.id_pedido, p.data_solicitacao, e.data_entrega, e.status_entrega, DATEDIFF (e.data_entrega, p.data_solicitacao) as prazo_entrega FROM pedido p INNER JOIN entrega e ON p.id_pedido = e.id_pedido



--======================= ORDER BY (Ordenação) ============================
-- Ordenação dos produtos do mais caro para o mais barato.
SELECT nome_produto, descricao, valor FROM produto ORDER BY valor DESC;

-- Lista de clientes por ordem alfabética de nome e por data de cadastro (mais recente primeiro).
SELECT nome_completo, data_cadastro FROM cliente ORDER BY nome_completo, data_cadastro;

-- Pedidos ordenados por status (pendente > processando > enviado > entregue) e depois por data.
SELECT id_pedido, status_pedido FROM pedido ORDER BY status_pedido;

-- Fornecedores e o número de produtos que oferecem (do maior para menor).
SELECT nome_fornecedor AS Fornecedor, COUNT(*) AS Produto FROM fornecedor f, fornecedor_produto fp, produto p WHERE f.id_fornecedor = fp.id_fornecedor AND fp.id_produto = p.id_produto GROUP BY nome_fornecedor ORDER BY produto DESC;



--======================= HAVING (Filtro em grupos) ===========================
-- Clientes com mais de 1 pedido.
SELECT c.nome_completo, COUNT(*) as Pedidos FROM cliente c INNER JOIN pedido p ON c.id_cliente = p.id_cliente GROUP BY c.id_cliente HAVING COUNT(*) > 1;

-- Lista de fornecedores cujo preço médio dos produtos seja superior a R$ 1000,00.
SELECT f.nome_fornecedor AS fornecedor, fp.preco_venda FROM fornecedor f INNER JOIN fornecedor_produto fp ON f.id_fornecedor = fp.id_fornecedor HAVING fp.preco_venda > '1000.00';

-- Filtro de vendedores parceiros com comissão abaixo de 11%.
SELECT nome, cpf_cnpj, comissao_percentual  FROM vendedor_parceiro HAVING comissao_percentual < '11' ORDER BY comissao_percentual;

-- Produtos vendidos mais de 2 vezes no total (soma de quantidades).
SELECT nome_produto, SUM(quantidade) FROM produto p INNER JOIN item_pedido ip ON p.id_produto = ip.id_produto GROUP BY p.nome_produto HAVING sum(quantidade) > 2;



--========================== JOIN (Junções) ===================================
-- Lista de pedidos com detalhes do cliente (nome) e status de entrega.
SELECT p.id_pedido, c.nome_completo, a.data_entrega FROM cliente c INNER JOIN pedido p ON c.id_cliente = p.id_cliente INNER JOIN entrega a ON p.id_pedido = a.id_pedido 

-- Produtos, seus fornecedores e preços de venda.
SELECT p.nome_produto AS Produto, f.nome_fornecedor AS fornecedor, fp.preco_venda FROM produto p INNER JOIN fornecedor_produto fp ON p.id_produto = fp.id_produto INNER JOIN fornecedor f ON fp.id_fornecedor = f.id_fornecedor

-- Relacionamento de vendedores parceiros com seus produtos e estoque disponível.
SELECT vp.nome AS vendedor_parceiro, p.nome_produto AS produto, ep.quantidade FROM vendedor_parceiro vp INNER JOIN produto_vendedor pv ON vp.id_vendedor = pv.id_vendedor INNER JOIN produto p ON pv.id_produto = p.id_produto INNER JOIN estoque_produto ep ON p.id_produto = ep.id_produto


-- Pagamentos com suas formas (cartão/PIX) e detalhes específicos (bandeira/tipo).
SELECT p.id_pagamento, fp.tipo, c.bandeira FROM pagamento p INNER JOIN forma_pagamento fp ON p.id_forma_pagamento = fp.id_forma_pagamento INNER JOIN cartao c ON fp.id_forma_pagamento = c.id_forma_pagamento ;


--=================================================================================

--- CLAUSULAS ADICIONAIS:

--========================== GROUP BY (Agregação) =============================
-- Calculo do total de vendas por mês.
SELECT MONTH(data_processamento) as mes, sum(valor) FROM pagamento GROUP BY mes;

-- Clientes Agrupados por tipo (PF/PJ) e contagem de quantos são de cada.
SELECT tipo_cliente, COUNT(*) FROM cliente GROUP BY tipo_cliente;

-- Média do valor dos pedidos por status.
SELECT pe.status_pedido, ROUND(AVG(pa.valor)) FROM pedido pe INNER JOIN pagamento pa ON pe.id_pedido = pa.id_pedido GROUP BY status_pedido;

-- Estados (UF) com mais clientes (top 5).
SELECT  e.uf AS UF, COUNT(*) as clientes FROM cliente c, endereco_cliente ec, endereco e WHERE c.id_cliente = ec.id_cliente AND ec.id_endereco = e.id_endereco GROUP BY e.uf ORDER BY clientes DESC LIMIT 5;



--=========================== Subconsultas ================================
-- Liste produtos nunca vendidos.

-- Mostre clientes que gastaram acima da média.

-- Encontre fornecedores que não têm produtos cadastrados.

-- Liste pedidos com frete mais caro que a média.

--=================================================================================


--- PERGUNTAS PROPOSTAS PELO DESAFIO:

-- Quantos pedidos foram feitos por cada cliente?
-- usando Where
SELECT c.nome_completo as Nome, COUNT(p.id_pedido) as Quantidade_pedidos FROM cliente as c, pedido p WHERE c.id_cliente = p.id_cliente GROUP BY nome_completo;

-- usando JOIN
SELECT c.nome_completo as Nome, COUNT(p.id_pedido) as Quantidade_pedidos FROM cliente as c JOIN pedido p ON c.id_cliente = p.id_cliente GROUP BY nome_completo;

-- com filtro
SELECT c.nome_completo as Nome, COUNT(p.id_pedido) as Quantidade_pedidos FROM cliente as c JOIN pedido p ON c.id_cliente = p.id_cliente WHERE c.tipo_cliente = 'pj' GROUP BY nome_completo;

-- ===========================================

--Algum vendedor também é fornecedor? R- Nâo, nenhum

-- forma mais simples e rapida, sua limitacão seria em caso de muitos valores e risco de erro humano
SELECT nome_fornecedor FROM fornecedor f;
SELECT nome FROM vendedor_parceiro vp;

-- forma mais completa, usando JOIN e having
SELECT f.nome_fornecedor as fornecedor, f.cnpj_fornecedor, vp.nome as vendedor, vp.cpf_cnpj FROM vendedor_parceiro vp INNER JOIN produto_vendedor pv ON vp.id_vendedor = pv.id_vendedor INNER JOIN produto p ON pv.id_produto = p.id_produto INNER JOIN fornecedor_produto fp ON p.id_produto = fp.id_produto INNER JOIN fornecedor f ON fp.id_fornecedor = f.id_fornecedor HAVING f.cnpj_fornecedor = vp.cpf_cnpj;

-- ===========================================

--Relação de produtos fornecedores e estoques;

-- usando JOIN
SELECT p.nome_produto, f.nome_fornecedor, ep.quantidade, e.nome_estoque FROM estoque e INNER JOIN estoque_produto ep ON e.id_estoque = ep.id_estoque INNER JOIN produto p ON p.id_produto = ep.id_produto INNER JOIN fornecedor_produto fp ON p.id_produto = fp.id_produto INNER JOIN fornecedor f ON fp.id_fornecedor = f.id_fornecedor ORDER BY ep.quantidade; 

-- usando WHERE
SELECT p.nome_produto, f.nome_fornecedor, ep.quantidade, e.nome_estoque FROM estoque e, estoque_produto ep, produto p, fornecedor_produto fp, fornecedor f WHERE e.id_estoque = ep.id_estoque AND p.id_produto = ep.id_produto AND p.id_produto = fp.id_produto AND fp.id_fornecedor = f.id_fornecedor ORDER BY ep.quantidade;

-- ===========================================

--Relação de nomes dos fornecedores e nomes dos produtos;

-- usando WHERE
SELECT f.nome_fornecedor as fornecedor, p.nome_produto produto, fp.preco_venda FROM fornecedor f, fornecedor_produto fp, produto p WHERE f.id_fornecedor = fp.id_fornecedor AND p.id_produto = fp.id_produto ORDER BY f.nome_fornecedor, p.nome_produto;

-- usando JOIN
SELECT f.nome_fornecedor as fornecedor, p.nome_produto produto, fp.preco_venda FROM fornecedor f INNER JOIN fornecedor_produto fp ON f.id_fornecedor = fp.id_fornecedor INNER JOIN produto p ON p.id_produto = fp.id_produto ORDER BY f.nome_fornecedor, p.nome_produto;
