# Employee Data Warehouse with dbt + SQL Server

A portfolio-ready learning project implementing **Staging** and **DWH** layers with dbt on Microsoft SQL Server.

> Dataset note: this repository includes a small, fictional/demo HR dataset generated for reproducible practice. It is not a real company's employee data. The SQL setup script creates the database and tables locally.

## Architecture

```text
SQL Server (DEPI_DBT_HR)
  └── dbo source tables
       ├── employees
       ├── departments
       ├── countries
       └── genders
             ↓ dbt source()
       Staging (views)
       ├── stg_employees
       ├── stg_departments
       ├── stg_countries
       └── stg_genders
             ↓ dbt ref()
       DWH (tables/views)
       ├── dim_employee
       ├── dim_department
       ├── dim_country
       ├── dim_gender
       ├── dim_date
       └── fact_employee
             ↓
       Data tests + generated dbt docs
```

## Project requirements covered

- Staging and DWH layers.
- Separate `schema.yml` files for Staging and DWH.
- Generic tests: `not_null`, `unique`, `accepted_values`, `relationships`, and a custom `positive_salary` test.
- Singular tests in `tests/`.
- Custom macros in `macros/`.
- Model and column documentation.
- A SQL Server database setup script.
- README and a LinkedIn post draft.

## Prerequisites

- SQL Server 2017+ (Developer or Express is suitable).
- SQL Server Management Studio (SSMS) or Azure Data Studio.
- Python supported by your installed `dbt-sqlserver` version.
- Microsoft ODBC Driver 17 or 18 for SQL Server.
- VS Code (recommended).

## 1. Create the demo database

1. Open SSMS and connect to your local SQL Server instance.
2. Open `database/01_create_demo_database.sql`.
3. Execute the entire script.
4. Confirm that `DEPI_DBT_HR` appears in Object Explorer and contains the four tables under `dbo`.

The script drops and recreates the demo database if it already exists. **Do not run it against a database containing data you need.**

## 2. Install dbt adapter

Open a terminal in the project folder and create a virtual environment:

### Windows PowerShell

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

If PowerShell blocks activation, use Command Prompt and run:

```bat
.venv\Scripts\activate.bat
```

The SQL Server adapter also needs the Microsoft ODBC driver installed on Windows.

## 3. Configure your dbt profile

Copy `profiles/profiles.yml.example` to the dbt profile location:

`%USERPROFILE%\.dbt\profiles.yml`

Edit the values for your machine. The profile name must match `profile: depi_dbt` in `dbt_project.yml`.

- `server`: your SQL Server instance name. Common examples are `localhost`, `localhost\\SQLEXPRESS`, or `YOUR-PC\\SQLEXPRESS`.
- `database`: `DEPI_DBT_HR`
- `schema`: `dbo` is the target schema where dbt creates its models; use a dedicated target schema if your permissions allow it.
- Choose the authentication configuration supported by your SQL Server. The example uses SQL Server username/password. Do not commit real credentials to GitHub.
- `driver` must match an ODBC driver installed on your computer.

The exact adapter profile fields can vary by installed `dbt-sqlserver` version. Consult the current adapter instructions if `dbt debug` reports an invalid profile field:
https://github.com/dbt-msft/dbt-sqlserver

## 4. Install dependencies and verify

From the project root:

```bash
dbt --version
dbt debug
dbt parse
```

Fix connection/profile errors before continuing. `dbt debug` must pass before dbt can query the SQL Server database.

## 5. Build and test

```bash
dbt build
```

This builds the selected models in dependency order and runs applicable tests. For a separate run:

```bash
dbt run
dbt test
```

Check the output carefully. A test failure means the data did not meet the assertion; investigate it rather than hiding or removing the test.

## 6. Generate documentation

```bash
dbt docs generate
dbt docs serve
```

Open the local URL printed by dbt. The generated docs include model descriptions, column descriptions, and lineage.

## Project folders

- `database/`: SQL Server database creation script and sample data.
- `models/staging/`: source-facing cleanup/standardization views and source definitions.
- `models/dwh/`: dimensions and employee fact model.
- `models/marts/`: example reporting model.
- `tests/`: singular SQL data tests.
- `macros/`: reusable SQL/Jinja macros and a custom generic test.
- `analyses/`: ad-hoc analysis query.
- `profiles/`: example profile template only; copy it to `~/.dbt/profiles.yml` and fill credentials locally.

## Data model notes

- `dim_employee` contains one row per employee and joins to department, country, and gender dimensions.
- `dim_date` contains the distinct birth dates present in the source dataset. It is a small date dimension for this demo, not a full calendar.
- `fact_employee` has one row per employee, with dimension keys and salary. This is a simple demo fact model; in a production warehouse, define the business grain and measures with stakeholders.
- Surrogate keys are generated with SQL Server `HASHBYTES` in a reusable macro.
- `calculate_age` is a SQL Server-specific macro.

## Before publishing

- Run `dbt debug`, `dbt build`, and `dbt docs generate` on your own machine.
- Replace any screenshots in your post with screenshots from your actual run.
- Do not claim tests passed unless they did.
- Never commit credentials, local logs, `.venv`, or generated `target/` files.
