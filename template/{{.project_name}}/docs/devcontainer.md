# Setting up a Development Environment with DevContainers

This document explains how to set up a consistent development environment for Databricks Asset Bundles using DevContainers. This approach works on **Windows**, **macOS**, and **Linux** with minimal setup requirements.

This approach sets up Databricks Runtime, Python environment, development tools, VS Code extensions, and configuration to match your production environment.

## Prerequisites

You need these tools installed on your system:

- [VS Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [VS Code Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Quick Start

1. **Authenticate your local machine**

   Set up authentication via `SSH` following this guide: [Use SSH keys to authenticate to Azure Repos](https://learn.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops).

   Open a **PowerShell** terminal and generate keys by running:

   ```bash
   ssh-keygen -t rsa-sha2-256
   ```

   Don't bother to create a passphrase, just press `Enter` to skip it. The keys are now stored in `~/.ssh/`. Display the contents of the public key (`~/.ssh/id_rsa.pub`) by running:

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

   Copy the key to your **Azure DevOps** account by following the instructions in the guide.

2. **Configure Git**

   To configure Git with your correct name and email run:

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

   Replace accordingly. Validate settings by running:

   ```bash
   git config --list
   ```

3. **Clone Repo**

   Create a dedicated folder in your root folder and clone your projects there. There are multiple ways to do this, using the UI or the terminal. To use the terminal, to create a `code` folder and enter it, run:

   ```bash
   mkdir ~/code
   cd ~/code
   ```

   Clone your project by running:

   ```bash
   git clone <your-repository-url>
   ```

   There might be a question about the authenticity of the RSA key fingerprint you have just created; just type `yes` to continue.

4. **Windows Users: Configuration Adjustment**

   If you're using Windows, you'll need to manually modify the `.devcontainer/docker-compose.yml` file to ensure proper configuration of SSH and Databricks settings:

   a. Open `.devcontainer/docker-compose.yml`

   b. Find the following lines:

   ```yaml
   # Mount SSH keys for Databricks authentication
   - ${HOME}/.ssh:/root/.ssh:ro
   # - ${USERPROFILE}/.ssh:/root/.ssh:ro  # Windows
   # Mount the local Databricks configuration file
   - ${HOME}/.databrickscfg:/root/.databrickscfg:ro
   # - ${USERPROFILE}/.databrickscfg:/root/.databrickscfg:ro  # Windows
   ```

   c. Delete the Unix/Mac lines and uncomment the Windows lines:

   ```yaml
   # Mount SSH keys for Databricks authentication
   - ${USERPROFILE}/.ssh:/root/.ssh:ro  # Windows
   # Mount the local Databricks configuration file
   - ${USERPROFILE}/.databrickscfg:/root/.databrickscfg:ro  # Windows
   ```

5. **Configure Databricks Authentication with a Personal Access Token**

   Follow the instructions in the [official Databricks documentation](https://docs.databricks.com/aws/en/dev-tools/auth/pat#databricks-personal-access-tokens-for-workspace-users). Once you have created the Personal Access Token (PAT), you need to create a `.databrickscfg` file in your home directory and add the token to it as described [here](https://docs.databricks.com/aws/en/dev-tools/auth/pat#perform-databricks-personal-access-token-authentication).

   The `.databrickscfg` file will look like this:

   ```toml
   [DEFAULT]
   host = https://<databricks-instance>
   token = <your-personal-access-token>
   ```

   Replace `<databricks-instance>` with your Databricks workspace URL and `<your-personal-access-token>` with your actual PAT.

   Note that the profile name is `DEFAULT` in this example. If you give it any other name, you will need to update it in the `Makefile`.

6. **Build and Start the Dev Container**

   Open VS Code and navigate to the repo folder. Automatically it should pick up the `devcontainer.json` file and prompt you to build and reopen in container.

   When VS Code prompts you to "Reopen in Container" click on it, or:
   - Click the `Notifications` button in the bottom-right corner
   - Select "Reopen in Container"

   ![reopen-in-container](assets/reopen-in-container.png)

   The first time you do this, VS Code will build the container (this might take a few minutes). Note that `Docker Desktop` is supposed to be running. When the container is running, you will see it in the bottom-left corner of VS Code:

   ![opened-in-container](assets/opened-in-container.png)

## Using the Development Environment

### SSH and Databricks Authentication

The container automatically mounts:

- Your local SSH keys (from `~/.ssh`)
- Your Databricks configuration (from `~/.databrickscfg`)

**Important**: These configurations are required for the container to start properly. The `entrypoint` script will check for these configurations and exit with errors if they are missing or misconfigured:

- SSH keys must exist in `~/.ssh`
- The Databricks configuration file must exist at `~/.databrickscfg`

If the container fails to start, check the error messages which will indicate what configuration is missing.

### Validation

Once your container is configured and running, you can:

- Interact with repositories using `git` commands
- Run `make test` to run tests
- Deploy to Databricks using the `make deploy_dev` (or `make deploy_prd`) commands

### Troubleshooting

If you encounter issues:

1. Make sure Docker Desktop is running
2. Check that your SSH keys are properly configured
   - Ensure the `~/.ssh` directory (or `%USERPROFILE%\.ssh` on Windows) exists and contains your SSH keys
   - The container will explicitly check for this and exit if missing
3. Verify your Databricks configuration is present in `~/.databrickscfg` (or `%USERPROFILE%\.databrickscfg` on Windows)
   - This file must exist and be properly configured
   - The container will explicitly check for this and exit if missing
   - If the file exists but was created as a directory by Docker, you'll need to remove the directory and create a proper configuration file
4. Try rebuilding the container (without cache) if you experience dependency issues
