-- Active: 1744307256991@@localhost@3306@e_commerce
-- Inserções para tabela endereco (8 registros)
INSERT INTO endereco (cep, logradouro, numero, complemento, cidade, uf, pais) VALUES
('01001000', 'Praça da Sé', '1', 'Lado ímpar', 'São Paulo', 'SP', 'Brasil'),
('20040002', 'Rua Primeiro de Março', '25', 'Sala 302', 'Rio de Janeiro', 'RJ', 'Brasil'),
('30120010', 'Avenida Afonso Pena', '1000', 'Conjunto 101', 'Belo Horizonte', 'MG', 'Brasil'),
('80010000', 'Rua XV de Novembro', '500', '', 'Curitiba', 'PR', 'Brasil'),
('90010001', 'Rua dos Andradas', '300', 'Loja A', 'Porto Alegre', 'RS', 'Brasil'),
('40010010', 'Avenida Sete de Setembro', '150', 'Andar 5', 'Salvador', 'BA', 'Brasil'),
('70040904', 'Eixo Monumental', 's/n', 'Setor Comercial Sul', 'Brasília', 'DF', 'Brasil'),
('29010020', 'Rua da Alfândega', '35', 'Fundos', 'Vitória', 'ES', 'Brasil');

-- Inserções para tabela cliente (8 registros - 5 PF e 3 PJ)
INSERT INTO cliente (tipo_cliente, nome_completo, telefone, email, data_cadastro) VALUES
('pf', 'João Silva', '(11) 9999-8888', 'joao.silva@email.com', '2023-01-15 10:30:00'),
('pf', 'Maria Oliveira', '(21) 98765-4321', 'maria.oliveira@email.com', '2023-02-20 14:15:00'),
('pj', 'Tech Solutions LTDA', '(31) 3333-4444', 'contato@techsolutions.com', '2023-03-10 09:00:00'),
('pf', 'Carlos Pereira', '(41) 5555-6666', 'carlos.pereira@email.com', '2023-04-05 16:45:00'),
('pj', 'Fashion Store SA', '(51) 7777-8888', 'vendas@fashionstore.com', '2023-05-12 11:20:00'),
('pf', 'Ana Costa', '(85) 3232-4545', 'ana.costa@email.com', '2023-06-18 08:10:00'),
('pf', 'Roberto Almeida', '(92) 3344-5566', 'roberto.almeida@email.com', '2023-07-22 15:30:00'),
('pj', 'Construções Moderna Ltda', '(27) 2626-3636', 'orcamento@constmoderna.com.br', '2023-08-30 13:45:00');

-- Inserções para tabela endereco_cliente (8 registros)
INSERT INTO endereco_cliente (id_endereco, id_cliente, tipo) VALUES
(1, 1, 'casa'),   -- João Silva em SP
(2, 2, 'condominio'), -- Maria Oliveira no RJ
(3, 3, 'condominio'), -- Tech Solutions em BH
(4, 4, 'casa'),   -- Carlos Pereira em Curitiba
(5, 5, 'condominio'), -- Fashion Store em POA
(6, 6, 'casa'),   -- Ana Costa em Salvador
(7, 7, 'condominio'), -- Roberto Almeida em Brasília
(8, 8, 'casa');   -- Construções Moderna em Vitória

-- Inserções para tabela pessoa_fisica (5 registros - para os clientes PF)
INSERT INTO pessoa_fisica (id_cliente, tipo_cliente, cpf, data_nascimento) VALUES
(1, 'pf', '12345678901', '1985-05-15'), -- João Silva
(2, 'pf', '23456789012', '1990-08-22'), -- Maria Oliveira
(4, 'pf', '34567890123', '1978-11-30'), -- Carlos Pereira
(6, 'pf', '45678901234', '1995-04-18'), -- Ana Costa
(7, 'pf', '56789012345', '1982-07-25'); -- Roberto Almeida

-- Inserções para tabela pessoa_juridica (3 registros - para os clientes PJ)
INSERT INTO pessoa_juridica (id_cliente, tipo_cliente, cnpj, razao_social, inscricao_estadual) VALUES
(3, 'pj', '11222333000144', 'Tech Solutions Tecnologia Ltda', '1234567890'),
(5, 'pj', '22333444000155', 'Fashion Store Comércio de Roupas SA', '9876543210'),
(8, 'pj', '33444555000166', 'Construções Moderna Ltda', '4567890123');

-- Inserções para tabela forma_pagamento (8 registros - variando tipos por cliente)
INSERT INTO forma_pagamento (id_cliente, tipo, ativo, data_cadastro) VALUES
(1, 'cartao', TRUE, '2023-01-15'),  -- João Silva (cartão)
(1, 'pix', TRUE, '2023-01-16'),     -- João Silva (PIX também)
(2, 'cartao', TRUE, '2023-02-20'),  -- Maria Oliveira (cartão)
(3, 'pix', TRUE, '2023-03-10'),     -- Tech Solutions (PIX)
(4, 'cartao', TRUE, '2023-04-05'),  -- Carlos Pereira (cartão)
(5, 'pix', TRUE, '2023-05-12'),     -- Fashion Store (PIX)
(6, 'cartao', TRUE, '2023-06-18'),  -- Ana Costa (cartão)
(7, 'pix', TRUE, '2023-07-22');     -- Roberto Almeida (PIX)

-- Inserções para tabela cartao (4 registros - para formas de pagamento do tipo cartão)
INSERT INTO cartao (id_forma_pagamento, nome_do_titular, numero, bandeira, validade) VALUES
(1, 'JOÃO SILVA', '4111111111111111', 'visa', '2025-12-31'),
(3, 'MARIA OLIVEIRA', '5555555555554444', 'mastercard', '2024-10-31'),
(5, 'CARLOS PEREIRA', '378282246310005', 'amex', '2026-06-30'),
(7, 'ANA COSTA', '6011111111111117', 'discover', '2025-03-31');

-- Inserções para tabela pix (4 registros - para formas de pagamento do tipo PIX)
INSERT INTO pix (id_forma_pagamento, chave, tipo) VALUES
(2, 'joao.silva@email.com', 'email'),          -- João Silva
(4, '11222333000144', 'cpf'),                  -- Tech Solutions (usa CNPJ como chave)
(6, 'vendas@fashionstore.com', 'email'),       -- Fashion Store
(8, '+559233445566', 'telefone');              -- Roberto Almeida