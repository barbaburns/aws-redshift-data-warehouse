-- Run this read-only report in Amazon Redshift after loading the source tables.

    SELECT
        'Vendedores' AS table_name,
        'Duplicate primary key values in IDVendedor' AS check_name,
        COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendedores
    WHERE IDVendedor IN (
    SELECT IDVendedor
    FROM stg_vendedores
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
    FROM stg_produtos
    WHERE IDProduto IN (
    SELECT IDProduto
    FROM stg_produtos
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
    FROM stg_clientes
    WHERE IDCliente IN (
    SELECT IDCliente
    FROM stg_clientes
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
    FROM stg_vendas
    WHERE IDVenda IN (
    SELECT IDVenda
    FROM stg_vendas
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
    FROM stg_itensVenda AS i
        INNER JOIN (
    SELECT IDProduto, IDVenda
        FROM stg_itensVenda
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
    FROM stg_vendedores
    WHERE Nome IN (
    SELECT Nome
    FROM stg_vendedores
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
    FROM stg_produtos
    WHERE Produto IN (
    SELECT Produto
    FROM stg_produtos
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
    FROM stg_clientes
    WHERE Cliente IN (
    SELECT Cliente
    FROM stg_clientes
    WHERE Cliente IS NOT NULL
    GROUP BY Cliente
    HAVING COUNT(*) > 1
)

UNION ALL

    SELECT 'Vendedores' AS table_name, 'NULL values in IDVendedor' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendedores
    WHERE IDVendedor IS NULL

UNION ALL

    SELECT 'Vendedores' AS table_name, 'NULL values in Nome' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendedores
    WHERE Nome IS NULL

UNION ALL

    SELECT 'Produtos' AS table_name, 'NULL values in IDProduto' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_produtos
    WHERE IDProduto IS NULL

UNION ALL

    SELECT 'Produtos' AS table_name, 'NULL values in Produto' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_produtos
    WHERE Produto IS NULL

UNION ALL

    SELECT 'Produtos' AS table_name, 'NULL values in Preco' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_produtos
    WHERE Preco IS NULL

UNION ALL

    SELECT 'Clientes' AS table_name, 'NULL values in IDCliente' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_clientes
    WHERE IDCliente IS NULL

UNION ALL

    SELECT 'Clientes' AS table_name, 'NULL values in Cliente' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_clientes
    WHERE Cliente IS NULL

UNION ALL

    SELECT 'Clientes' AS table_name, 'NULL values in Estado' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_clientes
    WHERE Estado IS NULL

UNION ALL

    SELECT 'Clientes' AS table_name, 'NULL values in Sexo' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_clientes
    WHERE Sexo IS NULL

UNION ALL

    SELECT 'Clientes' AS table_name, 'NULL values in Status' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_clientes
    WHERE Status IS NULL

UNION ALL

    SELECT 'Vendas' AS table_name, 'NULL values in IDVenda' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendas
    WHERE IDVenda IS NULL

UNION ALL

    SELECT 'Vendas' AS table_name, 'NULL values in IDVendedor' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendas
    WHERE IDVendedor IS NULL

UNION ALL

    SELECT 'Vendas' AS table_name, 'NULL values in IDCliente' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendas
    WHERE IDCliente IS NULL

UNION ALL

    SELECT 'Vendas' AS table_name, 'NULL values in Data' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendas
    WHERE Data IS NULL

UNION ALL

    SELECT 'Vendas' AS table_name, 'NULL values in Total' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_vendas
    WHERE Total IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in IDProduto' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE IDProduto IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in IDVenda' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE IDVenda IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in Quantidade' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE Quantidade IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in ValorUnitario' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE ValorUnitario IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in ValorTotal' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE ValorTotal IS NULL

UNION ALL

    SELECT 'ItensVenda' AS table_name, 'NULL values in Desconto' AS check_name, COUNT(*) AS invalid_row_count,
        CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
    FROM stg_itensVenda
    WHERE Desconto IS NULL;
