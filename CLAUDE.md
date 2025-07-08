# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **RevoData Asset Bundle Templates** - a template repository for generating Databricks Asset Bundle (DAB) projects. It uses Go template syntax to create complete Databricks projects with modern Python tooling, CI/CD pipelines, and development environments.

## Architecture

### Template System

- Templates use Go template syntax with conditional logic based on user parameters
- Core configuration in `databricks_template_schema.json` defines 8 key parameters:
  - `project_name`
  - `package_name`
  - `author`
  - `email`
  - `project_description`
  - `cicd_provider` (GitHub/Azure DevOps)
  - `cloud_provider` (Azure/AWS)
  - `include_example_jobs`
  - `use_devcontainer`
  - `use_databricks_connect`

### Generated Project Structure

Each generated project includes:

- `databricks.yml.tmpl` - Bundle configuration
- `pyproject.toml.tmpl` - Python project with uv package manager
- `bundle/targets.yml.tmpl` - Deployment targets (dev, test, prod)
- `Makefile.tmpl` - Development automation
- Complete CI/CD pipelines for chosen provider

## Development Commands

The template repository itself doesn't have traditional development commands, but to test template generation:

- **Feature Testing**: `databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates --branch <branch_name>` to test specific feature branch
- **CI Testing**: The `ci-dabs.yml` workflow comprehensively tests all template configurations

## Generated Project Commands

Projects created from this template include a comprehensive Makefile with:

### Setup & Environment

- `make setup` - Complete project initialization
- `make clean` - Clean and rebuild project
- `make install` - Install system dependencies

### Quality & Testing

- `make test` - Run tests with coverage
- `make lint` - Run all linters (Ruff, MyPy, pydoclint, Bandit)

### Databricks Operations

- `make validate` - Validate Databricks bundle
- `make deploy` - Deploy to Databricks (dev target default)
- `make destroy` - Destroy deployed resources

### Documentation

- `make docs` - Serve MkDocs documentation
- `make tree` - Generate project structure

## Tooling Stack

Generated projects use modern Python tooling:

- **uv** for fast package management
- **ruff** for linting and formatting
- **mypy** for type checking
- **pre-commit** hooks for automated quality checks
- **pytest** with coverage reporting
- **mkdocs-material** for documentation

## CI/CD Architecture

### Template Repository

- `ci-dabs.yml` - Tests template generation across configurations
- `semantic-release.yml` - Automated versioning and releases
- `claude.yml` - Claude Code integration using `anthropics/claude-code-action@beta`

### Generated Projects

Generated projects contain the following CI/CD pipelines (parity with both GitHub and Azure DevOps):

- `deploy-dab.yml` - Databricks Asset Bundle deployments to test/prod
- `ci.yml` - CI pipeline to ensure code quality and security
- `semantic-release.yml` - Automated versioning and releases

## Key Files to Understand

- `databricks_template_schema.json` - Template configuration schema
- `template/__preamble.tmpl` - Template initialization logic
- `template/{{.project_name}}/databricks.yml.tmpl` - Bundle configuration
- `template/{{.project_name}}/bundle/targets.yml.tmpl` - Deployment targets
- `template/{{.project_name}}/Makefile.tmpl` - Development automation
