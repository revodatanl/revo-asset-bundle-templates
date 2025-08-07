## [0.16.4](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.16.3...v0.16.4) (2025-08-07)


### Bug Fixes

* ruff output in Azure CI ([e19eeaa](https://github.com/revodatanl/revo-asset-bundle-templates/commit/e19eeaacf2506220712cbb6994baf71778c9a2b1))

## [0.16.3](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.16.2...v0.16.3) (2025-08-07)


### Bug Fixes

* update remaining deploy-dab references to cd ([f71fbd8](https://github.com/revodatanl/revo-asset-bundle-templates/commit/f71fbd8539346752a1b4644b36b97d0d9238fe3a))

## [0.16.2](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.16.1...v0.16.2) (2025-08-04)


### Bug Fixes

* clean up Makefile ([5518f25](https://github.com/revodatanl/revo-asset-bundle-templates/commit/5518f258d37bb6e22f9cafe75ee1ad023e7ca178))

## [0.16.1](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.16.0...v0.16.1) (2025-07-31)


### Bug Fixes

* improve robustness of make update target ([bfa4d9d](https://github.com/revodatanl/revo-asset-bundle-templates/commit/bfa4d9d73a82dcedd33ad18f5638e5269ad182b0))
* reset profile name in Makefile ([aea6a7f](https://github.com/revodatanl/revo-asset-bundle-templates/commit/aea6a7f1d3d4b3e3d7d8aef0b45e97a79e567397))

# [0.16.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.15.3...v0.16.0) (2025-07-25)


### Bug Fixes

* manually install uv and Databricks CLI in CI pipeline ([b4c2c98](https://github.com/revodatanl/revo-asset-bundle-templates/commit/b4c2c9800cef4bc0ab6807af01acd0adfc027b38))
* remove unnecessary .tmpl anchors ([e782134](https://github.com/revodatanl/revo-asset-bundle-templates/commit/e78213401ca3c8694bd8b0474cbf3b7bfec9280b))
* update DevContainer configuration to match updated lean image ([4c85ecc](https://github.com/revodatanl/revo-asset-bundle-templates/commit/4c85ecc3a4f38d932ff326cf54b48049537b90c8))
* update devcontainer tag ([ce068a0](https://github.com/revodatanl/revo-asset-bundle-templates/commit/ce068a02c9bfcdb7da6e08df61ca8f576b808bf6))
* update vscode settings ([7ce376d](https://github.com/revodatanl/revo-asset-bundle-templates/commit/7ce376d8e444da8df5c354f0e04dec242358ea15))


### Features

* default to always use databricks-connect ([a5c8565](https://github.com/revodatanl/revo-asset-bundle-templates/commit/a5c85650887e6ddaf5cfbec7502d596e67f824a8))
* isolate bandit from core template ([67709d9](https://github.com/revodatanl/revo-asset-bundle-templates/commit/67709d9436b672612f967dfd1e1a598f16bae640))
* isolate devcontainer from core template ([bbf84f9](https://github.com/revodatanl/revo-asset-bundle-templates/commit/bbf84f96fc8fea4b6f1304dd4ce19b57bbdc7c5f))
* isolate SQLFluff from core template ([aef2a2d](https://github.com/revodatanl/revo-asset-bundle-templates/commit/aef2a2ddb26b32da076ff72d9b902d854ba051c1))
* remove bandit security scanning from core template ([1508e7d](https://github.com/revodatanl/revo-asset-bundle-templates/commit/1508e7d0a9d6d0d7d6b3ce804dda62bec9455f49))
* synchronize pre-commit, CI, and local development environments ([6327360](https://github.com/revodatanl/revo-asset-bundle-templates/commit/63273602e0a6f7577ef5f129c2e5001fb396775a))
* update documentation in absence of MkDocs ([c976c55](https://github.com/revodatanl/revo-asset-bundle-templates/commit/c976c550aed2536cc49e0cc6b8ac44813248221e))

## [0.15.3](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.15.2...v0.15.3) (2025-06-10)


### Bug Fixes

* **claude:** include Claude Code GitHub Action ([e46966e](https://github.com/revodatanl/revo-asset-bundle-templates/commit/e46966e56e0424470216c51a2899f7a9adfc5d1e))

## [0.15.2](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.15.1...v0.15.2) (2025-06-06)


### Bug Fixes

* **azure:** enhance unit test step to publish test and coverage results ([f0425ac](https://github.com/revodatanl/revo-asset-bundle-templates/commit/f0425ac4b7109399d8fd5d51463345198ef51220))
* **azure:** omit redundancies from semantic release pipeline ([dc0f319](https://github.com/revodatanl/revo-asset-bundle-templates/commit/dc0f319225807482d6f45bdece185b48c19e8d5c))
* **azure:** update conditions for manual validation and production deployment stages in DAB pipeline ([f5321c7](https://github.com/revodatanl/revo-asset-bundle-templates/commit/f5321c7701301858c012a2de31f7478fb0f0fb5c))
* **azure:** use vmImage in CI and deployment pipelines ([ef98b5c](https://github.com/revodatanl/revo-asset-bundle-templates/commit/ef98b5c8a91b1f760d96d0d2082e3d9904453a6e))
* **github:** add composite action for deploying Databricks bundles ([29c0346](https://github.com/revodatanl/revo-asset-bundle-templates/commit/29c03466f2791034db556f2b1fa9cd521fd5e051))
* **github:** update DAB deployment configurations composite action ([4d274ad](https://github.com/revodatanl/revo-asset-bundle-templates/commit/4d274ad576606434eda8bb0398bd7d53fcf7fa02))
* **makefile:** add pre-commit autoupdate step in setup target ([b339313](https://github.com/revodatanl/revo-asset-bundle-templates/commit/b339313282d5765f3303d23858e5f9de4f7805b5))
* **template:** add preamble directive for databricks_connect documentation ([53ce1c6](https://github.com/revodatanl/revo-asset-bundle-templates/commit/53ce1c6271c6b654b76c9aa43d0531cc19172191))

## [0.15.1](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.15.0...v0.15.1) (2025-06-02)


### Bug Fixes

* **ci-dabs:** enhance workflow with DevContainer support ([233f344](https://github.com/revodatanl/revo-asset-bundle-templates/commit/233f34406ead0c3ea03c0bf981c94f97ced5bf3a))
* decouple targets and variables from databricks.yml ([5e51792](https://github.com/revodatanl/revo-asset-bundle-templates/commit/5e5179250174d77a189149e6be0999499e19ea53))
* include pip dependency for databricks-connect ([6f467a1](https://github.com/revodatanl/revo-asset-bundle-templates/commit/6f467a1540a1f75edeb7befb6bb162c0742e23a0))
* update targets configuration by adding host ([36673be](https://github.com/revodatanl/revo-asset-bundle-templates/commit/36673be9fb062d6d5fd40e5705a823d1d5ab3ee3))

# [0.15.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.14.2...v0.15.0) (2025-05-30)


### Bug Fixes

* **ci-dabs:** update matrix configuration to include 'use_databricks_connect' keys ([41ef611](https://github.com/revodatanl/revo-asset-bundle-templates/commit/41ef611368904a6da8a5842a512ab4010a8070ed))
* remove DevContainer configuration from the CI DABs pipeline ([1287e61](https://github.com/revodatanl/revo-asset-bundle-templates/commit/1287e61b8ce138837d82d1d257eca61ae9c7ad3d))


### Features

* add Databricks Connect support and adapt testing configuration accordingly ([8ce6874](https://github.com/revodatanl/revo-asset-bundle-templates/commit/8ce687499f25eac3e4d74de1bf760e01a402ca66))

## [0.14.2](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.14.1...v0.14.2) (2025-05-23)


### Bug Fixes

* **ci-dabs:** improve error handling for missing workflows in CI pipeline ([fa911ae](https://github.com/revodatanl/revo-asset-bundle-templates/commit/fa911ae41490b029de1fbfeb861fa4cbba32052d))
* include default_task_config in example workflow ([20fd550](https://github.com/revodatanl/revo-asset-bundle-templates/commit/20fd550))
* setup proper error handling in CI pipeline templates ([727e977](https://github.com/revodatanl/revo-asset-bundle-templates/commit/727e977))
* package_name issues ([6502e82](https://github.com/revodatanl/revo-asset-bundle-templates/commit/6502e82))
* template initialization for the python_wheel_job ([83cbcea](https://github.com/revodatanl/revo-asset-bundle-templates/commit/83cbcea))

## [0.14.1](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.14.0...v0.14.1) (2025-05-22)


### Bug Fixes

* remove gitmoji hook from pre-commit configuration ([2c36db3](https://github.com/revodatanl/revo-asset-bundle-templates/commit/2c36db36abed48267d0c956577a3f6fb40924600))

# [0.14.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.13.0...v0.14.0) (2025-05-22)


### Bug Fixes

* **configuration:** update mypy configuration and Makefile redundancies ([a86237b](https://github.com/revodatanl/revo-asset-bundle-templates/commit/a86237bce931f15840bcb298bcd6f701a06095c3))
* **ci-dabs:** deploy and run example workflows ([302f1fd](https://github.com/revodatanl/revo-asset-bundle-templates/commit/302f1fd))
* **mypy:** defined mypy_path for more robustness ([4bfec8c](https://github.com/revodatanl/revo-asset-bundle-templates/commit/4bfec8c))
* **ci-dabs:** clean the pipeline of redundancies ([7b62fed](https://github.com/revodatanl/revo-asset-bundle-templates/commit/7b62fed))
* **ci:** debug GitHub CI pipeline ([c6c92c9](https://github.com/revodatanl/revo-asset-bundle-templates/commit/c6c92c9))


### Features

* **gitmoji:** add this very important hook to the template ([514f635](https://github.com/revodatanl/revo-asset-bundle-templates/commit/514f635b2b4ce71d5333cdf9195df44f8e00d130))
* **ci-dabs:** introduce a CI pipeline to test the deployability of the DABs template ([a112cdd](https://github.com/revodatanl/revo-asset-bundle-templates/commit/a112cdd))
* **modules:** integrate deploy-dab pipeline by default in template, effectively making revodata modules redundant ([1331cef](https://github.com/revodatanl/revo-asset-bundle-templates/commit/1331cef))
* **uv:** remove package_manager option from template, default to uv ([01485ca](https://github.com/revodatanl/revo-asset-bundle-templates/commit/01485ca))

# [0.13.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.12.0...v0.13.0) (2025-05-13)


### Bug Fixes

* {{end}} line error in makefile ([3b50054](https://github.com/revodatanl/revo-asset-bundle-templates/commit/3b5005492e3cf4aedc38e8ff5ed5fa51f8839280))


### Features

* add databricks connect and dlt builtins ([dd7afbf](https://github.com/revodatanl/revo-asset-bundle-templates/commit/dd7afbfd49b537388eef1a5175dfa2119a0cbe80))

# [0.12.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.11.2...v0.12.0) (2025-05-08)


### Features

* **devcontainers:** include generalized devcontainers configuration ([2e07b1e](https://github.com/revodatanl/revo-asset-bundle-templates/commit/2e07b1ee09a24888d71b3c80e6178854d522cbdd))

## [0.11.2](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.11.1...v0.11.2) (2025-04-09)


### Bug Fixes

* **azure-pipelines:** add uv support in CI pipeline ([5770b0e](https://github.com/revodatanl/revo-asset-bundle-templates/commit/5770b0e5867290fb24471156cc877dffec37ddb4))
* **github-action:** add gitleaks support in CI pipeline ([b39fd7b](https://github.com/revodatanl/revo-asset-bundle-templates/commit/b39fd7b26e6e05e96d33eda6d0ea8b6a71291997))
* **template:** debug example job deployment ([132f477](https://github.com/revodatanl/revo-asset-bundle-templates/commit/132f477f97827afab9c3eb5fdf875a4fa8b1fd3f))
* **template:** do not deploy __builtins__.pyi in a python-only project ([074263c](https://github.com/revodatanl/revo-asset-bundle-templates/commit/074263cb760f16252eb5704e3587f027539a13c8))

## [0.11.1](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.11.0...v0.11.1) (2025-03-18)


### Bug Fixes

* **devcontainer:** enhance entrypoint validation ([07d134b](https://github.com/revodatanl/revo-asset-bundle-templates/commit/07d134b1b192dacfc5ea1ef0c5c34f911156caf7))
* **pyproject:** relaxed some linting exceptions to pyproject.toml template ([979ff89](https://github.com/revodatanl/revo-asset-bundle-templates/commit/979ff8993ce88c44563599920b96e884d79f3721))
* **semantic-release:** update regex for version replacement ([8b5f1d2](https://github.com/revodatanl/revo-asset-bundle-templates/commit/8b5f1d2023cf2993406702178889aa2250d05574))
* **settings:** re-add (parameterized) settings.json for VS Code ([712844e](https://github.com/revodatanl/revo-asset-bundle-templates/commit/712844eba1921214b8f9ea5bbff8a59d6b3fd01c))

# [0.11.0](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.10.2...v0.11.0) (2025-03-12)


### Bug Fixes

* **package-manager:** minimize uv/poetry redundancy ([9725958](https://github.com/revodatanl/revo-asset-bundle-templates/commit/97259585d0ff383e6a186f0d0d1121e235516086))
* **pyproject:** migrate pyproject.toml to Poetry 2.0 configuration ([757c4ca](https://github.com/revodatanl/revo-asset-bundle-templates/commit/757c4ca465968a739a31c9cad5fedf4ef19f0a24))


### Features

* **devcontainer:** add Databricks Runtime development environment container ([27f1059](https://github.com/revodatanl/revo-asset-bundle-templates/commit/27f105958e49ebd8e7c7f3f8a1e9c5d1e8848002))
* **tests:** add integration (Spark) vs. unit tests ([b11ef6f](https://github.com/revodatanl/revo-asset-bundle-templates/commit/b11ef6f12cf384da0558d1a14066f28cd1f9570d))

## [0.10.2](https://github.com/revodatanl/revo-asset-bundle-templates/compare/v0.10.1...v0.10.2) (2025-03-10)


### Bug Fixes

* **deploy-dab:** debug deploy-dab pipeline for Azure and GitHub ([fdda4a8](https://github.com/revodatanl/revo-asset-bundle-templates/commit/fdda4a84bc33904f2d93c71fc8e3413130acfec4))
* **pre-commit:** add a poetry/uv lock step to the pre-commit hook ([25b4fef](https://github.com/revodatanl/revo-asset-bundle-templates/commit/25b4feffa72c3bba0bf07228b52eda4389189f02))
* **semantic-release:** standardize Semantic Release with the official Node.js package ([2e58efa](https://github.com/revodatanl/revo-asset-bundle-templates/commit/2e58efa3df043c33d964ca2c17d9f282b008618a))
* **semantic-release:** streamline semantic release pipeline for Azure DevOps ([466b350](https://github.com/revodatanl/revo-asset-bundle-templates/commit/466b3502bf7aebcc244b515822a4f1885e96a143))
* **template:** enhance Databricks Asset Bundle template configuration ([065b939](https://github.com/revodatanl/revo-asset-bundle-templates/commit/065b939ab8cb5510a59d47710d73159ad370ec5d))
* update Ruff configuration to once again exclude default directories (like .venv) ([4ca8d4f](https://github.com/revodatanl/revo-asset-bundle-templates/commit/4ca8d4fc2af1235fdd87ffbc684fb3c02a4b1043))

## [0.10.1] - 2024-11-14

### 🐛 Bug Fixes

- *(settings)* Virtual environment will now succesfully be activated after opening a new terminal
- Downgrade python_only default version to 3.12 since 3.13 was not compatible with mypy and pyenv
- *(uv)* Make wheel jobs executable by providing a [project.scripts] section in pyproject.toml

## [0.10.0] - 2024-11-11

### 🚀 Features

- Add a CONTRIBUTING section
- Add LICENSE

### 🐛 Bug Fixes

- *(makefile)* Simplify workflow by condensing `make install` and `make setup` into a single `make setup` command

## [0.9.4] - 2024-11-11

### 🐛 Bug Fixes

- *(poetry)* Retire poetry-types
- Integrate sqlfluff configuration
- Make pre-commit configuration more resilient to auto-formatting
- Unify CHANGELOG generation location

## [0.9.3] - 2024-11-03

### 🐛 Bug Fixes

- Python_only projects default to python version 3.13

## [0.9.2] - 2024-11-02

### 🐛 Bug Fixes

- Clean up poetry references in poetry template

## [0.9.1] - 2024-11-01

### 🐛 Bug Fixes

- Revert python version to 3.11 (rather than 3.11.0)

## [0.9.0] - 2024-11-01

### 🚀 Features

- Add uv-support

## [0.8.1] - 2024-11-01

### 🐛 Bug Fixes

- Upgrade to Python 3.11 (corresponding to Databricks Runtime 15.4 LTS)

## [0.8.0] - 2024-10-31

### 🚀 Features

- Refactor databricks_template_schema.json to enable conditional template initialization

### 🐛 Bug Fixes

- Conditional README generation, dependent on git client
- Conditional deployment of git client files
- Update deployable modules via Revo Modules make commands
- Add python_only option in template

## [0.7.0] - 2024-10-31

### 🚀 Features

- *(pre-commit)* Add bandit to pre-commit checks
- *(DLT)* Conditionally include DLT sample pipeline in template by means of a __preamble file

### 🐛 Bug Fixes

- *(modules)* Add databricks-dlt package to dependencies and adapt project configuration accordingly
- *(modules)* Add __preamble.tmpl to replace certain features of modules
- Notebook folder placement in template
- *(deps)* Update mypy settings

## [0.6.1] - 2024-10-07

### 🐛 Bug Fixes

- *(azure-devops)* Fix CHANGELOG generation always lagging 1 version behind

## [0.6.0] - 2024-10-07

### 🚀 Features

- Differentiate between project_name and package_name in template

### 🐛 Bug Fixes

- *(docs)* Add Poetry badge
- *(semantic-release)* Add the version number to the documentation
- Add .vscode settings
- *(DLT)* Update the wheel installation (still non-functional)

### 📚 Documentation

- Update commands page

### ⚙️ Miscellaneous Tasks

- *(docs)* Minor fixes in docs template

## [0.5.3] - 2024-09-26

### 🐛 Bug Fixes

- *(semantic-release)* Fix rebase issue in semantic-release-tagging.yml
- *(semantic-release)* Remove unnecessary code for fetching and rebasing onto latest main
- *(semantic-release)* Versioning using the language-agnostic Semantic Release package
- *(semantic-release)* Update the Semantic Release pipeline
- Adapted pull request template for all modules
- *(semantic-release)* Automatically update version in README template
- *(coverage)* Generate coverage badge with `genbadge` and `coverage`
- *(docs)* Minor fixes in the mkdocs configuration

### ◀️ Revert

- *(semantic-release)* Remove semantic PR title pipeline

## [0.5.1] - 2024-09-26

### 🐛 Bug Fixes

- *(semantic-release)* Streamline semantic-release pipeline to prevent merge commits
- *(modules)* Update CI/CD pipelines for Azure DevOps and GitHub
- *(modules)* Include CI/CD template for Databricks Asset Bundle deployment with GitHub (to Azure)

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
