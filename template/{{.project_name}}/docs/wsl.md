# Setting up a Development Environment with WSL

This document explains how to set up a consistent development environment for Databricks Asset Bundles using Windows Subsystem for Linux (WSL).

### Why Not Native Windows?

Setting up managed versions of `Python` and other development tools on native Windows can be complicated. In addition, on Windows there is limited access to tools that make your life easy such as `Make`. **WSL (Ubuntu)** provides a Linux-like environment that works well with `Python`, `uv`, `Make`, and other CLI tools, and is consistent with Databricks.

## Prerequisites

You need these tools installed on your system:

- [VS Code](https://code.visualstudio.com/)
- [VS Code WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

## Quick Start

1. **Install WSL**

   Open PowerShell as Administrator and run:

   ```powershell
   wsl --install
   ```

   Reboot if prompted. After reboot, open a new terminal and choose an Ubuntu terminal.

   > **Note**: If you forgot your Ubuntu password, reset it by opening PowerShell as Administrator and running:
   >
   > ```powershell
   > wsl --user root
   > passwd <username>
   > ```

2. **Install Required Tools in WSL**

   Run the following commands in the Ubuntu shell:

   ```bash
   # Install Make and unzip
   sudo apt update && sudo apt install make unzip

   # Install Databricks CLI
   sudo curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sudo sh

   # Install uv
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

3. **Configure Git**

   To configure Git with your correct name and email run:

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

   Replace accordingly. Validate settings by running:

   ```bash
   git config --list
   ```

4. **Initialize a New Project from Template**

   Create a new project using the Databricks Asset Bundle template:

   ```bash
   mkdir ~/code
   cd ~/code
   databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates
   ```

   Follow the prompts to configure your project. This will create a new project directory with all necessary files.

   Change to your newly created project directory:

   ```bash
   cd <your-project-name>
   ```

   Note that this folder resides on the Ubuntu WSL file system, not in the Windows file system.

5. **Launch VS Code in WSL**

   From your project folder in the Ubuntu shell, run:

   ```bash
   code .
   ```

   Alternatively, open VS Code, click the blue button in the bottom left corner, and choose "Connect to WSL".

   Validate by checking that the bottom left corner of VS Code says "WSL: Ubuntu".

6. **Configure Your Project**

   From within VS Code running in WSL, open a terminal and run:

   ```bash
   make (setup)
   ```

   This will set up a fully configured development environment.

## Using the Development Environment

Once your environment is configured and running, you can:

- Run Python code within the WSL environment
- Use `Make` commands to manage your project
- Run `PySpark` tests on `Databricks Connect` using the `make test` command
- Use Git for version control
- Deploy to Databricks using `make deploy`

## Troubleshooting

If you encounter issues:

1. Make sure WSL is properly installed and running
2. Verify that VS Code is running in the WSL environment (check the indicator in the bottom-left corner)
3. Ensure your project files are stored within the WSL environment, not in `/mnt/c/...`
4. Check that your SSH keys are properly configured
5. If your virtual environment is not activated automatically, run `. .venv/bin/activate`
