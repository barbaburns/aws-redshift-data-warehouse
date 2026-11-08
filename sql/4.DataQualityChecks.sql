-- Run this read-only report in Amazon Redshift after loading the source tables.

SELECT
    'Vendedores' AS table_name,
    'Duplicate primary key values in IDVendedor' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendedores
WHERE IDVendedor IN (
    SELECT IDVendedor
    FROM Vendedores
    WHERE IDVendedor IS NOT NULL
    GROUP BY IDVendedor
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'Produtos' AS table_name,
    'Duplicate primary key values in IDProduto' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Produtos
WHERE IDProduto IN (
    SELECT IDProduto
    FROM Produtos
    WHERE IDProduto IS NOT NULL
    GROUP BY IDProduto
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'Clientes' AS table_name,
    'Duplicate primary key values in IDCliente' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes
WHERE IDCliente IN (
    SELECT IDCliente
    FROM Clientes
    WHERE IDCliente IS NOT NULL
    GROUP BY IDCliente
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'Vendas' AS table_name,
    'Duplicate primary key values in IDVenda' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas
WHERE IDVenda IN (
    SELECT IDVenda
    FROM Vendas
    WHERE IDVenda IS NOT NULL
    GROUP BY IDVenda
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'ItensVenda' AS table_name,
    'Duplicate primary key values in IDProduto and IDVenda' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda AS i
INNER JOIN (
    SELECT IDProduto, IDVenda
    FROM ItensVenda
    WHERE IDProduto IS NOT NULL
      AND IDVenda IS NOT NULL
    GROUP BY IDProduto, IDVenda
    HAVING COUNT(*) > 1
) AS duplicate_keys
    ON i.IDProduto = duplicate_keys.IDProduto
   AND i.IDVenda = duplicate_keys.IDVenda

UNION ALL

SELECT
    'Vendedores' AS table_name,
    'Duplicate values in Nome (informational)' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendedores
WHERE Nome IN (
    SELECT Nome
    FROM Vendedores
    WHERE Nome IS NOT NULL
    GROUP BY Nome
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'Produtos' AS table_name,
    'Duplicate values in Produto (informational)' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Produtos
WHERE Produto IN (
    SELECT Produto
    FROM Produtos
    WHERE Produto IS NOT NULL
    GROUP BY Produto
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'Clientes' AS table_name,
    'Duplicate values in Cliente (informational)' AS check_name,
    COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes
WHERE Cliente IN (
    SELECT Cliente
    FROM Clientes
    WHERE Cliente IS NOT NULL
    GROUP BY Cliente
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT 'Vendedores' AS table_name, 'NULL values in IDVendedor' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendedores WHERE IDVendedor IS NULL

UNION ALL

SELECT 'Vendedores' AS table_name, 'NULL values in Nome' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendedores WHERE Nome IS NULL

UNION ALL

SELECT 'Produtos' AS table_name, 'NULL values in IDProduto' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Produtos WHERE IDProduto IS NULL

UNION ALL

SELECT 'Produtos' AS table_name, 'NULL values in Produto' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Produtos WHERE Produto IS NULL

UNION ALL

SELECT 'Produtos' AS table_name, 'NULL values in Preco' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Produtos WHERE Preco IS NULL

UNION ALL

SELECT 'Clientes' AS table_name, 'NULL values in IDCliente' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes WHERE IDCliente IS NULL

UNION ALL

SELECT 'Clientes' AS table_name, 'NULL values in Cliente' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes WHERE Cliente IS NULL

UNION ALL

SELECT 'Clientes' AS table_name, 'NULL values in Estado' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes WHERE Estado IS NULL

UNION ALL

SELECT 'Clientes' AS table_name, 'NULL values in Sexo' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes WHERE Sexo IS NULL

UNION ALL

SELECT 'Clientes' AS table_name, 'NULL values in Status' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Clientes WHERE Status IS NULL

UNION ALL

SELECT 'Vendas' AS table_name, 'NULL values in IDVenda' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas WHERE IDVenda IS NULL

UNION ALL

SELECT 'Vendas' AS table_name, 'NULL values in IDVendedor' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas WHERE IDVendedor IS NULL

UNION ALL

SELECT 'Vendas' AS table_name, 'NULL values in IDCliente' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas WHERE IDCliente IS NULL

UNION ALL

SELECT 'Vendas' AS table_name, 'NULL values in Data' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas WHERE Data IS NULL

UNION ALL

SELECT 'Vendas' AS table_name, 'NULL values in Total' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Vendas WHERE Total IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in IDProduto' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE IDProduto IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in IDVenda' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE IDVenda IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in Quantidade' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE Quantidade IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in ValorUnitario' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE ValorUnitario IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in ValorTotal' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE ValorTotal IS NULL

UNION ALL

SELECT 'ItensVenda' AS table_name, 'NULL values in Desconto' AS check_name, COUNT(*) AS invalid_row_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM ItensVenda WHERE Desconto IS NULL;
