# Desafio 03 - Construindo seu primeiro projeto lógico de banco de dados

## 1. Contexto do Desafio
Este projeto foi desenvolvido como parte de um desafio proposto no **bootcamp Heineken: Inteligência Artificial Aplicada a Dados**, promovido pela plataforma [Digital Innovation One (DIO)](https://www.dio.me/), sob orientação da instrutora Juliana.

Este desafio propõe a **construção do modelo lógico** de um banco de dados baseado em um **cenário de e-commerce**. A tarefa principal foi converter o modelo conceitual/Diagrama EER desenvolvido no 1° desafio desse bootcamp em **comandos SQL** (modelo lógico relacional), utilizando boas práticas de modelagem e garantindo a integridade dos dados.

## 2. Divisão do Repositório

### Pasta `e_commerce_replicado/`
Contém a versão do banco de dados feita com base fiel na modelagem original criada pela professora. A estrutura das tabelas, nomes e relacionamentos seguem exatamente o que foi passado por ela.

Esta versão foi criada para cumprir a 1° tarefa do desafio: replicar o exemplo original.

### Pasta `e_commerce_refinado/`
Contém a versão refinada da modelagem lógica, feita por mim. Nela, adicionei novas tabelas, melhorei os relacionamentos e organizei os atributos de forma a refletir um sistema mais completo e funcional para um e-commerce real.

Essa versão foi criada para cumprir a 2° tarefa do desafio: refinar o exemplo original; por isso existem diversas diferenças do modelo feito pela professora, assim demonstrando um maior entendimento das necessidades do contexto desse banco de dados.

## 3. Aprendizados

Durante a conversão do modelo conceitual para o SQL, percebi que o primeiro diagrama feito por mim para o 1° desafio do bootcamp apresentava algumas falhas de estrutura e ausência de tabelas importantes. 

Utilizei o DBeaver para gerar um diagrama ER mais preciso a partir do SQL criado, o que me permitiu visualizar e validar a lógica do banco de dados de forma mais clara, além de auxiliar na reorganização e aprimoramento da modelagem.

## 4. Extras

Os arquivos `.sql` possuem comentários básicos explicando o propósito das tabelas e colunas, mas explicações mais detalhadas estão presentes no `README.md` da pasta `refinado/`.
