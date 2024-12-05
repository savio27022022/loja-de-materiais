-- Modelo Físico MySQL da Loja de Materiais
--
-- Ordem de execução
-- 1. criar_banco.sql: Cria o banco, triggers, views etc.
-- 2. inserir_registros.sql: Insere dados de teste no banco.

-- Garantir recriar banco
DROP SCHEMA IF EXISTS LojaDeMateriais;
-- Criar o banco de dados para estoque de loja de materiais
CREATE SCHEMA IF NOT EXISTS LojaDeMateriais;
-- Utilizar o banco
USE LojaDeMateriais;

-- Criar tabela para fornecedores
CREATE TABLE IF NOT EXISTS fornecedor (
  fornecedor_id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  descricao VARCHAR(255) NULL,
  email VARCHAR(255) NULL,
  telefone VARCHAR(15) NULL,
  cep VARCHAR(10) NULL,
  PRIMARY KEY (fornecedor_id)
);

-- Criar tabela para categorias de produto
CREATE TABLE IF NOT EXISTS categoria_produto (
  categoria_produto_id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  descricao VARCHAR(255) NULL,
  PRIMARY KEY (categoria_produto_id)
);

-- Criar tabela para produtos
CREATE TABLE IF NOT EXISTS produto (
  produto_id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  descricao VARCHAR(255) NULL,
  valor_unidade FLOAT NULL,
  quantidade_disponivel INT NULL,
  categoria_produto_id INT NOT NULL,
  fornecedor_id INT NOT NULL,
  PRIMARY KEY (produto_id),
  FOREIGN KEY (categoria_produto_id) REFERENCES categoria_produto(categoria_produto_id),
  FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(fornecedor_id)
);

-- Criar tabela para movimentação de produtos
CREATE TABLE IF NOT EXISTS movimentacao (
  movimentacao_id INT NOT NULL AUTO_INCREMENT,
  tipo_fluxo VARCHAR(10) NULL,
  quantidade INT NULL,
  valor_total FLOAT NULL,
  motivo VARCHAR(100) NULL,
  produto_id INT NOT NULL,
  datahora DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (movimentacao_id),
  FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);

-- Procedure para listar movimentações de estoque em determinado intervalo de tempo
DELIMITER $$

CREATE PROCEDURE listar_movimentacoes_por_datahora(
    IN data_inicio DATETIME,  -- Parâmetro de entrada para a data de início
    IN data_fim DATETIME      -- Parâmetro de entrada para a data de fim
)
BEGIN
    -- Consulta para listar as movimentações dentro do intervalo de datahora
    SELECT 
        movimentacao_id, 
        tipo_fluxo, 
        quantidade, 
        valor_total, 
        motivo, 
        produto_id, 
        datahora
    FROM movimentacao
    WHERE datahora BETWEEN data_inicio AND data_fim
    ORDER BY datahora;  -- Ordena pelo campo de datahora
END $$

DELIMITER ;

-- View para mostar o nome do produto + nome categoria + nome fornecedor
CREATE VIEW produtos_com_categorias_fornecedores AS
SELECT 
    p.produto_id,
    p.nome AS nome_produto,
    c.nome AS nome_categoria,
    f.nome AS nome_fornecedor
FROM 
    produto p
JOIN 
    categoria_produto c ON p.categoria_produto_id = c.categoria_produto_id
JOIN 
    fornecedor f ON p.fornecedor_id = f.fornecedor_id;

-- Function que retorna todos
-- produtos disponíveis em uma categoria específica
DELIMITER $$

CREATE FUNCTION produtos_disponiveis_na_categoria(categoria_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    -- Declaração de variável para armazenar a contagem dos produtos
    DECLARE qtd_produtos INT;

    -- Conta quantos produtos possuem quantidade_disponivel > 0 na categoria fornecida
    SELECT COUNT(*)
    INTO qtd_produtos
    FROM produto
    WHERE categoria_produto_id = categoria_id
    AND quantidade_disponivel > 0;

    -- Retorna o número de produtos disponíveis
    RETURN qtd_produtos;
END $$

DELIMITER ;


-- Trigger para calcular o valor total de uma movimentação
-- O valor total é calculado antes da inserção na tabela 'movimentacao'
-- com base no valor unitário do produto e na quantidade informada.
-- Este trigger é do tipo 'BEFORE INSERT' para garantir que o valor_total
-- seja calculado antes que a movimentação seja registrada na tabela.
DELIMITER $$

CREATE TRIGGER calcular_valor_total
BEFORE INSERT ON movimentacao
FOR EACH ROW
BEGIN
    -- Declara uma variável para armazenar o valor unitário do produto
    DECLARE valor_unitario DECIMAL(10, 2);
    
    -- Obtém o valor unitário do produto com base no produto_id da nova movimentação
    SELECT valor_unidade INTO valor_unitario
    FROM produto
    WHERE produto_id = NEW.produto_id;
    
    -- Calcula o valor total multiplicando o valor unitário pela quantidade da movimentação
    SET NEW.valor_total = valor_unitario * NEW.quantidade;
END $$

DELIMITER ;



-- Trigger para atualizar a quantidade disponível do produto
-- Este trigger é do tipo 'AFTER INSERT' e é acionado sempre que
-- uma nova movimentação é inserida na tabela 'movimentacao'.
-- Dependendo do tipo de fluxo ('Entrada' ou 'Saída'), ele atualiza a quantidade
-- disponível no estoque do produto, adicionando ou subtraindo a quantidade
-- conforme necessário.
DELIMITER $$

CREATE TRIGGER atualizar_quantidade_disponivel
AFTER INSERT ON movimentacao
FOR EACH ROW
BEGIN
    -- Verifica o tipo de fluxo para decidir se a movimentação é uma 'Entrada' ou 'Saída'
    IF NEW.tipo_fluxo = 'Entrada' THEN
        -- Se for 'Entrada', incrementa a quantidade disponível do produto
        UPDATE produto
        SET quantidade_disponivel = quantidade_disponivel + NEW.quantidade
        WHERE produto_id = NEW.produto_id;
    ELSEIF NEW.tipo_fluxo = 'Saída' THEN
        -- Se for 'Saída', decrementa a quantidade disponível do produto
        UPDATE produto
        SET quantidade_disponivel = quantidade_disponivel - NEW.quantidade
        WHERE produto_id = NEW.produto_id;
    END IF;
END $$

DELIMITER ;
