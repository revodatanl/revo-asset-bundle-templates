# RevoData Bundle Templates

[![python](https://upload.wikimedia.org/wikipedia/commons/1/16/Blue_Python_3.10%2B_Shield_Badge.svg)](https://www.python.org)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![Checked with mypy](http://www.mypy-lang.org/static/mypy_badge.svg)](http://mypy-lang.org/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

[![unit_tests](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/unit_test.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/unit_test.yml)
[![check_formatting](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/check_formatting.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/check_formatting.yml)
[![check_python_packaging](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/check_python_packaging.yml/badge.svg)](https://github.com/revodatanl/revo-asset-bundle-templates/actions/workflows/check_python_packaging.yml)

The `RevoData Bundle Templates` contains our own custom templates for Databricks Asset Bundles. The template should initate a complete development environment for new Databricks projects, including GitHub Actions, pre-commit hooks, and example pipelines and jobs that can be deployed to Databricks.

Shout out to [Georgel Preput](https://github.com/GeorgelPreput) for providing the foundation for this template!

## Getting started

1. Install the Databricks CLI from <https://docs.databricks.com/dev-tools/cli/databricks-cli.html>

2. Initialize a new project using the template:

   ```bash
   databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates
   ```

This will create a new directory with the template files. You can now start developing your project.
