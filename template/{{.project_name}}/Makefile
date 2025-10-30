.PHONY: _prepare setup clean test validate deploy destroy lint

.DEFAULT_GOAL := setup

PROFILE_NAME := DEFAULT

# Internal target: sync dependencies, build package, and run pre-commit hooks
_prepare:
	@uv sync
	@uv build > /dev/null 2>&1
	@uv run prek run --all-files

# Complete project setup: sync dependencies, set up git, and pre-commit hooks
setup:
	@set -e; \
	missing_tools=""; \
	for tool in uv git databricks; do \
		if ! command -v $$tool >/dev/null 2>&1; then \
			echo "❌ Error: Prerequisite '$$tool' is not installed. Please install manually."; \
			missing_tools="$$missing_tools $$tool"; \
		fi; \
	done; \
	if [ -n "$$missing_tools" ]; then \
		echo "Exiting..."; \
		exit 1; \
	fi

	@echo "Setting up the project..."
	@uv sync

	@if [ ! -d ".git" ]; then \
		echo "Setting up git..."; \
		git init -b main > /dev/null; \
	fi

	@hooks_path=$$(git config --get core.hooksPath 2>/dev/null || true); \
	if [ -n "$$hooks_path" ]; then \
		echo "❌ Error: Git core.hooksPath is set to '$$hooks_path'."; \
		echo "   Please run 'git config --unset-all core.hooksPath' (use --global if set globally) and retry."; \
		exit 1; \
	fi

	@echo "Setting up pre-commit hooks (with prek)..."
	@uv run prek install --hook-type commit-msg --hook-type pre-push
	@uv run prek autoupdate

	@echo "Setup completed successfully!"

# Clean project artifacts and rebuild virtual environment
clean:
	@echo "Uninstalling local packages..."
	@rm -rf uv.lock
	@echo "Cleaning up project artifacts..."
	@find . \( \
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
	@find . -name ".coverage" -type f -delete 2>/dev/null || true
	@echo "Rebuilding the project..."
	@uv sync
	@echo "Cleanup completed."

# Run pre-commit hooks, build package, and execute tests with coverage
test: _prepare
	@echo "Running tests..."
	@uv run pytest -v tests --cov=src --cov-report=term

# Validate Databricks bundle configuration and resources
validate: _prepare
	@echo "Validating resources..."
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle validate --profile $(PROFILE_NAME) --target dev;

# Deploy Databricks bundle to development environment
deploy: _prepare
	@echo "Deploying resources..."
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle deploy --profile $(PROFILE_NAME) --target dev;

# Destroy all deployed Databricks resources in development environment
destroy:
	@echo "Destroying resources..."
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle destroy --profile $(PROFILE_NAME) --target dev;

# Run code quality checks: ruff linting, mypy type checking, and pydoclint
lint:
	@echo "Linting the project..."
	@uv sync
	@echo "Building the project..."
	@uv build >/dev/null 2>&1
	@echo "Running ruff..."
	-@uv run ruff check --output-format=concise .
	@echo "Running mypy..."
	-@uv run mypy .
	@echo "Running pydoclint..."
	-@uv run pydoclint .
	@echo "Linting completed!"
