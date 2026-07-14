# RevoData Declarative Automation Bundle Templates

![Databricks Runtime](https://img.shields.io/badge/Databricks%20Runtime-16.4--LTS-%231B3139)
[![python](https://img.shields.io/badge/python-3.12-g)](https://www.python.org)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![Checked with ty](https://img.shields.io/badge/type%20checked-ty-261230.svg)](https://github.com/astral-sh/ty)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

[![CI](https://github.com/revodatanl/revo-dabs/actions/workflows/ci-dabs.yml/badge.svg)](https://github.com/revodatanl/revo-dabs/actions/workflows/ci-dabs.yml)
[![semantic-release](https://github.com/revodatanl/revo-dabs/actions/workflows/semantic-release.yml/badge.svg)](https://github.com/revodatanl/revo-dabs/actions/workflows/semantic-release.yml)
![just](https://img.shields.io/badge/%F0%9F%A4%96%20just-%3E1.25-000000?style=plastic&color=lime&link=https%3A%2F%2Fjust.systems%2Fman%2Fen%2F)

The `RevoData Declarative Automation Bundle Templates` repo contains our own custom templates for Declarative Automation Bundles (formerly Databricks Asset Bundles). The template provides a complete development environment for new Databricks projects, including CI/CD pipelines, pre-commit hooks, semantic release, and example pipelines and jobs that can directly be deployed to Databricks.

## Why This Template?

This template solves common pain points in Databricks project setup:

- **Streamlined Setup**: One command creates a fully configured development environment
- **Modern Python Tooling**: Uses `uv` for fast package management, `ruff` for linting, and `ty` for type checking
- **Modular Architecture**: Core template is lightweight, with experimental accelerators (work in progress) for specialized needs
- **CI/CD Ready**: Complete pipelines for GitHub Actions and Azure DevOps
- **Development Environment**: DevContainer and WSL support for consistent development across platforms

## Getting started

1. Install the [Databricks CLI](https://docs.databricks.com/en/dev-tools/cli/index.html) by running the following command:

    ```bash
    brew tap databricks/tap
    brew install databricks
    ```

    Make sure to add your [configuration profile](https://docs.databricks.com/en/dev-tools/cli/profiles.html) to the `.databrickscfg` file. You will need the name of your profile to initialize a new project.

2. Initialize a new project using the template:

    ```bash
    databricks bundle init https://github.com/revodatanl/revo-dabs
    ```

    ![bundle-init](images/bundle-init.png)

    When initializing your project, you'll be prompted to answer several questions. These configurations will be used to customize your project:

    | Parameter | Description | Example | Condition |
    | --------- | ----------- | ------- | --------- |
    | `project_name` | Name of the project (usually the same as the repository name) | `revo-dabs-test-project` | |
    | `project_description` | Brief description of the project | `This project is generated using our own RevoData Declarative Automation Bundle Templates.` | |
    | `author` | Name of the author | `Thomas Brouwer` | |
    | `email` | Email address of the author | `thomas.brouwer@revodata.nl` | |
    | `setup_type` | Type of setup (`default`, `minimal` or `tailored`) | `default` | |
    | `include_cicd` | Set up CI/CD pipeines | `yes/no` | `setup_type` = `tailored` |
    | `cicd_provider` | CI/CD provider | `github/azure` | `include_cicd` = `yes` |
    | `cloud_provider` | Cloud provider (skipped if `include_cicd` = `no`) | `azure/aws` | `include_cicd` = `yes` |
    | `include_example_jobs` | Whether to include example pipelines and jobs | `yes/no` | `setup_type` = `tailored` |
    | `support_windows` | Whether to include Windows support | `yes/no` | `setup_type` = `tailored` |
    | `include_dab_recipes` | Whether to include just recipes for Databricks Bundle commands | `yes/no` | `setup_type` = `tailored` |
    | `empower_vscode` | Whether to include VS Code settings, extension recommendations, and just recipes | `yes/no` | `setup_type` = `tailored` |

    > Previously, specifying a `package_name` was required. The `package_name` is now automatically generated from the `project_name` by replacing dashes (`-`) with underscores (`_`) following Python package naming conventions.

    This table contains the values passed for setup types `default` and `minimal`. When `setup_type` is `tailored`, the values are determined by the user's choices.

    | Parameter | Default | Minimal |
    | --------- | ------- | ------- |
    | `include_cicd` | `yes` | `no` |
    | `cicd_provider` | `azure` | `` |
    | `cloud_provider` | `azure` | `` |
    | `include_example_jobs` | `yes` | `no` |
    | `support_windows` | `yes` | `no` |
    | `include_dab_recipes` | `yes` | `no` |
    | `empower_vscode` | `yes` | `no` |

3. Set up a fully configured development environment by running:

    ```bash
    just
    ```

## Developing the Template

Declarative Automation Bundle Templates use `Go` template syntax with conditional logic based on the parameters above.

Key development files:

- `template/__preamble.tmpl` - Controls file inclusion using `{{skip}}` directives
- `databricks_template_schema.json` - Defines template variables and validation
- Files with `.tmpl` extension are rendered with `{{.parameter_name}}` replaced accordingly

Test locally using:

```bash
databricks bundle init https://github.com/revodatanl/revo-dabs --branch <branch_name>
```

Changes are protected by comprehensive CI-DABS pipeline testing all template configurations.
