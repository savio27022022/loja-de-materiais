-- Obs:
-- Para fins de teste cada produto
-- terá uma quantidade disponível inicial
-- de 100 unidades

-- Utilizar o banco
USE LojaDeMateriais;

-- Novos registros das categorias de produtos
INSERT INTO categoria_produto(nome, descricao)
VALUES 
-- Tintas
("Tintas", "Produtos destinados à pintura e acabamento"),
-- Ferramentas
("Ferramentas", "Instrumentos para construção e manutenção"),
-- Materiais
("Materiais", "Produtos diversos para construção e reforma"),
-- Elétrica
("Elétrica", "Produtos e materiais para instalações elétricas"),
-- Hidráulica
("Hidráulica", "Materiais para instalações hidráulicas e encanamento");

-- Novos registros de fornecedores
INSERT INTO fornecedor(nome, descricao, email, telefone, cep)
VALUES
('Construmix Materiais', NULL, 'contato.construmix@exemplo.com.br', '11987654321', '01000-000'),
('Obra Total', NULL, 'vendas.obratotal@exemplo.com.br', '11976543210', '20000-000'),
('Fundação Forte', NULL, 'fforte@exemplo.com.br', '21999998888', '30100-000'),
('Materiais RS', NULL, 'comercialmateriaisrs@exemplo.com.br', '31988887777', '90000-000'),
('ConstruCenter', NULL, 'suporte_construcenter@exemplo.com.br', '41977776666', '80000-000'),
('Fornecedora Salvador', NULL, 'fornecedorassa@exemplo.com.br', '51-96666-5555', '40000-000'),
('Construfácil', NULL, 'construfacil@exemplo.com.br', '61955554444', '70000-000'),
('Obras Nordeste', NULL, 'obrasnordeste@exemplo.com.br', '71944443333', '50000-000'),
('ConstruNova', NULL, 'construnova@exemplo.com.br', '81933332222', '60000-000'),
('Materiais Amazonia', NULL, 'materiaisamazonia@exemplo.com.br', '91922221111', '69000-000');

-- Novos registros de produtos
-- Produtos para a categoria "Tintas"
INSERT INTO produto(nome, descricao, valor_unidade, categoria_produto_id, fornecedor_id)
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
-- Produtos para a categoria "Ferramentas"
INSERT INTO produto(nome, descricao, valor_unidade, categoria_produto_id, fornecedor_id)
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
-- Produtos para a categoria "Materiais"
INSERT INTO produto(nome, descricao, valor_unidade, categoria_produto_id, fornecedor_id)
VALUES
('Cimento', 'Cimento Portland para construção civil', 30.00, 3, 1),
('Areia', 'Areia fina para construção', 20.00, 3, 2),
('Brita', 'Brita 1 para construção civil', 25.00, 3, 3),
('Tijolo', 'Tijolo de barro para alvenaria', 0.80, 3, 4),
('Cal', 'Cal hidratada para construção', 15.00, 3, 5),
('Madeira Pinus', 'Madeira de pinus para construção', 150.00, 3, 6),
('Tubos PVC', 'Tubos PVC para encanamento', 12.00, 3, 7),
('Tinta Para Piso', 'Tinta para pintura de piso', 85.00, 3, 8),
('Massa Corrida', 'Massa corrida para acabamento de paredes', 45.00, 3, 9),
('Revestimento Cerâmico', 'Revestimento cerâmico para pisos e paredes', 100.00, 3, 10);
-- Produtos para a categoria "Elétrica"
INSERT INTO produto(nome, descricao, valor_unidade, categoria_produto_id, fornecedor_id)
VALUES
('Fios Elétricos', 'Fios de cobre para instalações elétricas', 20.00, 4, 1),
('Interruptor', 'Interruptor simples para circuito', 8.00, 4, 2),
('Tomada', 'Tomada de 10A para instalação', 5.00, 4, 3),
('Disjuntor', 'Disjuntor de 15A para proteção elétrica', 25.00, 4, 4),
('Lâmpada LED', 'Lâmpada LED 10W para iluminação', 18.00, 4, 5),
('Fita Isolante', 'Fita isolante de 10m', 7.00, 4, 6),
('Placa de Circuito', 'Placa de circuito para montagem elétrica', 12.00, 4, 7),
('Conector Elétrico', 'Conector para fiação elétrica', 3.50, 4, 8),
('Relé Elétrico', 'Relé de proteção elétrica para circuitos', 35.00, 4, 9),
('Caixa de Distribuição', 'Caixa de distribuição de energia elétrica', 150.00, 4, 10);
-- Produtos para a categoria "Hidráulica"
INSERT INTO produto(nome, descricao, valor_unidade, categoria_produto_id, fornecedor_id)
VALUES
('Tubo PVC', 'Tubo PVC para encanamento de água', 10.00, 5, 1),
('Conexão PVC', 'Conexão PVC para unir tubos de encanamento', 5.00, 5, 2),
('Registro de Água', 'Registro de água para controle de fluxo', 20.00, 5, 3),
('Válvula de Descarga', 'Válvula de descarga para sanitários', 45.00, 5, 4),
('Mangueira de Jardim', 'Mangueira para irrigação e jardinagem', 35.00, 5, 5),
('Caixa D\'Água', 'Caixa d\'água de 1000L', 450.00, 5, 6),
('Torneira de Parede', 'Torneira de parede para banheiro e cozinha', 30.00, 5, 7),
('Filtro de Água', 'Filtro de água para sistemas residenciais', 60.00, 5, 8),
('Bomba Submersível', 'Bomba submersível para poços e reservatórios', 250.00, 5, 9),
('Boia para Caixa D\'Água', 'Boia para controle de nível de água em caixas', 10.00, 5, 10);

-- [Teste]
-- Iniciar cada produto com 100 de
-- quantidade disponivel
UPDATE produto
SET quantidade_disponivel = 100
WHERE produto_id > 0;

-- Movimentações no estoque
--
-- Os valores totais são primeiramente definidos como NULL
-- e em seguida a partir do trigger, atualizamos os respectivos
-- valores totais a partir dos valores unitários.
INSERT INTO movimentacao(tipo_fluxo, quantidade, valor_total, motivo, produto_id)
VALUES
('Entrada', 10, NULL, 'Reposição de estoque', 1),   -- Tinta Acrílica
('Entrada', 20, NULL, 'Reposição de estoque', 1),   -- Tinta Acrílica
('Entrada', 30, NULL, 'Reposição de estoque', 1),   -- Tinta Acrílica
('Saída', 50, NULL, 'Venda do produto', 2),          -- Tinta PVA
('Entrada', 8, NULL, 'Reposição de estoque', 3),    -- Tinta Epóxi
('Saída', 30, NULL, 'Venda do produto', 4),           -- Tinta Spray
('Entrada', 15, NULL, 'Reposição de estoque', 5),  -- Tinta Verniz
('Saída', 7, NULL, 'Venda do produto', 6),          -- Tinta Solvente
('Entrada', 12, NULL, 'Reposição de estoque', 7),   -- Tinta Imprimante
('Saída', 4, NULL, 'Venda do produto', 8),          -- Tinta Automotiva
('Entrada', 10, NULL, 'Reposição de estoque', 9),   -- Tinta Para Madeira
('Saída', 6, NULL, 'Venda do produto', 10),         -- Tinta de Piso
('Entrada', 5, NULL, 'Reposição de estoque', 11),   -- Martelo
('Saída', 10, NULL, 'Venda do produto', 11),          -- Martelo 
('Saída', 15, NULL, 'Venda do produto', 11),          -- Martelo 
('Saída', 2, NULL, 'Venda do produto', 13),          -- Alicate de Corte 
('Entrada', 5, NULL, 'Reposição de estoque', 15),  -- Parafusadeira
('Saída', 3, NULL, 'Venda do produto', 16),         -- Furadeira
('Entrada', 7, NULL, 'Reposição de estoque', 17),   -- Chave de Fenda
('Saída', 4, NULL, 'Venda do produto', 18),         -- Esmerilhadeira
('Entrada', 6, NULL, 'Reposição de estoque', 19),  -- Plaina Elétrica
('Saída', 3, NULL, 'Venda do produto', 20),         -- Cortador de Cerâmica
('Entrada', 10, NULL, 'Reposição de estoque', 21),  -- Cimento
('Saída', 5, NULL, 'Venda do produto', 22),         -- Areia
('Entrada', 8, NULL, 'Reposição de estoque', 23),   -- Brita
('Saída', 6, NULL, 'Venda do produto', 24),           -- Tijolo
('Entrada', 12, NULL, 'Reposição de estoque', 25),  -- Cal
('Saída', 7, NULL, 'Venda do produto', 26),        -- Madeira Pinus
('Entrada', 9, NULL, 'Reposição de estoque', 27),   -- Tubos PVC
('Saída', 4, NULL, 'Venda do produto', 28),         -- Tinta Para Piso
('Saída', 20, NULL, 'Venda do produto', 28),         -- Tinta Para Piso
('Saída', 30, NULL, 'Venda do produto', 28),         -- Tinta Para Piso
('Entrada', 11, NULL, 'Reposição de estoque', 29),  -- Massa Corrida
('Saída', 3, NULL, 'Venda do produto', 30),         -- Revestimento Cerâmico
('Entrada', 10, NULL, 'Reposição de estoque', 9),   -- Tinta Para Madeira 
('Saída', 5, NULL, 'Venda do produto', 14),         -- Serra de Cinta 
('Entrada', 7, NULL, 'Reposição de estoque', 20),   -- Cortador de Cerâmica 
('Saída', 6, NULL, 'Venda do produto', 5),          -- Tinta Verniz 
('Entrada', 5, NULL, 'Reposição de estoque', 16);   -- Furadeira
