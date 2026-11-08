# AWS Redshift Data Warehouse

## Overview

This repository documents a hands-on data warehouse exercise completed as part of a Udemy data engineering course. The project uses sales data stored in CSV files, loads it from Amazon S3 into Amazon Redshift, and uses Google Data Studio to build a dashboard for analysis.

## Architecture

![alt text](arquitetura.png)

## Data Model

The warehouse schema models a sales scenario with the following tables:

-   `Vendedores`: sales representatives.
-   `Produtos`: product catalog and prices.
-   `Clientes`: customer details.
-   `Vendas`: sales transactions, linked to customers and sales representatives.
-   `ItensVenda`: line items for each sale, including product, quantity, value, and discount information.

The table definitions, primary keys, and relationships are available in [sql/1.CreateTables.sql](sql/1.CreateTables.sql).
The Copy command is avaiable in [sql/2.Copy.sql](sql/copy.sql).
The denormalized table script is avaiable in [sql/3.DenormalizedTable](sql/3.DenormalizedTable.sql)

## Workflow

1. Create the data warehouse tables in Amazon Redshift using SQL.
2. Store the source CSV files in an Amazon S3 bucket.
3. Load the CSV data from S3 into the corresponding Redshift tables using the SQL COPY command.
4. Create a denormalized table.
5. Connect Google Data Studio to the warehouse and build a dashboard for data exploration.

## Data Modeling and Denormalization

After loading the source data from Amazon S3 into Amazon Redshift using the SQL COPY command, a denormalized table was created to support analytical queries and dashboard development.

The denormalized table consolidates data from multiple source tables into a single structure, reducing the need for complex joins during data analysis.

## Purpose

-   Simplify analytical queries.

-   Reduce the need for repeated joins across source tables.

-   Prepare data for dashboard visualization.

-   Improve accessibility of business metrics and reporting.

## Data Quality Checks

After loading the source tables with the `COPY` command, run the [data quality report](sql/4.DataQualityChecks.sql) in Amazon Redshift. The script is read-only and returns one row for each validation rule with `table_name`, `check_name`, `invalid_row_count`, and `status`.

The report checks:

- Duplicate primary-key values in the imported tables.
- Duplicate values in `Vendedores.Nome`, `Produtos.Produto`, and `Clientes.Cliente`. These findings are informational and should be reviewed in the business context.
- `NULL` values in every column defined in the source-table schema.

## Repository Structure

```text
.
├── sql/
│   └── 1.CreateTables.sql
│   └── 2.Copy.sql
│   └── 3.DenormalizedTable.sql
│   └── 4.DataQualityChecks.sql
└── tables/
    ├── clientes.csv
    ├── itensvenda.csv
    ├── produtos.csv
    ├── vendedores.csv
    └── vendas.csv
```

-   [Table creation script](sql/1.CreateTables.sql)
-   [Data Ingestion script](sql/2.Copy.sql)
-   [Denormalized table creation script](sql/3.DenormalizedTable.sql)
-   [Data quality report](sql/4.DataQualityChecks.sql)
-   Source data: [clientes.csv](tables/clientes.csv), [itensvenda.csv](tables/itensvenda.csv), [produtos.csv](tables/produtos.csv), [vendedores.csv](tables/vendedores.csv), and [vendas.csv](tables/vendas.csv)

## Skills Demonstrated

-   Data warehousing concepts
-   Amazon Redshift
-   Amazon S3
-   SQL table design and relationships
-   CSV data ingestion
-   Google Data Studio dashboard development

## Notes

This is an educational portfolio project. It demonstrates the end-to-end flow from raw CSV files in Amazon S3 to a Redshift data warehouse and a Google Data Studio dashboard.
