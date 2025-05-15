# Getting Started

## Prerequisites

This project heavily depends on the provided `Makefile` for various tasks. Without [`make`](https://www.gnu.org/software/make) installed, you will need to run the commands described in the `Makefile` manually. Note that on **Windows** we recommend using the DevContainer approach instead of trying to set up the environment manually. See [DevContainer Instructions](devcontainer.md) for more information.

## Installation

With [make](https://www.gnu.org/software/make) installed, run the following command to set up a fully configured development environment:

```bash
make setup
```

This installs:

- [`Homebrew`](https://brew.sh)
- [`Git`](https://git-scm.com)
- [`uv`](https://github.com/astral-sh/uv)
- [`Databricks CLI`](https://docs.databricks.com/dev-tools/cli/databricks-cli.html)

Subsequently it sets up the development environment by:

- Creating a virtual environment in the `.venv` with the Python version specified in the `.python-version` file
- Initializing a `git` repository if not already present
- Installing, updating and running the `pre-commit` hooks

![make-setup](images/make-install.png)

## Cleaning Up

To deactivate and remove the virtual environment, remove the `uv.lock` file, and removes any caches, run the following command:

```bash
make clean
```

![make-clean](images/make-clean.png)

## Installation on Windows

For Windows users, we strongly recommend using the DevContainer approach instead of manual setup. The DevContainer provides a consistent development environment that works across operating systems with minimal setup requirements.

Please refer to the [DevContainer Instructions](devcontainer.md) for detailed setup steps. Alternatively, if you prefer using Windows Subsystem for Linux (WSL), we also provide detailed [WSL Setup Instructions](wsl.md).
