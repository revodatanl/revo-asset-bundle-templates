# Getting Started

## Prerequisites

This project heavily depends on the provided `Makefile` for various tasks. Without [`make`](https://www.gnu.org/software/make) installed, you will need to run the commands described in the `Makefile` manually.

### Prerequisites on Windows

The project is natively built for **Linux** or **macOS**. For **Windows** we suggest developing in a **[DevContainer](devcontainer.md) (recommended)** or setting up a **[Windows Subsystem for Linux (WSL)](wsl.md)** environment.

## Quick Setup

Run the following command to set up a fully configured development environment:

```bash
make (setup)
```

This single command installs:

- [`Git`](https://git-scm.com)
- [`uv`](https://github.com/astral-sh/uv)
- [`Databricks CLI`](https://docs.databricks.com/dev-tools/cli/databricks-cli.html)

Subsequently it sets up the development environment by:

- Creating a virtual environment in the `.venv` with the Python version specified in the `.python-version` file
- Initializing a `git` repository if not already present
- Installing, updating and running the `pre-commit` hooks

![make-setup](images/make-setup.png)
