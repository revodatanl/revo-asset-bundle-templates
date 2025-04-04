# Setting up a Development Environment with WSL

This document explains how to set up a consistent development environment for Databricks Asset Bundles using Windows Subsystem for Linux (WSL). This approach provides a Linux-like environment that works well with Python, poetry, pyenv, Make, and other development tools.

### Why Not Native Windows?

- Setting up managed versions of `Python`, `poetry`, and specifically `pyenv` on Windows natively can be complicated. In addition, on Windows there is no access to tools that make your life easy, such as `Make`.
- **WSL (Ubuntu)** provides a more consistent, Linux-like environment that works well with `Python`, `poetry`, `pyenv`, `Make`, and other CLI tools.

## Prerequisites

You need these tools installed on your system:

- [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install)
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
   > ```powershell
   > wsl --user root
   > passwd <username>
   > ```

2. **Install Required Tools in WSL**

   Run the following commands in the Ubuntu shell:

   ```bash
   # Install Make
   sudo apt update
   sudo apt install make

   # Install Homebrew
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

   # Add Homebrew to your path
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

   # Install build essentials and GCC
   sudo apt install build-essential
   brew install gcc

   # Install Java for Spark
   sudo apt install openjdk-21-jre-headless
   ```

3. **Authenticate your local machine**

   Set up authentication via `SSH` following this guide: [Use SSH keys to authenticate to Azure Repos](https://learn.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops).

   Open a terminal and generate keys by running:

   ```bash
   ssh-keygen -t rsa-sha2-256
   ```

   Don't bother to create a passphrase, just press `Enter` to skip it. Display the contents of the public key by running:

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

   Copy the key to your Azure DevOps account by following the instructions in the guide.

4. **Configure Git**

   To configure Git with your correct name and email run:

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

   Replace accordingly. Validate settings by running:

   ```bash
   git config --list
   ```

5. **Clone Your Repo**

   Create a dedicated folder in your WSL environment and clone your project:

   ```bash
   mkdir ~/code
   cd ~/code
   git clone <your-repository-url>
   ```

   Note that this folder resides on the Ubuntu WSL file system, not in the Windows file system.

6. **Launch VS Code in WSL**

   From your project folder in the Ubuntu shell, run:

   ```bash
   code .
   ```

   Alternatively, open VS Code, click the blue button in the bottom left corner, and choose "Connect to WSL".

   Validate by checking that the bottom left corner of VS Code says "WSL: Ubuntu".

7. **Configure Your Project**

   From within VS Code running in WSL, open a terminal and run:

   ```bash
   make install
   make setup
   ```

   This will set up the correct versions of Python, poetry, pyenv, git, and the Databricks CLI, and create your virtual environment.

## Using the Development Environment

Once your environment is configured and running, you can:

- Run Python code within the WSL environment
- Use Make commands to manage your project
- Run Spark tests locally with `make test`
- Use Git for version control
- Deploy to Databricks using `make deploy`

## Troubleshooting

If you encounter issues:

1. Make sure WSL is properly installed and running
2. Verify that VS Code is running in the WSL environment (check the indicator in the bottom-left corner)
3. Ensure your project files are stored within the WSL environment, not in `/mnt/c/...`
4. Check that your SSH keys are properly configured
5. If your virtual environment is not activated automatically, run `. .venv/bin/activate`
