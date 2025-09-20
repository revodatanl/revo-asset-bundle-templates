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

### Generated Project Structure

Each generated project includes:

- `databricks.yml.tmpl` - Bundle configuration
- `pyproject.toml.tmpl` - Python project with uv package manager
- `bundle/targets.yml.tmpl` - Deployment targets (dev, test, prod)
- `Makefile.tmpl` - Development automation
- Complete CI/CD pipelines for chosen provider

### Modules System

The template now includes a modular system for optional components:

- **Core Template**: Minimal, streamlined template with essential tools only
- **Modules**: Optional components that can be added based on project needs
  - `modules/sqlfluff/` - SQL linting and formatting with SQLFluff
  - `modules/mkdocs/` - MkDocs documentation system
  - `modules/devcontainer/` - DevContainer configuration for containerized development
- **Module Installation**: Interactive `modules/Makefile` for easy module deployment
- **Benefits**: Smaller core template, customizable based on project requirements

## Development Commands

### Template Repository Commands

The template repository itself doesn't have traditional development commands, but to test template generation:

- **Feature Testing**: `databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates --branch <branch_name>` to test specific feature branch
- **CI Testing**: The `ci-dabs.yml` workflow comprehensively tests all template configurations

### Module System Commands

For managing optional modules in generated projects:

- `make module` - Interactive module deployment (from `modules/Makefile`)
- `make repo` - Create GitHub repository and add remote (from `modules/Makefile`)

## Generated Project Commands

Projects created from this template include a comprehensive Makefile with:

### Setup & Environment

- `make setup` - Complete project initialization
- `make clean` - Clean and rebuild project
- `make install` - Install system dependencies

### Quality & Testing

- `make test` - Run tests with coverage
- `make lint` - Run all linters (Ruff, MyPy, pydoclint)

### Databricks Operations

- `make validate` - Validate Databricks bundle
- `make deploy` - Deploy to Databricks (dev target default)
- `make destroy` - Destroy deployed resources

### Documentation

- Static documentation in `docs/` folder
- `make tree` - Generate project structure

## Tooling Stack

Generated projects use modern Python tooling:

- **uv** for fast package management
- **ruff** for linting and formatting
- **mypy** for type checking
- **pre-commit** hooks for automated quality checks
- **pytest** with coverage reporting
- **static markdown** for documentation

## CI/CD Architecture

### Template Repository Workflows

- `.github/workflows/ci-dabs.yml` - Tests template generation across all configurations
- `.github/workflows/semantic-release.yml` - Automated versioning and releases
- `.github/workflows/claude.yml` - Claude Code integration using `anthropics/claude-code-action@beta`

### Generated Project Workflows

Generated projects contain CI/CD pipelines with parity between GitHub Actions and Azure DevOps:

#### GitHub Actions (when `cicd_provider: github`)
- `.github/workflows/cd.yml` - Databricks Asset Bundle deployments to test/prod
- `.github/workflows/ci.yml` - Quality checks, security scanning, and validation
- `.github/workflows/semantic-release.yml` - Automated versioning and releases

#### Azure DevOps (when `cicd_provider: azure`)
- `.azuredevops/cd.yml` - Databricks Asset Bundle deployments to test/prod
- `.azuredevops/ci.yml` - Quality checks, security scanning, and validation
- `.azuredevops/semantic-release.yml` - Automated versioning and releases

## Key Files to Understand

### Template Configuration
- `databricks_template_schema.json` - Defines 9 template parameters and validation rules
- `template/__preamble.tmpl` - Controls conditional file inclusion based on user parameters

### Core Template Structure
- `template/{{.project_name}}/databricks.yml.tmpl` - Databricks Asset Bundle configuration
- `template/{{.project_name}}/bundle/targets.yml.tmpl` - Environment deployment targets (dev/test/prod)
- `template/{{.project_name}}/Makefile.tmpl` - Comprehensive development automation
- `template/{{.project_name}}/pyproject.toml.tmpl` - Python project configuration with uv

### Module System
- `modules/Makefile` - Interactive module deployment system
- `modules/sqlfluff/` - SQL linting and formatting module
- `modules/mkdocs/` - Documentation generation module
- `modules/devcontainer/` - DevContainer configuration and build target module

### Template Logic Patterns
Templates use Go template syntax with conditional logic:
- `{{if eq .cicd_provider "github"}}` - Include GitHub-specific files
- `{{if eq .include_example_jobs "yes"}}` - Include example jobs and notebooks
- `{{.project_name}}` and `{{template "package_name" .}}` - Parameter substitution
