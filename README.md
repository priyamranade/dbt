# DBT + Databricks Installation Guide

This guide explains how to set up a local **dbt Core** project with **Databricks** as the adapter using `uv` for environment and package management. dbt keeps project settings in `dbt_project.yml` and connection settings in `profiles.yml`, which usually lives in `~/.dbt/` instead of the project folder.[1][2]

## Prerequisites

Make sure these tools are installed before starting:

- Python 3.12.x
- Git
- Visual Studio Code
- A Databricks workspace with access to a SQL warehouse
- A Databricks personal access token
- `uv`

## 1. Install Python

Install Python 3.12.x and make sure it is added to PATH.

Verify the installation:

```bash
python --version
```

## 2. Install Git

Install Git and confirm it is available:

```bash
git --version
```

Git is used to track project changes and publish the repository to GitHub.

## 3. Install uv

Install `uv` and verify it:

```bash
uv --version
```

`uv` manages the local virtual environment and project dependencies.

## 4. Create the project folder

```bash
mkdir dbt_project
cd dbt_project
```

## 5. Initialize the Python environment

```bash
uv init
uv sync
```

- `uv init` creates the project metadata.
- `uv sync` creates the `.venv` environment and installs dependencies from the project definition.

## 6. Install dbt packages

```bash
uv add dbt-core
uv add dbt-databricks
```

- `dbt-core` installs the dbt CLI.
- `dbt-databricks` adds the Databricks adapter so dbt can connect to Databricks.[2]

## 7. Activate the virtual environment

### Windows

```bash
.venv\Scripts\activate
```

### macOS / Linux

```bash
source .venv/bin/activate
```

## 8. Verify dbt installation

```bash
dbt --version
```

This confirms that dbt is installed correctly in the environment.

## 9. Initialize the dbt project

```bash
dbt init
```

During setup, enter the required connection details:

- Project name: `dbt_project`
- Adapter: `Databricks`
- Host: your Databricks workspace host
- HTTP path: your SQL warehouse HTTP path
- Token: your Databricks personal access token
- Catalog: your target catalog
- Schema: your target schema, for example `default`

Databricks connection details come from the SQL warehouse and developer settings in Databricks.[2]

## 10. Locate `profiles.yml`

Run:

```bash
dbt debug --config-dir
```

dbt normally reads `profiles.yml` from the user config directory, typically `~/.dbt/`.[1][3]

Typical Windows path:

```text
C:\Users\<your-username>\.dbt\profiles.yml
```

If the file does not exist, create it in that location.

## 11. Open the project in VS Code

Open the project folder in VS Code. If needed, install the **dbt Power User** extension for better dbt development support.

Useful locations:

- `dbt_project.yml` — project configuration
- `models/` — SQL models
- `macros/` — reusable Jinja macros
- `target/` — compiled output after running dbt
- `~/.dbt/profiles.yml` — connection configuration[1]

## 12. Initialize Git

```bash
git init
git add .
git commit -m "Initial commit"
```

This creates the first local commit for the project.

## 13. Organize the models folder

A common starter layout is:

```text
models/
  bronze/
  silver/
  gold/
  source/
```

This keeps the project easier to understand as it grows.

## 14. Add source definitions

Create a `source.yml` file inside `models/source/` to define input tables.

Example:

```sql
select * from {{ source('your_source_name', 'table_name') }}
```

This lets dbt reference source tables in a reusable and modular way.

## 15. Validate and run the project

Run:

```bash
dbt debug
dbt run
```

- `dbt debug` validates the connection and project configuration.[3]
