-- Modelo físico do projeto de
-- banco de dados referente à
-- loja de materiais de construção
--
-- A demonstração do modelo físico deste
-- banco de dados segue a ordem:
-- I. Criação do banco e tabelas
-- II. Criando registros
-- III. Lendo registros
-- IV. Atualizando registros
-- V. Apagando registros


-- Parte I: Criando o banco e tabelas
-- Criando o banco de dados da loja de materiais
CREATE DATABASE IF NOT EXISTS LojaDeMateriais;
USE LojaDeMateriais;

-- Criando a tabela de fornecedores
CREATE TABLE IF NOT EXISTS fornecedor (
  fornecedor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45),
  descricao VARCHAR(45),
  email VARCHAR(255),
  telefone_1 VARCHAR(15),
  telefone_2 VARCHAR(15),
  cep VARCHAR(10),
  PRIMARY KEY (fornecedor_id)
);

-- Criando a tabela de categorias de produto
CREATE TABLE IF NOT EXISTS categoria_produto (
  categoria_produto_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45),
  descricao VARCHAR(255),
  PRIMARY KEY (categoria_produto_id)
);

-- Criando a tabela de produtos
CREATE TABLE IF NOT EXISTS produto (
  produto_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45),
  descricao VARCHAR(255),
  valor_unitario FLOAT NOT NULL,
  categoria_produto_id INT UNSIGNED NOT NULL,
  fornecedor_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (produto_id),
  -- Utilizando constraints afim de
  -- nomear as chaves estrangeiras
  CONSTRAINT fk_produto_categoria_produto
    FOREIGN KEY (categoria_produto_id)
    REFERENCES categoria_produto (categoria_produto_id),
  CONSTRAINT fk_produto_fornecedor
    FOREIGN KEY (fornecedor_id)
    REFERENCES fornecedor (fornecedor_id)
);

-- Criando a tabela de controle de estoque (refatorada)
CREATE TABLE IF NOT EXISTS controle_estoque (
  controle_estoque_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo_fluxo VARCHAR(10),
  quantidade INT,
  valor_total DECIMAL(10, 2),
  documento VARCHAR(255),
  cep_origem VARCHAR(10),
  cep_destino VARCHAR(10),
  motivo VARCHAR(100),
  produto_id INT UNSIGNED NOT NULL,
  categoria_produto_id INT UNSIGNED NOT NULL,
  fornecedor_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (controle_estoque_id),
  -- Chaves estrangeiras separadas para cada coluna
  CONSTRAINT fk_fluxo_produto
    FOREIGN KEY (produto_id)
    REFERENCES produto (produto_id),
  CONSTRAINT fk_fluxo_categoria_produto
    FOREIGN KEY (categoria_produto_id)
    REFERENCES categoria_produto (categoria_produto_id),
  CONSTRAINT fk_fluxo_fornecedor
    FOREIGN KEY (fornecedor_id)
    REFERENCES fornecedor (fornecedor_id)
);

-- Parte II: Criando registros
-- Criando categorias de produtos
INSERT INTO categoria_produto(nome,descricao)
VALUES("Tintas", "Produtos destinados à pintura e acabamento"),
("Ferramentas", "Instrumentos para construção e manutenção"),
("Materiais", "Produtos diversos para construção e reforma"),
("Eletrica", "Produtos e materiais para instalações elétricas"),
("Hidraulica", "Materiais para instalações hidráulicas e encanamento");
-- Criando fornecedores
-- Obs: Os campos 'descricao' e 'telefone_2'
-- receberão valores NULL por enquanto
INSERT INTO fornecedor(nome, descricao, email, telefone_1, telefone_2, cep)
VALUES
('Construmix Materiais', NULL, 'contato.construmix@exemplo.com.br', '11987654321', NULL, '01000-000'),
('Obra Total',NULL, 'vendas.obratotal@exemplo.com.br', '11976543210', NULL, '20000-000'),
('Fundação Forte', NULL, 'fforte@exemplo.com.br', '21999998888', NULL, '30100-000'),
('Materiais RS', NULL, 'comercialmateriaisrs@exemplo.com.br', '31988887777', NULL, '90000-000'),
('ConstruCenter', NULL, 'suporte_construcenter@exemplo.com.br', '41977776666', NULL, '80000-000'),
('Fornecedora Salvador', NULL, 'fornecedorassa@exemplo.com.br', '51-96666-5555', NULL, '40000-000'),
('Construfácil', NULL, 'construfacil@exemplo.com.br', '61955554444', NULL, '70000-000'),
('Obras Nordeste', NULL, 'obrasnordeste@exemplo.com.br', '71944443333', NULL, '50000-000'),
('ConstruNova', NULL, 'construnova@exemplo.com.br', '81933332222', NULL, '60000-000'),
('Materiais Amazonia', NULL, 'materiaisamazonia@exemplo.com.br', '91922221111', NULL, '69000-000');
-- Criando produtos para a categoria "Tintas"
INSERT INTO produto(nome, descricao, valor_unitario, categoria_produto_id, fornecedor_id)
VALUES
('Tinta Acrílica', 'Tinta acrílica para parede interna', 45.00, 1, 1),
('Tinta PVA', 'Tinta PVA para acabamento de parede', 35.50, 1, 2),
('Tinta Epóxi', 'Tinta epóxi para pisos e azulejos', 120.00, 1, 3),
('Tinta Spray', 'Tinta spray para pequenas superfícies', 25.00, 1, 4),
('Tinta Verniz', 'Verniz para acabamento de madeira', 80.00, 1, 5),
('Tinta Solvente', 'Tinta solvente para ambientes externos', 60.00, 1, 6),
('Tinta Imprimante', 'Imprimante para pintura de base', 70.00, 1, 7),
('Tinta Automotiva', 'Tinta automotiva para reparo de veículos', 150.00, 1, 8),
('Tinta Para Madeira', 'Tinta para acabamento de madeira', 95.00, 1, 9),
('Tinta de Piso', 'Tinta para piso de concreto e cimento', 110.00, 1, 10);
-- Criando produtos para a categoria "Ferramentas"
INSERT INTO produto(nome, descricao, valor_unitario, categoria_produto_id, fornecedor_id)
VALUES
('Martelo', 'Martelo de cabo de madeira', 30.00, 2, 1),
('Chave Inglesa', 'Chave inglesa ajustável de 12 polegadas', 45.00, 2, 2),
('Alicate de Corte', 'Alicate de corte para fios elétricos', 40.00, 2, 3),
('Serra de Cinta', 'Serra de fita para madeira', 350.00, 2, 4),
('Parafusadeira', 'Parafusadeira elétrica com 2 baterias', 220.00, 2, 5),
('Furadeira', 'Furadeira de impacto 550W', 180.00, 2, 6),
('Chave de Fenda', 'Chave de fenda 6mm', 15.00, 2, 7),
('Esmerilhadeira', 'Esmerilhadeira de 750W', 180.00, 2, 8),
('Plaina Elétrica', 'Plaina elétrica para madeira', 250.00, 2, 9),
('Cortador de Cerâmica', 'Cortador manual de cerâmica', 150.00, 2, 10);
-- Criando produtos para a categoria "Materiais"
INSERT INTO produto(nome, descricao, valor_unitario, categoria_produto_id, fornecedor_id)
VALUES
('Cimento', 'Cimento CP-II 50kg', 25.00, 3, 1),
('Areia', 'Areia média para construção', 80.00, 3, 2),
('Pedra Brita', 'Pedra brita 1 para construção', 100.00, 3, 3),
('Argamassa', 'Argamassa para assentamento de cerâmica', 30.00, 3, 4),
('Tijolo', 'Tijolo comum para alvenaria', 1.50, 3, 5),
('Caibro de Madeira', 'Caibro de madeira para estrutura de telhado', 15.00, 3, 6),
('Aço para Alvenaria', 'Aço para alvenaria de 8mm', 45.00, 3, 7),
('Telha de Fibra', 'Telha de fibra para telhado', 45.00, 3, 8),
('Placa de Gesso', 'Placa de gesso para forro', 25.00, 3, 9),
('Lâmina de Aço', 'Lâmina de aço galvanizado para telhado', 60.00, 3, 10);
-- Criando produtos para a categoria "Elétrica"
INSERT INTO produto(nome, descricao, valor_unitario, categoria_produto_id, fornecedor_id)
VALUES
('Fios Elétricos', 'Fios elétricos 1,5mm', 3.00, 4, 1),
('Interruptor', 'Interruptor de luz 10A', 8.00, 4, 2),
('Disjuntor', 'Disjuntor de 15A', 20.00, 4, 3),
('Tomada', 'Tomada de 2 pinos', 5.00, 4, 4),
('Lâmpada LED', 'Lâmpada LED 15W', 25.00, 4, 5),
('Fita Isolante', 'Fita isolante preta', 5.00, 4, 6),
('Caixa de Distribuição', 'Caixa de distribuição de energia', 50.00, 4, 7),
('Transformador', 'Transformador 220V para 110V', 120.00, 4, 8),
('Extensão Elétrica', 'Extensão elétrica de 5 metros', 30.00, 4, 9),
('Reator Eletrônico', 'Reator eletrônico para lâmpadas fluorescentes', 40.00, 4, 10);
-- Criando produtos para a categoria "Hidráulica"
INSERT INTO produto(nome, descricao, valor_unitario, categoria_produto_id, fornecedor_id)
VALUES
('Tubo PVC', 'Tubo PVC 100mm para esgoto', 10.00, 5, 1),
('Mangueira Flexível', 'Mangueira flexível 10 metros', 40.00, 5, 2),
('Conexões de PVC', 'Conexões de PVC para encanamento', 12.00, 5, 3),
('Válvula de Retenção', 'Válvula de retenção para água', 20.00, 5, 4),
('Torneira', 'Torneira de 1/2 para cozinha', 15.00, 5, 5),
('Registro de Pressão', 'Registro de pressão 3/4', 18.00, 5, 6),
('Cilindro de Gás', 'Cilindro de gás 13kg', 110.00, 5, 7),
('Caixa D´Água', 'Caixa d´água 1000L', 400.00, 5, 8),
('Filtro de Água', 'Filtro de água para instalação residencial', 85.00, 5, 9),
('Bomba d´Água', 'Bomba submersa 1HP', 250.00, 5, 10);
-- Inserindo entradas e saídas no controle de estoque
-- Obs: Para fins de demonstração os documentos estão
-- representados como NULL
-- Entrada de produto: Reposição de estoque
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('ENTRADA', 100, 4500.00, NULL, '01000-000', '20000-000', 'Reposição de estoque', 1, 1, 1);
-- Saída de produto: Produto enviado ao comprador
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('SAÍDA', 50, 2250.00, NULL, '01000-000', '40000-000', 'Produto enviado ao comprador', 2, 1, 2);
-- Entrada de produto: Produto devolvido por defeito
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('ENTRADA', 10, 1200.00, NULL, '30000-000', '01000-000', 'Produto devolvido por defeito', 3, 1, 3);
-- Saída de produto: Produto enviado ao comprador
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('SAÍDA', 30, 900.00, NULL, '20000-000', '30000-000', 'Produto enviado ao comprador', 4, 2, 4);
-- Entrada de produto: Reposição de estoque
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('ENTRADA', 200, 5000.00, NULL, '10000-000', '90000-000', 'Reposição de estoque', 5, 2, 5);
-- Saída de produto: Produto enviado ao comprador
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('SAÍDA', 70, 1400.00, NULL, '80000-000', '60000-000', 'Produto enviado ao comprador', 6, 3, 6);
-- Entrada de produto: Produto devolvido por defeito
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('ENTRADA', 15, 2250.00, NULL, '50000-000', '10000-000', 'Produto devolvido por defeito', 7, 3, 7);
-- Saída de produto: Produto enviado ao comprador
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('SAÍDA', 60, 1800.00, NULL, '70000-000', '50000-000', 'Produto enviado ao comprador', 8, 4, 8);
-- Entrada de produto: Reposição de estoque
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('ENTRADA', 50, 2500.00, NULL, '90000-000', '40000-000', 'Reposição de estoque', 9, 4, 9);
-- Saída de produto: Produto enviado ao comprador
INSERT INTO controle_estoque(tipo_fluxo, quantidade, valor_total, documento, cep_origem, cep_destino, motivo, produto_id, categoria_produto_id, fornecedor_id) 
VALUES 
('SAÍDA', 100, 4000.00, NULL, '60000-000', '80000-000', 'Produto enviado ao comprador', 10, 5, 10);
--
