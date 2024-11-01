# RevoData Asset Bundle Templates

[![python](https://img.shields.io/badge/python-3.11-g)](https://www.python.org)
[![Poetry](https://img.shields.io/endpoint?url=https://python-poetry.org/badge/v0.json)](https://python-poetry.org/)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![Checked with mypy](http://www.mypy-lang.org/static/mypy_badge.svg)](http://mypy-lang.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
![macOS](https://img.shields.io/badge/os-macOS-lightgrey?logo=apple)
[![semantic-release](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/semantic-release.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/semantic-release.yml)

The `RevoData Asset Bundle Templates` repo contains our own custom templates for Databricks Asset Bundles. The template provides a complete development environment for new Databricks projects, including GitHub Actions, pre-commit hooks, semantic release, and example pipelines and jobs that can be deployed to Databricks.

Shout out to [Georgel Preput](https://github.com/GeorgelPreput) for providing the foundation for this template!

## Getting started

1. Install the [Databricks CLI](https://docs.databricks.com/dev-tools/cli/databricks-cli) by running the following command:

```bash
brew tap databricks/tap
brew install databricks
```

Make sure to add your [configuration profile](https://docs.databricks.com/en/dev-tools/cli/profiles.html) to the `.databrickscfg` file. You will need the name of your profile to initialize a new project.

2. Initialize a new project using the template:

```bash
databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates
```

This will create a new directory with the template files. You can now start developing your project.

![bundle-init](assets/bundle-init.png)
