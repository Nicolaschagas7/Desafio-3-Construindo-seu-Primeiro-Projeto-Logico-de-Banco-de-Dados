# Modelagem Refinada - Banco de Dados de E-commerce

## 1. Descrição Geral

Esta pasta contém a **versão refinada do banco de dados** originalmente proposto no desafio. A estrutura foi baseada no modelo conceitual desenvolvido no 1° desafio, mas com **diversas melhorias aplicadas** para tentar refletir as necessidades reais de um sistema de e-commerce funcional e escalável.

Inclusive os detalhes sobre o **contexto modelado** está no README.md do [1° desafio]().

**Estrutura básica:**  
- `/create`: Scripts para criação de tabelas no banco  
- `/seed`: Scripts de incerção de Dados iniciais para testes  
- `/query`: Scripts de exemplos de consultas operacionais  
- `DEER_e_commerce.png`: Diagrama gerado pelo DBaver

## 2. Ferramentas utilizadas

- **MySQL** (sintaxe padrão utilizada no script SQL)
- **DBeaver**: Utilizado para execução do SQL e geração do modelo físico atualizado com base no script.

## 3. Tabelas Adicionadas e Justificativas
- `pessoa_fisica`, `pessoa_juridica`: Permite que os clientes possam ser PF ou PJ mas não os dois.
- `pagamento`: Permite o registro de múltiplas formas de pagamento para um mesmo pedido.
- `pix`, `cartao`: Representam tipos específicos de pagamento, com atributos próprios (como chave PIX, bandeira do cartão, etc.).
- `endereco`, `endereco_cliente`, `endereco_estoque`: Criadas para normalizar e reutilizar os dados de endereço em diferentes contextos do sistema.
- `frete`: Armazena informações sobre modalidades e custos de entrega.
- `entrega`: Representa o processo de entrega após o fechamento do pedido, permitindo rastreamento e registro de data.

## 4. Correções de Esquecimentos

Na modelagem inicial(1° diagrama feito por mim), a tabela `vendedor_parceiro` e seu relacionamento com os produtos haviam sido esquecidos. Essa tabela agora foi corretamente incluída para representar vendedores externos que utilizam a plataforma.

## 5. Aprimoramentos nos Relacionamentos

Os relacionamentos entre tabelas foram revisados para garantir a integridade referencial e refletir melhor as regras de negócio. Por exemplo, a associação entre pedidos e pagamentos agora permite múltiplas formas de pagamento, e o relacionamento entre produtos e estoque foi detalhado.

## 6. Atributos Adicionados

Foram incluídos diversos atributos essenciais em várias tabelas, como:

- `cpf`, `cnpj`, `nome`, `email` para clientes e vendedores
- `data_criacao`, `status`, `valor_total` para pedidos
- `quantidade_estoque`, `preco_unitario` para produtos

Esses atributos ajudam a garantir que o banco de dados tenha os dados mínimos necessários para funcionamento e análise. todos os atributos adicionados podem ser visualizada diretamente no script SQL ou no diagrama ER.

## 7. Implementação de Consultas SQL

### Cláusulas Desenvolvidas
Foram implementadas consultas utilizando as cláusulas SQL especificadas no desafio, com 4 variações para cada:

**Cláusulas Principais (fornecidas pelo desafio):**
- Recuperações simples com *SELECT* Statement
- Filtros com *WHERE* Statement
- Crie expressões para gerar atributos derivados
- Defina ordenações dos dados com *ORDER BY*
- Condições de filtros aos grupos – *HAVING* Statement
- Crie *JOINS* entre tabelas para fornecer uma perspectiva mais complexa dos dados

**Cláusulas Adicionais (desenvolvidas como extensão):**
- [GRUPY_BY]
- [Subconsultas]

### Perguntas do Desafio Resolvidas
Foram desenvolvidas consultas para responder às seguintes questões propostas no enunciado do desafio:

1. Quantos pedidos foram feitos por cada cliente?
2. Algum vendedor também é fornecedor?
3. Relação de produtos fornecedores e estoques;
4. Relação de nomes dos fornecedores e nomes dos produtos;

**Organização dos Arquivos:**
- Pasta `query/` contendo o arquivo com as clausulas e perguntas.

## 8. Considerações Finais

Essa versão representa uma evolução significativa em relação ao primeiro diagrama. Ela foi desenvolvida com foco em atender melhor às necessidades de um e-commerce real, prevendo situações como múltiplos endereços, diferentes formas de pagamento, gestão de entrega e relacionamento com vendedores parceiros.

A modelagem refinada permite maior flexibilidade e facilita a manutenção e expansão futura do sistema.