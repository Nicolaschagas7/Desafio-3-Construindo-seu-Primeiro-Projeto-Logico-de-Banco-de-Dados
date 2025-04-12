-- Seleciona o banco de dados a ser utilizado
USE e_commerce;

-- Tabela de endereços genérica, utilizada por clientes e estoques
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    cep VARCHAR(8) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    pais VARCHAR(50) NOT NULL DEFAULT 'brasil'
);

-- Armazena informações básicas dos clientes (PF ou PJ)
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente ENUM('pf','pj') NOT NULL,
    nome_completo VARCHAR(45) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATETIME NOT NULL,
    CONSTRAINT uk_cliente_tipo UNIQUE (id_cliente, tipo_cliente) -- Garante unicidade do tipo do cliente
);

-- Relaciona clientes aos seus endereços (usando tabela 'endereco')
CREATE TABLE endereco_cliente (
    id_endereco INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo ENUM('casa', 'condominio') NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- Dados específicos de pessoa física
CREATE TABLE pessoa_fisica (
    id_pf INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_cliente ENUM('pf','pj') NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    Foreign Key (id_cliente, tipo_cliente) REFERENCES cliente(id_cliente, tipo_cliente) -- Referência composta
);

-- Dados específicos de pessoa jurídica
CREATE TABLE pessoa_juridica (
    id_pj INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_cliente ENUM('pf','pj') NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(45) NOT NULL,
    inscricao_estadual VARCHAR(20) NOT NULL,
    Foreign Key (id_cliente, tipo_cliente) REFERENCES cliente(id_cliente, tipo_cliente)
);

-- Armazena os meios de pagamento cadastrados por um cliente
CREATE TABLE forma_pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo ENUM('pix','cartao', 'dinheiro'),
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro DATE NOT NULL,
    Foreign Key (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- Armazena dados específicos de pagamento por cartão
CREATE TABLE cartao (
    id_cartao INT AUTO_INCREMENT PRIMARY KEY,
    id_forma_pagamento INT NOT NULL,
    nome_do_titular VARCHAR(45) NOT NULL,
    numero CHAR(20) NOT NULL,
    bandeira VARCHAR(20) NOT NULL,
    validade DATE NOT NULL,
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    CONSTRAINT uk_cartao_forma_pagamento UNIQUE(id_forma_pagamento) -- Garante 1 cartão por forma de pagamento
);

-- Armazena dados específicos de pagamento via PIX
CREATE TABLE pix (
    id_pix INT AUTO_INCREMENT PRIMARY KEY,
    id_forma_pagamento INT NOT NULL,
    chave VARCHAR(100) NOT NULL,
    tipo ENUM('cpf', 'telefone', 'email', 'aleatoria') NOT NULL,
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    CONSTRAINT uk_pix_forma_pagamento UNIQUE(id_forma_pagamento) -- Garante 1 chave por forma de pagamento
);

-- Tabela de pedidos feitos pelos clientes
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_solicitacao DATETIME NOT NULL,
    status_pedido ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado') NOT NULL,
    Foreign Key (id_cliente) REFERENCES cliente(id_cliente)
);

-- Armazena os dados de pagamento vinculados a um pedido
CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10,2) CHECK (valor > 0) NOT NULL,
    status_pagamento ENUM('esperando', 'pago','estornado', 'reembolsado', 'cancelado') NOT NULL,
    data_processamento DATETIME NOT NULL,
    Foreign Key (id_cliente) REFERENCES cliente(id_cliente),
    Foreign Key (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento)
);

-- Catálogo geral de produtos disponíveis
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    valor DECIMAL(10,2) CHECK (valor > 0) NOT NULL
);

-- Detalha os produtos presentes em cada pedido
CREATE TABLE item_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    preco_unitario DECIMAL(10,2) CHECK (preco_unitario > 0) NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_item_pedido PRIMARY KEY (id_pedido, id_produto),
    Foreign Key (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Representa um local de armazenamento (ex: loja ou armazém)
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    nome_estoque VARCHAR(45) NOT NULL
);

-- Relaciona produtos ao estoque com suas respectivas quantidades
CREATE TABLE estoque_produto (
    id_estoque INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_estoque_produto PRIMARY KEY (id_estoque, id_produto),
    Foreign Key (id_estoque) REFERENCES estoque(id_estoque),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Define endereços associados aos estoques (usando tabela 'endereco')
CREATE TABLE endereco_estoque (
    id_endereco INT NOT NULL,
    id_estoque INT NOT NULL,
    tipo ENUM('armazem', 'loja') NOT NULL,
    CONSTRAINT pk_endereco_estoque PRIMARY KEY (id_endereco, id_estoque),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
);

-- Tabela de fornecedores que vendem produtos para o sistema
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(45) NOT NULL,
    cnpj_fornecedor CHAR(14) NOT NULL
);

-- Relaciona produtos aos fornecedores e seus respectivos preços
CREATE TABLE fornecedor_produto (
    id_fornecedor INT NOT NULL,
    id_produto INT NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_fornecedor_produto PRIMARY KEY (id_fornecedor, id_produto),
    Foreign Key (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Representa parceiros (tipo marketplace) que também vendem produtos
CREATE TABLE vendedor_parceiro (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome ou Razão Social do parceiro
    cpf_cnpj VARCHAR(14) NOT NULL UNIQUE, -- Aceita tanto CPF quanto CNPJ
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    comissao_percentual DECIMAL(5,2) DEFAULT 10.00 -- Percentual de comissão padrão
);

-- Produtos oferecidos por vendedores parceiros, com preços próprios
CREATE TABLE produto_vendedor (
    id_produto INT NOT NULL, -- Produto no catálogo geral
    id_vendedor INT NOT NULL, -- Dono do produto
    preco DECIMAL(10,2) CHECK (preco > 0) NOT NULL, -- Preço específico do vendedor
    CONSTRAINT pk_produto_vendedor PRIMARY KEY (id_vendedor, id_produto),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor_parceiro(id_vendedor)
);


-- ============= ÍNDICES =============
-- Cliente
CREATE INDEX idx_cliente_email ON cliente(email);

-- Pedido
CREATE INDEX idx_pedido_status ON pedido(status_pedido);
CREATE INDEX idx_pedido_cliente ON pedido(id_cliente);

-- Produto
CREATE INDEX idx_produto_nome ON produto(nome_produto);

-- Pagamento
CREATE INDEX idx_pagamento_pedido ON pagamento(id_pedido);

-- Relacionamentos N:N
CREATE INDEX idx_produto_vendedor ON produto_vendedor(id_produto);

-- Índices para documentos únicos
CREATE INDEX idx_pf_cpf ON pessoa_fisica(cpf);
CREATE INDEX idx_pj_cnpj ON pessoa_juridica(cnpj);

CREATE INDEX idx_fornecedor_cnpj ON fornecedor(cnpj_fornecedor);

-- Índices para operações logísticas
CREATE INDEX idx_estoque_produto ON estoque_produto(id_produto);
CREATE INDEX idx_frete_pedido ON frete(id_pedido);
CREATE INDEX idx_entrega_status ON entrega(status_entrega);
CREATE INDEX idx_entrega_data ON entrega(data_entrega);

-- Para consultas financeiras
CREATE INDEX idx_pagamento_data ON pagamento(data_processamento);

-- Para histórico de pedidos
CREATE INDEX idx_pedido_data ON pedido(data_solicitacao);

-- Para consultas frequentes por status e data
CREATE INDEX idx_pedido_status_data ON pedido(status_pedido, data_solicitacao);

-- ============= TABELAS FINAIS =============

-- Dados de frete associados a um pedido específico
CREATE TABLE frete (
    id_frete INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE, -- 1 pedido = 1 frete
    transportadora VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) CHECK (valor > 0) NOT NULL,
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE INDEX idx_frete_transportadora ON frete(transportadora);
CREATE INDEX idx_frete_rastreio ON frete(codigo_rastreio);

-- Informações sobre a entrega física do pedido
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE, -- 1 pedido = 1 entrega
    id_endereco INT NOT NULL, -- Endereço de entrega
    status_entrega ENUM('preparando','caminho','entregue') DEFAULT 'preparando',
    data_entrega DATE,
    FOREIGN KEY (id_pedido)
