-- 1. Load the clientes CSV into stg_clientes with a separate COPY command.
-- 2. Run this script to quarantine invalid records and promote valid records.

CREATE TABLE
IF NOT EXISTS stg_clientes
(
    IDCliente INT,
    Cliente VARCHAR
(50),
    Estado VARCHAR
(2),
    Sexo CHAR
(1),
    Status VARCHAR
(50)
);

CREATE TABLE
IF NOT EXISTS quarantine_clientes
(
    IDCliente INT,
    Cliente VARCHAR
(50),
    Estado VARCHAR
(2),
    Sexo CHAR
(1),
    Status VARCHAR
(50),
    error_reason VARCHAR
(500),
    quarantined_at TIMESTAMP DEFAULT GETDATE
()
);

-- Store every row that fails one or more validation rules.
INSERT INTO quarantine_clientes
    (
    IDCliente,
    Cliente,
    Estado,
    Sexo,
    Status,
    error_reason
    )

WITH
    duplicate_ids
    AS
    (
        SELECT IDCliente
        FROM stg_clientes
        WHERE IDCliente IS NOT NULL
        GROUP BY IDCliente
        HAVING COUNT(*) > 1
    )
SELECT
    s.IDCliente,
    s.Cliente,
    s.Estado,
    s.Sexo,
    s.Status,
    RTRIM(
        CASE WHEN s.IDCliente IS NULL THEN 'null_idcliente;' ELSE '' END ||
        CASE WHEN s.Cliente IS NULL THEN 'null_cliente;' ELSE '' END ||
        CASE WHEN s.Estado IS NULL THEN 'null_estado;' ELSE '' END ||
        CASE WHEN s.Sexo IS NULL THEN 'null_sexo;' ELSE '' END ||
        CASE WHEN s.Status IS NULL THEN 'null_status;' ELSE '' END ||
        CASE WHEN d.IDCliente IS NOT NULL THEN 'duplicate_idcliente;' ELSE '' END,
        ';'
    ) AS error_reason
FROM stg_clientes AS s
    LEFT JOIN duplicate_ids AS d
    ON s.IDCliente = d.IDCliente
WHERE s.IDCliente IS NULL
    OR s.Cliente IS NULL
    OR s.Estado IS NULL
    OR s.Sexo IS NULL
    OR s.Status IS NULL
    OR d.IDCliente IS NOT NULL;

-- Promote only valid, unique staging records that are new to Clientes.
INSERT INTO Clientes
    (
    IDCliente,
    Cliente,
    Estado,
    Sexo,
    Status
    )

WITH
    duplicate_ids
    AS
    (
        SELECT IDCliente
        FROM stg_clientes
        WHERE IDCliente IS NOT NULL
        GROUP BY IDCliente
        HAVING COUNT(*) > 1
    )

SELECT
    s.IDCliente,
    s.Cliente,
    s.Estado,
    s.Sexo,
    s.Status
FROM stg_clientes AS s
    LEFT JOIN duplicate_ids AS d
    ON s.IDCliente = d.IDCliente
    LEFT JOIN Clientes AS c
    ON s.IDCliente = c.IDCliente
WHERE s.IDCliente IS NOT NULL
    AND s.Cliente IS NOT NULL
    AND s.Estado IS NOT NULL
    AND s.Sexo IS NOT NULL
    AND s.Status IS NOT NULL
    AND d.IDCliente IS NULL
    AND c.IDCliente IS NULL;
