-- Active: 1744307256991@@localhost@3306@e_commerce
-- Inserções para tabela produto (8 registros - variando categorias)
INSERT INTO produto (nome_produto, descricao, valor) VALUES
('Smartphone X', 'Smartphone avançado com câmera de 48MP', 2999.90),
('Notebook Pro', 'Notebook com processador i7 e 16GB RAM', 5499.00),
('Fone Bluetooth', 'Fone de ouvido sem fio com cancelamento de ruído', 499.90),
('Camiseta Básica', 'Camiseta 100% algodão, várias cores', 79.90),
('Calça Jeans', 'Calça jeans masculina, modelo slim', 199.90),
('Mesa Digitalizadora', 'Área ativa de 10x6 polegadas, 8192 níveis de pressão', 899.00),
('Smart TV 55"', 'TV 4K UHD com HDR e Android TV', 3499.00),
('Conjunto de Panelas', '6 peças em aço inox, antiaderente', 399.90);

-- Inserções para tabela pedido (8 registros - variando status e clientes)
INSERT INTO pedido (id_cliente, data_solicitacao, status_pedido) VALUES
(1, '2023-06-01 14:30:00', 'entregue'),     -- João Silva
(2, '2023-06-05 10:15:00', 'enviado'),     -- Maria Oliveira
(3, '2023-06-10 16:45:00', 'processando'), -- Tech Solutions
(4, '2023-06-15 09:20:00', 'pendente'),    -- Carlos Pereira
(5, '2023-06-20 11:30:00', 'enviado'),     -- Fashion Store
(6, '2023-07-01 08:45:00', 'entregue'),    -- Ana Costa
(7, '2023-07-05 13:20:00', 'cancelado'),   -- Roberto Almeida
(1, '2023-07-10 17:00:00', 'processando'); -- João Silva (segundo pedido)

-- Inserções para tabela item_pedido (1-3 itens por pedido, totalizando 12 registros)
INSERT INTO item_pedido (id_pedido, id_produto, preco_unitario, quantidade) VALUES
-- Pedido 1 (João Silva)
(1, 1, 2999.90, 1),  -- Smartphone X
(1, 3, 499.90, 2),   -- Fone Bluetooth (2 unidades)

-- Pedido 2 (Maria Oliveira)
(2, 2, 5499.00, 1),  -- Notebook Pro

-- Pedido 3 (Tech Solutions)
(3, 4, 79.90, 5),    -- Camiseta Básica (5 unidades)
(3, 5, 199.90, 3),   -- Calça Jeans (3 unidades)

-- Pedido 4 (Carlos Pereira)
(4, 6, 899.00, 1),   -- Mesa Digitalizadora

-- Pedido 5 (Fashion Store)
(5, 1, 2999.90, 3),  -- Smartphone X (3 unidades)
(5, 2, 5499.00, 1),  -- Notebook Pro

-- Pedido 6 (Ana Costa)
(6, 7, 3499.00, 1),  -- Smart TV 55"
(6, 8, 399.90, 1),   -- Conjunto de Panelas

-- Pedido 7 (Roberto Almeida - cancelado)
(7, 3, 499.90, 1),   -- Fone Bluetooth

-- Pedido 8 (João Silva - segundo pedido)
(8, 4, 79.90, 2),    -- Camiseta Básica (2 unidades)
(8, 5, 199.90, 1);   -- Calça Jeans

-- Inserções para tabela pagamento (8 registros - um por pedido, exceto o cancelado)
INSERT INTO pagamento (id_cliente, id_pedido, id_forma_pagamento, valor, status_pagamento, data_processamento) VALUES
(1, 1, 1, 3999.70, 'pago', '2023-06-01 14:35:00'),       -- João Silva (cartão)
(2, 2, 3, 5499.00, 'pago', '2023-06-05 10:20:00'),       -- Maria Oliveira (cartão)
(3, 3, 4, 998.60, 'pago', '2023-06-10 16:50:00'),        -- Tech Solutions (PIX)
(4, 4, 5, 899.00, 'esperando', '2023-06-15 09:25:00'),   -- Carlos Pereira (cartão)
(5, 5, 6, 14498.70, 'pago', '2023-06-20 11:35:00'),      -- Fashion Store (PIX)
(6, 6, 7, 3898.90, 'pago', '2023-07-01 08:50:00'),       -- Ana Costa (cartão)
(7, 7, 8, 499.90, 'cancelado', '2023-07-05 13:25:00'),   -- Roberto Almeida (PIX)
(1, 8, 2, 359.70, 'pago', '2023-07-10 17:05:00');        -- João Silva (PIX)

-- Inserções para tabela estoque (5 registros - armazéns e lojas)
INSERT INTO estoque (nome_estoque) VALUES
('Armazém Central SP'),
('Loja Rio de Janeiro'),
('Loja Belo Horizonte'),
('Armazém Curitiba'),
('Loja Porto Alegre');

-- Inserções para tabela estoque_produto (8 registros - distribuindo produtos)
INSERT INTO estoque_produto (id_estoque, id_produto, quantidade) VALUES
(1, 1, 50),   -- Smartphone X no Armazém SP
(1, 2, 30),   -- Notebook Pro no Armazém SP
(2, 1, 10),   -- Smartphone X na Loja RJ
(2, 3, 20),   -- Fone Bluetooth na Loja RJ
(3, 4, 100),  -- Camiseta Básica na Loja BH
(4, 5, 80),   -- Calça Jeans no Armazém Curitiba
(5, 3, 15),   -- Fone Bluetooth na Loja POA
(5, 4, 40);   -- Camiseta Básica na Loja POA

-- Inserções para tabela endereco_estoque (5 registros - um para cada estoque)
INSERT INTO endereco_estoque (id_endereco, id_estoque, tipo) VALUES
(1, 1, 'armazem'),   -- Armazém SP
(2, 2, 'loja'),      -- Loja RJ
(3, 3, 'loja'),      -- Loja BH
(4, 4, 'armazem'),   -- Armazém Curitiba
(5, 5, 'loja');      -- Loja POA

-- Inserções para tabela fornecedor (4 registros)
INSERT INTO fornecedor (nome_fornecedor, cnpj_fornecedor) VALUES
('Eletrônicos Brasil Ltda', '99888777000111'),
('Confecções Estilo SA', '88777666000122'),
('Móveis e Decorações Ltda', '77666555000133'),
('Importadora Tech Global', '66555444000144');

-- Inserções para tabela fornecedor_produto (8 registros - relacionando fornecedores e produtos)
INSERT INTO fornecedor_produto (id_fornecedor, id_produto, preco_venda) VALUES
(1, 1, 2500.00),  -- Eletrônicos Brasil fornece Smartphone X
(1, 2, 4800.00),  -- Eletrônicos Brasil fornece Notebook Pro
(1, 3, 400.00),   -- Eletrônicos Brasil fornece Fone Bluetooth
(2, 4, 60.00),    -- Confecções Estilo fornece Camiseta Básica
(2, 5, 150.00),   -- Confecções Estilo fornece Calça Jeans
(3, 7, 3000.00),  -- Móveis e Decorações fornece Smart TV
(3, 8, 350.00),   -- Móveis e Decorações fornece Panelas
(4, 6, 750.00);   -- Importadora Tech fornece Mesa Digitalizadora