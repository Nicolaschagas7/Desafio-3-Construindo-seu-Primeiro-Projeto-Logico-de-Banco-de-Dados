-- Active: 1744307256991@@localhost@3306@e_commerce
-- Inserções para tabela vendedor_parceiro (4 registros)
INSERT INTO vendedor_parceiro (nome, cpf_cnpj, telefone, email, comissao_percentual) VALUES
('Gadgets Express', '11222333000177', '(11) 2222-3333', 'vendas@gadgetsexpress.com.br', 12.5),
('Moda Jovem Ltda', '22333444000188', '(21) 3333-4444', 'contato@modajovem.com', 15.0),
('Casa Conforto', '33444555000199', '(31) 4444-5555', 'sac@casaconforto.com.br', 10.0),
('Tecno Import', '99888777000166', '(51) 5555-6666', 'tecnocompras@teconoimport.com', 8.0);

-- Inserções para tabela produto_vendedor (8 registros - produtos de marketplace)
INSERT INTO produto_vendedor (id_produto, id_vendedor, preco) VALUES
(1, 1, 2899.90),  -- Gadgets Express vende Smartphone X mais barato
(2, 1, 5299.00),  -- Gadgets Express vende Notebook Pro
(3, 1, 459.90),   -- Gadgets Express vende Fone Bluetooth
(4, 2, 69.90),    -- Moda Jovem vende Camiseta Básica com desconto
(5, 2, 179.90),   -- Moda Jovem vende Calça Jeans
(6, 4, 849.00),   -- Tecno Import vende Mesa Digitalizadora
(7, 3, 3299.00),  -- Casa Conforto vende Smart TV
(8, 3, 379.90);   -- Casa Conforto vende Conjunto de Panelas

-- Inserções para tabela frete (5 registros - para pedidos enviados/entregues)
INSERT INTO frete (id_pedido, transportadora, valor, codigo_rastreio) VALUES
(1, 'Correios', 25.90, 'BR123456789SP'),          -- Pedido 1
(2, 'Transportadora XYZ', 45.00, 'XYZ987654321'), -- Pedido 2
(5, 'Logística Express', 120.00, 'EXP20230620001'),-- Pedido 5
(6, 'Entregas Rápidas', 89.90, 'ER20230701001'),  -- Pedido 6
(8, 'Correios', 19.90, 'BR987654321SP');         -- Pedido 8

-- Inserções para tabela entrega (5 registros - correspondentes aos fretes)
INSERT INTO entrega (id_pedido, id_endereco, status_entrega, data_entrega) VALUES
(1, 1, 'entregue', '2023-06-05'),    -- Pedido 1 para João Silva
(2, 2, 'caminho', NULL),             -- Pedido 2 para Maria Oliveira
(5, 5, 'preparando', NULL),          -- Pedido 5 para Fashion Store
(6, 6, 'entregue', '2023-07-03'),    -- Pedido 6 para Ana Costa
(8, 1, 'preparando', NULL);          -- Pedido 8 para João Silva (mesmo endereço)