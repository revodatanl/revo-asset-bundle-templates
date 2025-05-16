# RevoData Asset Bundle Templates

![Databricks Runtime](https://img.shields.io/badge/Databricks%20Runtime-15.4--LTS-%231B3139)
[![python](https://img.shields.io/badge/python-3.11-g)](https://www.python.org)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![Checked with mypy](http://www.mypy-lang.org/static/mypy_badge.svg)](http://mypy-lang.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

[![CI](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/ci-dabs.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/ci-dabs.yml)
[![semantic-release](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/semantic-release.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/semantic-release.yml)

The `RevoData Asset Bundle Templates` repo contains our own custom templates for Databricks Asset Bundles. The template provides a complete development environment for new Databricks projects, including CI/CD pipelines, pre-commit hooks, semantic release, and example pipelines and jobs that can directly be deployed to Databricks.

Shout out to [Georgel Preput](https://github.com/GeorgelPreput) for providing the foundation for this template!

## Getting started

1. Install the [Databricks CLI](https://docs.databricks.com/en/dev-tools/cli/index.html) by running the following command:

    ```bash
    brew tap databricks/tap
    brew install databricks
    ```

    Make sure to add your [configuration profile](https://docs.databricks.com/en/dev-tools/cli/profiles.html) to the `.databrickscfg` file. You will need the name of your profile to initialize a new project.

2. Initialize a new project using the template:

    ```bash
    databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates
    ```

    When initializing your project, you'll be prompted to answer several questions. These configurations will be used to customize your project:

    | Parameter | Description | Example |
    |-----------|-------------|---------------------|
    | `project_name` | Name of the project (usually the same as the repository name) | `revo-dabs-test-project` |
    | `package_name` | Name of the package. Import functions from the package with `from <package_name> import <function_name>` | `revo_dabs` |
    | `author` | Name of the author | `Thomas Brouwer` |
    | `email` | Email address of the author | `thomas.brouwer@revodata.nl` |
    | `project_description` | Brief description of the project | `This project is generated using our own RevoData Asset Bundle Templates.` |
    | `cicd_provider` | CI/CD provider | `github/azure` |
    | `cloud_provider` | Cloud provider | `azure/aws` |
    | `include_example_jobs` | Whether to include example DLT pipeline and jobs | `yes/no` |
    | `use_devcontainer` | Whether to develop in a DevContainer (recommended for Windows users) | `yes/no` |

    ![bundle-init](docs/images/bundle-init.png)
