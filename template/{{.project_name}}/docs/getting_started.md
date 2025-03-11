# Getting Started

## Prerequisites

This project heavily depends on the provided `Makefile` for various tasks. Without [`make`](https://www.gnu.org/software/make) installed, you will need to run the commands described in the `Makefile` manually.

Note that on **Windows** we recommend using the DevContainer approach instead of trying to set up the environment manually. See [DevContainer Instructions](devcontainer.md) for more information.

## Installation

To install the prerequisites, run the following command:

```bash
make install
```

This will:

- Install [`Homebrew`](https://brew.sh) if not already installed.
- Install the required tools: [`Databricks CLI`](https://docs.databricks.com/dev-tools/cli/databricks-cli.html), [`git`](https://git-scm.com), [`Poetry`](https://python-poetry.org/docs), and [`pyenv`](https://github.com/pyenv/pyenv).
- Set up the Python version specified in the `.python-version` file using `pyenv`.
- Add pyenv configuration to `.zprofile` and `.zshrc`.

![make-install](assets/make-install.png)

## Setting Up

To set up a fully configured development environment for this project, run the following command:

```bash
make setup
```

This will:

- Configure Poetry to create a virtual environments inside the `.venv` folder in the project directory.
- Use the specified Python version to create the virtual environment.
- Install all dependencies.
- Initialize a `git` repository if not already present.
- Install the `pre-commit` hooks.

![make-setup](assets/make-setup.png)

## Cleaning Up

To deactivate and remove the virtual environment, remove the `poetry.lock` file, and removes any caches, run the following command:

```bash
make clean
```

![make-clean](assets/make-clean.png)

## Installation on Windows

For Windows users, we strongly recommend using the DevContainer approach instead of manual setup. The DevContainer provides a consistent development environment that works across operating systems with minimal setup requirements.

Please refer to the [DevContainer Instructions](devcontainer.md) for detailed setup steps.

Using DevContainers offers several advantages:

- Consistent environment across all operating systems (Windows, macOS, Linux)
- Pre-configured development tools and extensions
- No need for manual Windows-specific adjustments
- Matches the production environment more closely
