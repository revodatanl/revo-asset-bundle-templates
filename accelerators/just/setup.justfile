# This imports GIT bash from user specific location for Windows.
import? "justfile.local"

# DEFAULT RECIPE | Complete project setup: sync dependencies, set up git, and pre-commit hooks.
[default]
[group('setup')]
@setup:
  just _banner "Just for {{osfam}} is operational"
  {{ if osfam == "Windows" { "just _win_installs" } else { "just _ux_installs" } }}
#

# Checks whether the required tools (uv, git, databricks) are installed.
[group('setup')]
@_check_tools:
  missing_tools=""; \
  for tool in uv git databricks; do \
    if ! command -v "$tool" >/dev/null 2>&1; then \
      echo "Error: Prerequisite '$tool' is not installed."; \
      missing_tools="$missing_tools $tool"; \
    else \
      echo "✅  $tool is installed."; \
    fi; \
  done; \
  if [ -n "$missing_tools" ]; then \
    echo "Missing tools:$$missing_tools"; \
    exit 1; \
  fi; \
#

# Checks whether the git hooks path is set. If so, it will fail the setup.
[group('setup')]
@_check_git_hooks:
  hooks_path="$(git config --get core.hooksPath 2>/dev/null || true)"; \
  if [ -n "$hooks_path" ]; then \
    echo "Error: Git core.hooksPath is set to '$hooks_path'."; \
    echo "Please run 'git config --unset-all core.hooksPath' (use --global if set globally) and retry."; \
    exit 1; \
  fi; \
  echo "✅  Git hooks path is not set (as desired).";
#

# Installs the required tools on Windows using PowerShell.
[windows]
[group('setup')]
@_win_installs:
  pwsh -NoProfile -ExecutionPolicy Bypass -File "./just/wininstallers/uv_databricks_git.ps1"
#

# Installs the required tools on Unix
[unix]
[group('setup')]
@_ux_installs:
  set -euo pipefail
  echo "Running required installations for Unix...";
  just _ux_install_item_url uv https://astral.sh/uv/install.sh
  just _ux_install_item git
  just _ux_install_item databricks
  just continue_setup
#

# Installs a cli tool using curl on an url.
[no-exit-message, unix]
[group('setup')]
@_ux_install_item_url cliname url:
  #!/usr/bin/env bash
  set -euo pipefail
  if command -v "{{cliname}}" >/dev/null 2>&1; then
    echo "{{cliname}} already present"
    exit 0
  fi
  echo "Installing {{cliname}}..."
  curl -LsSf "{{url}}" | sh
  # Common user-bin locations for curl installers
  export PATH="$HOME/.local/bin:$PATH"
  if ! command -v "{{cliname}}" >/dev/null 2>&1; then
    printf "\033[31m{{cliname}} install finished but {{cliname}} not found on PATH\033[0m\n"
    exit 1
  fi
#

# Installs a cli tool using brew or apt-get.
[no-exit-message, unix]
[group('setup')]
@_ux_install_item cliname:
  #!/usr/bin/env bash
  set -euo pipefail
  if ! command -v "{{cliname}}" >/dev/null 2>&1; then
    echo "Installing {{cliname}}..."
    if command -v brew >/dev/null 2>&1; then
      brew install "{{cliname}}"
      command -v git >/dev/null 2>&1 || { printf "\033[31mgit install finished but git not found on PATH\033[0m\n"; exit 0; }
    elif command -v apt-get >/dev/null 2>&1; then
      sudo apt-get update -y
      sudo apt-get install -y "{{cliname}}"
      command -v git >/dev/null 2>&1 || { printf "\033[31mgit install finished but git not found on PATH\033[0m\n"; exit 0; }
    else
      echo "apt-get and brew not found. Install '{{cliname}}' manually."
      exit 1
    fi
  else
    echo "{{cliname}} already present"
  fi
#

# Called by the setup script after the required cli tools are installed.
[group('setup')]
@continue_setup:
  just _check_tools
  if [ ! -f ".env" ]; then \
    echo "Creating .env file..."; \
    { \
      echo "DATABRICKS_CONFIG_PROFILE=default"; \
      echo "DATABRICKS_SERVERLESS_COMPUTE_ID=auto"; \
    } > .env; \
  else \
    echo "✅ .env file already exists, leaving unchanged."; \
  fi

  cd '{{justfile_directory()}}' && \
  cd .. && \
  if [ ! -d ".git" ]; then \
    echo "Setting up git..."; \
    git init -b main > /dev/null; \
  fi

  just _check_git_hooks

  if [ -f pyproject.toml ]; then \
    just _prepare_pyproject; \
  else \
    echo "No pyproject.toml available, skipping setup for python."; \
  fi

  just _banner "Setup completed successfully"

  echo "→ Run 'just --list' to see available commands."
  echo "→ If just is not available, make sure to close all terminals before reopening one."
  echo ""
#

# sync pyproject dependencies and install pre-commit hooks
[group('setup')]
@_prepare_pyproject:
  echo "Currently installed Python version is: $(python --version)";
  echo "Setting up the project..."
  uv sync

  echo "Setting up pre-commit hooks (with prek)..."
  uv run prek install --hook-type commit-msg --hook-type pre-push
  uv run prek autoupdate
#

# Configure Databricks profile
[group('setup')]
@_configure_dbx_profile:
  output="$(databricks auth env --profile {{PROFILE_NAME}} 2>&1)"; \
  if [[ "$output" == *"Error: resolve:"* ]];then \
    databricks configure --profile {{PROFILE_NAME}}; \
  fi;
#
