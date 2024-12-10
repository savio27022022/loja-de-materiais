-- Utilizar o banco
USE LojaDeMateriais;

-- Exemplo de uso
SELECT *
FROM produto
WHERE categoria_id = 3
AND quantidade_disponivel > 0
ORDER BY nome_produto
LIMIT 50;
