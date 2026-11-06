# Redshift Data Warehouse Portfolio README Design

## Goal

Create an English README that presents this Udemy course exercise as a concise, honest data-engineering portfolio project.

## Audience and tone

The document is for recruiters and technical reviewers. It will use professional English and explicitly identify the work as a hands-on course project, without claiming production deployment or results not represented in the repository.

## Content

The README will include:

- A title and short project summary.
- A simple Mermaid architecture diagram: local CSV source files flow to an Amazon S3 bucket, then to Amazon Redshift, and finally to a Google Data Studio dashboard.
- A brief explanation of the data model, based on the available SQL: `Vendedores`, `Produtos`, `Clientes`, `Vendas`, and `ItensVenda`.
- A description of the workflow: provision the warehouse, create tables, upload CSV files to S3, load them into Redshift, and create dashboard visualizations.
- A repository structure section linking to the SQL script and CSV data files.
- A skills section limited to AWS Redshift, Amazon S3, SQL, CSV ingestion, data warehousing, and Google Data Studio.

## Boundaries

- Do not invent row counts, data volumes, AWS configuration details, ETL tooling, dashboard metrics, or deployment automation.
- Do not add executable infrastructure or change existing SQL/data files.
- Use Mermaid embedded in the README instead of a generated bitmap asset, keeping the architecture diagram versionable and visible on GitHub.

## Validation

Review the README as rendered Markdown and confirm its internal links target existing repository files.
