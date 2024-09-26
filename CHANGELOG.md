# Changelog

All notable changes to this project will be documented in this file.

## [0.5.0] - 2024-09-25

### 🚀 Features

- *(modules)* Split GitHub functionality in its own module
- *(dependabot)* Add dependabot functionality
- *(pre-commit)* Add conventional commit linter and docstring linter

### 🐛 Bug Fixes

- *(semantic-release)* Add git-cliff CHANGELOG generation
- *(modules)* Remove non-functional gitlab module

### 📚 Documentation

- Add mkdocs documentation
- Update documentation structure

### ⚙️ Miscellaneous Tasks

- Updated configuration
- Update pre-commit configuration
- Minor docfixes

## [0.4.3] - 2024-07-16

### ⚙️ Miscellaneous Tasks

- Fix DLT module pipeline

## [0.4.2] - 2024-07-16

### 🐛 Bug Fixes

- Relax dependency issues
- Fix Dependabot issue

### ⚙️ Miscellaneous Tasks

- Fix typo in CI pipeline

## [0.4.1] - 2024-07-15

### 🐛 Bug Fixes

- Functionalize the CI pipeline

### 📚 Documentation

- Fix asset references in docs

### ⚙️ Miscellaneous Tasks

- Fix typo
- Fix typo in CI pipeline
- Bump the version

## [0.4.0] - 2024-07-14

### 🐛 Bug Fixes

- Added python vs. pyenv case to makefile configuration
- Add `install` target to makefile to facilitate setup
- Update the .PHONY in the makefile template
- Add .vscode settings
- Mypy configuration issue + got rid of buggy pylint integration
- Update Makefile config
- Add .vscode to template
- Update make clean target

### 📚 Documentation

- Update readme
- Add comprehensive documentation

### ⚙️ Miscellaneous Tasks

- Update Python version to $(PYTHON_VERSION) in Azure DevOps CI pipeline
- Update makefile settings
- Remove pylint from default dependencies
- Use .py rather than .ipynb for notebooks
- Add docs to readme
- Bump the version

## [0.3.2] - 2024-06-14

### 🐛 Bug Fixes

- Update problematic MyPy and Ruff configuration

### 📚 Documentation

- Update release version in docs

### ⚙️ Miscellaneous Tasks

- Remove unused module creation command
- Update RevoData Asset Bundle Template version to 0.3.1

## [0.3.1] - 2024-06-14

### 🐛 Bug Fixes

- Update pool references in job template and variables
- Debug DLT and basic workflow functionality
- Update library reference
- Update VSCode settings module
- Remove pool configuration for DLT
- Debug jobs, boththe DLT and the default job
- Update deploy-dab pipeline

### 📚 Documentation

- Update documentation with images

### ⚙️ Miscellaneous Tasks

- Format the pre-commit hook
- Rewrite the success messages for various modules
- Update success message for DLT ingestion pipeline

## [0.3.0] - 2024-06-05

### 🚀 Features

- Restructure repo to include multiple templates
- Add metadata-driven DLT ingestion template
- Add issue templates
- Add Gitlab and Azure DevOps modules
- Add VSCode settings module
- Manually bumped the version to 0.3.0

### 🐛 Bug Fixes

- Label the templates with a separate databricks_template_schema.json file
- Reset the base template functionality, introduce a modules folder
- Add RevoData module functionality to Makefile
- Add profile name to module deployment
- Group poetry dependencies
- Update the README
- Update PyLint configuration in pyproject.toml
- Restructure the modules
- Debug the makefile for module use
- Debug module functionality, and add interactive makefile behavior
- Add VSCode module functionality to makefile

### ⚙️ Miscellaneous Tasks

- Update branch reference in makefile
- Add Pull Request template for Azure DevOps module
- Update CI pipeline trigger requirements
- Update default dependencies to match Databricks Runtime 14.3 LTS
- Update success message for module deployment
- Update pull request template
- Add coverage report generation in ci pipeline
- Disable unused ignore warnings in pyproject.toml
- Add coverage in CI pipeline and readme
- Update pre-commit hook

## [0.2.0] - 2024-05-13

### 🚀 Features

- Add Python Semantic Release functionality to the template
- Add GitHub Action to enforce Semantic Pull Requests
- Integrate separate GitHub Actions in overarching CI pipeline
- Add profile_name to DAB configuration

### 📚 Documentation

- Restructure README

### ⚙️ Miscellaneous Tasks

- Add template version number to README
- Fix typo in DAB configuration
- Update pre-commit configuration
- Fix typo in README
