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

## Workflow

The exercise currently demonstrates direct ingestion into the warehouse tables. The following is the recommended quality-focused flow for evolving the project:

1. Store the source CSV files in an Amazon S3 bucket as the raw data layer.
2. Load the data into staging tables in Amazon Redshift with the SQL `COPY` command.
3. Run data-quality checks for duplicate keys, repeated business values, and `NULL` values.
4. Send invalid records to a quarantine layer with the validation reason for review.
5. Promote only approved records from staging to the warehouse tables.
6. Create the denormalized analytical table from the approved warehouse data.
7. Connect Google Data Studio to the analytical layer for dashboard development.

### Staging and Quarantine

Use `COPY` to load the client CSV into `stg_clientes`, run the [data quality report](sql/4.DataQualityChecks.sql) in Amazon Redshift. The script is read-only and returns one row for each validation rule with `table_name`, `check_name`, `invalid_row_count`, and `status`. In a staging-based implementation, run the equivalent checks before promoting records to the warehouse tables.

The report checks:

-   Duplicate primary-key values in the imported tables.
-   Duplicate values in `Vendedores.Nome`, `Produtos.Produto`, and `Clientes.Cliente`. These findings are informational and should be reviewed in the business context.
-   `NULL` values in every column defined in the source-table schema.

If erros are found, then run the [Clientes staging and quarantine workflow](sql/2.ClientesStagingAndQuarantine.sql). The script sends records with null fields or duplicate `IDCliente` values to `quarantine_clientes`, recording every detected issue in `error_reason`.

Review the quarantined records before correcting and reloading the source data. Valid, unique records are promoted to `Clientes`, which can then be used by the warehouse and analytical layers. Repeated values in `Cliente` remain an informational finding in the data-quality report and are not quarantined automatically.

## ETL/ELT Context

This project follows an ELT-oriented workflow: source CSV files are extracted from Amazon S3 and loaded into Amazon Redshift staging tables before validation and transformation take place in the warehouse.

```text
CSV files / Amazon S3
    → stg_clientes
    → data quality validation and quarantine
    → Clientes warehouse table
    → denormalized analytical table
    → Google Data Studio dashboard
```

The data-quality layer is a cross-cutting part of the pipeline rather than a complete ETL process by itself. It identifies invalid records before they reach the warehouse and analytical layers.

## Data Modeling and Denormalization

After loading the source data from Amazon S3 into Amazon Redshift using the SQL COPY command, a denormalized table was created to support analytical queries and dashboard development.

The denormalized table consolidates data from multiple source tables into a single structure, reducing the need for complex joins during data analysis.

## Purpose

-   Simplify analytical queries.

-   Reduce the need for repeated joins across source tables.

-   Prepare data for dashboard visualization.

-   Improve accessibility of business metrics and reporting.

## Repository Structure

```text
.
├── sql/
│   └── 1.CreateTables.sql
│   └── 2.Copy.sql
│   └── 3.DenormalizedTable.sql
│   └── 4.DataQualityChecks.sql
│   └── 5.ClientesStagingAndQuarantine.sql
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
-   [Clientes staging and quarantine workflow](sql/5.ClientesStagingAndQuarantine.sql)
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
