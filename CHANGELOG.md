## Unreleased

### BREAKING CHANGE

- the minimum supported Databricks CLI version is now
v0.295.0 (the release that shipped the rename). Existing generated
projects are unaffected; the rename itself is non-breaking and the DAB
acronym is unchanged.

### Feat

- rebrand to RevoData Declarative Automation Bundle Templates
- migrate type checker from mypy to ty

### Fix

- **just**: git-ignore machine-local shell settings instead of skip-worktree
- **just**: harden Windows bootstrap script (just_bash.ps1)
- **just**: correct silent failures and portability bugs in recipes
- **template**: correct cross-platform path separators and dependabot grouping
- **pre-commit**: keep the repo: local hooks, with ty instead of mypy

### Refactor

- **just**: align lint with set -e idiom, surface winget install errors
- run ty over the whole tree with consistent output format

## v0.20.0 (2026-02-09)

### Feat

- add dab recipe for plan and fix destroy recipe (#110)

## v0.19.0 (2026-01-21)

### Feat

- justfile alternative 1-1 makefile code (#107)

## v0.18.7 (2025-12-05)

### Fix

- add some sugar to the test suite

## v0.18.6 (2025-12-04)

### Fix

- **Makefile**: update pre-commit hook installation to include pre-commit type

## v0.18.5 (2025-12-04)

### Fix

- update the deployment documentation

## v0.18.4 (2025-12-03)

### Fix

- **pipelines**: define pipeline dependencies from workspace environment
- **pipelines**: migrate to spark declarative pipelines syntax

## v0.18.3 (2025-10-30)

### Fix

- minor update to welcome screen databricks_template_schema

## v0.18.2 (2025-10-28)

### Fix

- use default workspace root_path for test/prod

## v0.18.1 (2025-10-22)

### Fix

- include resources folder regardless of include_example_jobs parameter

## v0.18.0 (2025-10-22)

### Feat

- utilize the system venv for most of the pre-commit hooks and use `prek` over `pre-commit`
- update to Databricks runtime 16.4-LTS (with corresponding Python versions) in templates and configuration files
- remove gitleaks hook from pre-commit hooks
- integrate bundle content in databricks.yml

### Fix

- syntax for variable references in CI/CD pipeline configurations
- remove redundant update targets step in CI workflow
- update tmpl syntax in CI workflow
- set up core.hooksPath error handling in Makefile
- enhance CI/CD workflows with Databricks integration and improved deployment
- remove redundant uv installation from CI DABs pipeline

### Refactor

- consolidate preparation steps in Makefile
- update Makefile and CI/CD templates for accelerator terminology consistency
- rename modules to accelerators

## v0.17.2 (2025-09-29)

### Fix

- update release.config.mjs to reference correct docs filename

## v0.17.1 (2025-09-29)

### Fix

- simplify pre-commit installation in Makefile
- enforce conventional commits using Commitizen in downstream template
- improve linting target in Makefile
- enforce conventional commits using Commitizen

## v0.17.0 (2025-09-23)

### Feat

- remove tree functionality from template
- add conditional CI/CD setup and enhanced template validation
- remove package_name from the bundle initialization parameter

### Fix

- align Databricks authentication with best practices
- update template package_name replacement ensuring Windows compatability
- include missing prerequisite tools check in setup target
- update CD pipelines to trigger on tags and fix GitHub Actions environment errors
- replace DLT with Lakeflow Declarative Pipelines nomenclature

### Refactor

- rename .azuredevops to .azure

## v0.16.5 (2025-08-08)

### Fix

- update sqlfluff settings to allow `$catalog_name`.`$schema_name`.`$table_name`

## v0.16.4 (2025-08-07)

### Fix

- ruff output in Azure CI

## v0.16.3 (2025-08-07)

### Fix

- update remaining deploy-dab references to cd

## v0.16.2 (2025-08-04)

### Fix

- clean up Makefile

## v0.16.1 (2025-07-31)

### Fix

- reset profile name in Makefile
- improve robustness of make update target

## v0.16.0 (2025-07-25)

### Feat

- isolate devcontainer from core template
- synchronize pre-commit, CI, and local development environments
- update documentation in absence of MkDocs
- default to always use databricks-connect
- isolate SQLFluff from core template
- isolate bandit from core template
- remove bandit security scanning from core template

### Fix

- manually install uv and Databricks CLI in CI pipeline
- remove unnecessary .tmpl anchors
- update devcontainer tag
- update vscode settings
- update DevContainer configuration to match updated lean image

### Refactor

- made Makefile a lot simpler
- rename pipeline deploy-dab to CD
- isolate MkDocs from core template
- update vscode settings

## v0.15.3 (2025-06-10)

### Fix

- **claude**: include Claude Code GitHub Action

## v0.15.2 (2025-06-06)

### Fix

- **azure**: update conditions for manual validation and production deployment stages in DAB pipeline
- **github**: update DAB deployment configurations composite action
- **makefile**: add pre-commit autoupdate step in setup target
- **template**: add preamble directive for databricks_connect documentation
- **azure**: enhance unit test step to publish test and coverage results
- **github**: add composite action for deploying Databricks bundles
- **azure**: use vmImage in CI and deployment pipelines
- **azure**: omit redundancies from semantic release pipeline

## v0.15.1 (2025-06-02)

### Fix

- update targets configuration by adding host
- include pip dependency for databricks-connect
- decouple targets and variables from databricks.yml
- **ci-dabs**: enhance workflow with DevContainer support

## v0.15.0 (2025-05-30)

### Feat

- add Databricks Connect support and adapt testing configuration accordingly

### Fix

- remove DevContainer configuration from the CI DABs pipeline
- **ci-dabs**: update matrix configuration to include 'use_databricks_connect' keys

## v0.14.2 (2025-05-23)

### Fix

- **ci-dabs**: improve error handling for missing workflows in CI pipeline

## v0.14.1 (2025-05-22)

### Fix

- remove gitmoji hook from pre-commit configuration

## v0.14.0 (2025-05-22)

### Feat

- **gitmoji**: add this very important hook to the template

### Fix

- **configuration**: update mypy configuration and Makefile redundancies

## v0.13.0 (2025-05-13)

### Feat

- add databricks connect and dlt builtins

### Fix

- {{end}} line error in makefile

## v0.12.0 (2025-05-08)

### Feat

- **devcontainers**: include generalized devcontainers configuration

## v0.11.2 (2025-04-09)

### Fix

- **template**: do not deploy __builtins__.pyi in a python-only project
- **github-action**: add gitleaks support in CI pipeline
- **azure-pipelines**: add uv support in CI pipeline
- **template**: debug example job deployment

## v0.11.1 (2025-03-18)

### Fix

- **semantic-release**: update regex for version replacement
- **pyproject**: relaxed some linting exceptions to pyproject.toml template
- **devcontainer**: enhance entrypoint validation
- **settings**: re-add (parameterized) settings.json for VS Code

## v0.11.0 (2025-03-12)

### Feat

- **tests**: add integration (Spark) vs. unit tests
- **devcontainer**: add Databricks Runtime development environment container

### Fix

- **pyproject**: migrate pyproject.toml to Poetry 2.0 configuration
- **package-manager**: minimize uv/poetry redundancy

## v0.10.2 (2025-03-10)

### Fix

- **semantic-release**: standardize Semantic Release with the official Node.js package
- **deploy-dab**: debug deploy-dab pipeline for Azure and GitHub
- **template**: enhance Databricks Asset Bundle template configuration
- **pre-commit**: add a poetry/uv lock step to the pre-commit hook
- **semantic-release**: streamline semantic release pipeline for Azure DevOps
- update Ruff configuration to once again exclude default directories (like .venv)

## v0.10.1 (2024-11-14)

### Fix

- **uv**: make wheel jobs executable by providing a [project.scripts] section in pyproject.toml
- downgrade python_only default version to 3.12 since 3.13 was not compatible with mypy and pyenv
- **settings**: virtual environment will now succesfully be activated after opening a new terminal

## v0.10.0 (2024-11-11)

### Feat

- add LICENSE
- add a CONTRIBUTING section

### Fix

- **makefile**: simplify workflow by condensing `make install` and `make setup` into a single `make setup` command

## v0.9.4 (2024-11-11)

### Fix

- unify CHANGELOG generation location
- make pre-commit configuration more resilient to auto-formatting
- integrate sqlfluff configuration
- **poetry**: retire poetry-types

## v0.9.3 (2024-11-03)

### Fix

- python_only projects default to python version 3.13

## v0.9.2 (2024-11-02)

### Fix

- clean up poetry references in poetry template

## v0.9.1 (2024-11-01)

### Fix

- revert python version to 3.11 (rather than 3.11.0)

## v0.9.0 (2024-11-01)

### Feat

- add uv-support

## v0.8.1 (2024-11-01)

### Fix

- upgrade to Python 3.11 (corresponding to Databricks Runtime 15.4 LTS)

## v0.8.0 (2024-11-01)

### Feat

- refactor databricks_template_schema.json to enable conditional template initialization

### Fix

- add python_only option in template
- update deployable modules via Revo Modules make commands
- conditional deployment of git client files
- conditional README generation, dependent on git client

## v0.7.0 (2024-10-31)

### Feat

- **DLT**: conditionally include DLT sample pipeline in template by means of a __preamble file
- **pre-commit**: add bandit to pre-commit checks

### Fix

- **deps**: update mypy settings
- notebook folder placement in template
- **modules**: add __preamble.tmpl to replace certain features of modules
- **modules**: add databricks-dlt package to dependencies and adapt project configuration accordingly

## v0.6.1 (2024-10-07)

### Fix

- **azure-devops**: fix CHANGELOG generation always lagging 1 version behind

## v0.6.0 (2024-10-07)

### Feat

- differentiate between project_name and package_name in template

### Fix

- **DLT**: update the wheel installation (still non-functional)
- add .vscode settings
- **semantic-release**: add the version number to the documentation
- **docs**: add Poetry badge

## v0.5.3 (2024-09-26)

### Fix

- **docs**: minor fixes in the mkdocs configuration
- **coverage**: generate coverage badge with `genbadge` and `coverage`
- **semantic-release**: automatically update version in README template
- adapted pull request template for all modules
- **semantic-release**: update the Semantic Release pipeline
- **semantic-release**: versioning using the language-agnostic Semantic Release package
- **semantic-release**: remove unnecessary code for fetching and rebasing onto latest main
- **semantic-release**: fix rebase issue in semantic-release-tagging.yml

## v0.5.2 (2024-09-26)

## v0.5.1 (2024-09-26)

### Fix

- **modules**: include CI/CD template for Databricks Asset Bundle deployment with GitHub (to Azure)
- **modules**: update CI/CD pipelines for Azure DevOps and GitHub
- **semantic-release**: streamline semantic-release pipeline to prevent merge commits

## v0.5.0 (2024-09-25)

### Feat

- **pre-commit**: add conventional commit linter and docstring linter
- **dependabot**: add dependabot functionality
- **modules**: split GitHub functionality in its own module

### Fix

- **modules**: remove non-functional gitlab module
- **semantic-release**: add git-cliff CHANGELOG generation

## v0.4.3 (2024-07-16)

## v0.4.2 (2024-07-16)

### Fix

- Fix Dependabot issue
- Relax dependency issues

## v0.4.1 (2024-07-15)

### Fix

- functionalize the CI pipeline

## v0.4.0 (2024-07-14)

### Fix

- Update make clean target
- Add .vscode to template
- Update Makefile config
- Mypy configuration issue + got rid of buggy pylint integration
- Add .vscode settings
- Update the .PHONY in the makefile template
- Add `install` target to makefile to facilitate setup
- Added python vs. pyenv case to makefile configuration

## v0.3.2 (2024-06-14)

### Fix

- Update problematic MyPy and Ruff configuration

## v0.3.1 (2024-06-14)

### Fix

- Update deploy-dab pipeline
- Debug jobs, boththe DLT and the default job
- Remove pool configuration for DLT
- Update VSCode settings module
- Update library reference
- Debug DLT and basic workflow functionality
- Update pool references in job template and variables

## v0.3.0 (2024-06-05)

### Feat

- Manually bumped the version to 0.3.0
- Add VSCode settings module
- Add Gitlab and Azure DevOps modules
- Add issue templates
- Add metadata-driven DLT ingestion template
- Restructure repo to include multiple templates

### Fix

- Add VSCode module functionality to makefile
- Debug module functionality, and add interactive makefile behavior
- Debug the makefile for module use
- Restructure the modules
- Update PyLint configuration in pyproject.toml
- Update the README
- Group poetry dependencies
- Add profile name to module deployment
- Add RevoData module functionality to Makefile
- Reset the base template functionality, introduce a modules folder
- Label the templates with a separate databricks_template_schema.json file

## v0.2.0 (2024-05-13)

### Feat

- Add profile_name to DAB configuration
- Integrate separate GitHub Actions in overarching CI pipeline
- Add GitHub Action to enforce Semantic Pull Requests
- Add Python Semantic Release functionality to the template
