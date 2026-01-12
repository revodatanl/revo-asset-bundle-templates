# For more information about just and how to use it, see https://just.systems/man/en/

set shell := ["bash", "-cu"]

set quiet

import? 'justfile.local'

PROFILE_NAME := "DEFAULT"

# verify that just is available and can use just subcommands
[group('just')]
verify_just:
	just --version
	printf "✅  Just is available with subcommands\n"

# List all available just recipes.
[group('just')]
list:
	printf "\033[33m\n";
	just --list --unsorted --alias-style right

# Internal target: sync dependencies, build package, and run pre-commit hooks
[private]
[group('pyproject')]
[group('ci')]
prepare:
	uv sync
	uv build > /dev/null 2>&1
	uv run prek run --all-files

# Verify that the required tools are installed.
[group('setup')]
verify_tools:
	printf "Verifying tools on shell [$SHELL]... \n"
	printf "running from [$(pwd)]... \n"
	missing_tools=""; \
	for tool in uv git databricks; do \
		if ! command -v "$tool" >/dev/null 2>&1; then \
			echo "❌  Error: Prerequisite '$tool' is not installed."; \
			missing_tools="$missing_tools $tool"; \
		else \
			echo "✅  $tool is installed."; \
		fi; \
	done; \
	if [ -n "$missing_tools" ]; then \
		echo "Missing tools:$missing_tools"; \
		exit 1; \
	fi;

# Checks whether the git hooks path is set. If so, it will fail the setup.
[group('setup')]
check_git_hooks:
	hooks_path="$(git config --get core.hooksPath 2>/dev/null || true)"; \
	if [ -n "$hooks_path" ]; then \
		echo "❌  Error: Git core.hooksPath is set to '$hooks_path'."; \
		echo "Please run 'git config --unset-all core.hooksPath' (use --global if set globally) and retry."; \
		exit 1; \
	fi; \
	echo "✅  Git hooks path is not set (as desired).";

# Complete project setup: sync dependencies, set up git, and pre-commit hooks
[group('setup')]
[default]
setup:
	set -e; \

	just verify_tools;

	echo "Setting up the project..."
	uv sync

	if [ ! -d ".git" ]; then \
		echo "Setting up git..."; \
		git init -b main > /dev/null; \
	fi

	just check_git_hooks;

	echo "Setting up pre-commit hooks (with prek)..."
	uv run prek install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push
	uv run prek autoupdate

	echo "✅  Setup completed successfully!"

# Clean project artifacts and rebuild virtual environment
[group('pyproject')]
clean:
	echo "Uninstalling local packages..."
	rm -rf uv.lock
	echo "Cleaning up project artifacts..."
	find . \( \
		-name "__pycache__" -o \
		-name ".ipynb_checkpoints" -o \
		-name ".mypy_cache" -o \
		-name ".pytest_cache" -o \
		-name ".ruff_cache" -o \
		-name ".venv" -o \
		-name "dist" -o \
		-name "site" -o \
		-name "*.egg-info" \) \
		-type d -exec rm -rf {} + 2>/dev/null || true
	find . -name ".coverage" -type f -delete 2>/dev/null || true
	echo "Rebuilding the project..."
	uv sync
	echo "✅  Cleanup completed."

# Run pre-commit hooks, build package, and execute tests with coverage
[group('pyproject')]
[group('ci')]
test:
	just prepare
	@echo "Running tests..."
	@uv run pytest -v tests --cov=src --cov-report=term

# Make sure the databricks profile is configured.
[group('setup')]
[group('dab')]
configure_dbx_profile:
	output="$(databricks auth env --profile {{PROFILE_NAME}} 2>&1)"; \
	if [[ "$output" == *"Error: resolve:"* ]];then \
		databricks configure --profile {{PROFILE_NAME}}; \
	fi;

# Validate Databricks bundle configuration and resources
[group('dab')]
[group('ci')]
validate:
	just prepare
	echo "Validating resources..."
	just configure_dbx_profile;
	databricks bundle validate --profile {{PROFILE_NAME}} --target dev;

# Deploy Databricks bundle to development environment
[group('dab')]
deploy:
	just prepare
	echo "Deploying resources..."
	just configure_dbx_profile;
	databricks bundle deploy --profile {{PROFILE_NAME}} --target dev;

# Destroy all deployed Databricks resources in development environment
[group('dab')]
destroy:
	echo "Destroying resources..."
	just configure_dbx_profile;
	databricks bundle destroy --profile {{PROFILE_NAME}} --target dev;

# Run code quality checks: ruff linting, mypy type checking, and pydoclint
[group('ci')]
[group('pyproject')]
lint:
	echo "Linting the project..."
	uv sync
	echo "Building the project..."
	uv build >/dev/null 2>&1
	echo "Running ruff..."
	-uv run ruff check --output-format=concise .
	echo "Running mypy..."
	-uv run mypy .
	echo "Running pydoclint..."
	-uv run pydoclint .
	echo "✅  Linting completed!"
