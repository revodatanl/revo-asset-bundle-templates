# Getting Started

## Prerequisites

This project heavily depends on the provided `Makefile` for various tasks. Without [`make`](https://www.gnu.org/software/make) installed, you will need to run the commands described in the `Makefile` manually.

Note that on **Windows** most commands need to be adjusted to function properly. See [this](#installation-on-a-windows-machine) section for more information.

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

## Installation on a Windows Machine

On a **Windows** machine most commands need to be adjusted (manually) to function properly.

Install [`pyenv`](https://github.com/pyenv/pyenv) by running:

```bash
pip install pyenv-win --target $HOME\\.pyenv
```

Unfortunately, this does not always work as expected. You then need to add the path to the `pyenv-win` executable to your `PATH` environment variable manually. If that is not an option the python version needs to be handled in a different way.

Install [`Poetry`](https://python-poetry.org/docs) by running:

```bash
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```

Run poetry commands by calling `python -m poetry` rather than `poetry` directly. For instance, to create a virtual environment and install all dependencies run:

```bash
python -m poetry install
```

Activate the virtual environment by running:

```bash
. .\.venv\Scripts\activate
```

Install the pre-commit hook by running:

```bash
pre-commit install
```
