.PHONY: install setup clean test validate deploy destroy tree lint update-pre-commit update-venv validate-update update

.DEFAULT_GOAL := setup

PROFILE_NAME := DEFAULT  # .databrickscfg profile name

# Complete project setup: install tools, dependencies, git, and pre-commit hooks
setup:
	@echo "Installing tools..."
	@{ \
		output=$$($(MAKE) install 2>&1); \
		exit_code=$$?; \
		if [ $$exit_code -ne 0 ]; then \
			echo "$$output"; \
			exit $$exit_code; \
		fi; \
	}
	@echo "All tools installed successfully."

	@echo "Setting up the project..."
	@uv sync

	@if [ ! -d ".git" ]; then \
		echo "Setting up git..."; \
		git init -b main > /dev/null; \
	fi

	@echo "Setting up pre-commit..."
	@uv run pre-commit install --hook-type pre-commit --hook-type commit-msg

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
test:
	@echo "Running tests..."
	@uv run pre-commit run --all-files
	@uv build > /dev/null 2>&1
	@uv sync
	@uv run pytest -v tests --cov=src --cov-report=term

# Validate Databricks bundle configuration and resources
validate:
	@echo "Validating resources..."
	@uv run pre-commit run --all-files
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle validate --profile $(PROFILE_NAME) --target dev; \

# Deploy Databricks bundle to development environment
deploy:
	@echo "Deploying resources..."
	@uv run pre-commit run --all-files
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle deploy --profile $(PROFILE_NAME) --target dev; \

# Destroy all deployed Databricks resources in development environment
destroy:
	@echo "Destroying resources..."
	@output=$$(databricks auth env --profile $(PROFILE_NAME) 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile $(PROFILE_NAME); \
	fi
	@databricks bundle destroy --profile $(PROFILE_NAME) --target dev; \

# Generate and display project directory structure
tree:
	@echo "Generating project tree..."
	@tree -I '.venv|__pycache__|archive|scratch|.databricks|.ruff_cache|.mypy_cache|.pytest_cache|.git|htmlcov|site|dist|.DS_Store|fixtures' -a

# Run code quality checks: ruff linting, mypy type checking, and pydoclint
lint:
	@echo "Linting the project..."
	@uv sync
	@uv build > /dev/null 2>&1
	@echo "Running ruff..."
	@uv run ruff check --output-format=concise .
	@echo "Running mypy..."
	@uv run mypy .
	@echo "Running pydoclint..."
	@uv run pydoclint .
	@echo "Linting completed successfully!"

# Update pre-commit hooks to latest versions
update-pre-commit:
	@echo "Updating pre-commit hooks..."
	@uv run pre-commit autoupdate

# Update virtual environment dependencies to latest compatible versions
update-venv:
	@echo "Updating virtual environment dependencies..."
	@uv sync --upgrade

# Validate synchronization between venv and pre-commit hook versions
validate-update:
	@for tool in ruff mypy pydoclint; do \
		pc_ver_full=$$(grep -A1 "$$tool" .pre-commit-config.yaml | grep rev | sed 's/.*v//' | tr -d ' ' | sed 's/://'); \
		uv_ver_full=$$(awk '/\[\[package\]\]/{p=0} /name = "'"$$tool"'"/{p=1} p && /version = /{print $$NF; exit}' uv.lock | tr -d '"'); \
		pc_ver=$$(echo $$pc_ver_full | cut -d. -f1-2); \
		uv_ver=$$(echo $$uv_ver_full | cut -d. -f1-2); \
		if [ "$$pc_ver" != "$$uv_ver" ]; then \
			echo "❌ $$tool: pre-commit=$$pc_ver_full vs uv.lock=$$uv_ver_full (major/minor mismatch)"; \
		fi; \
	done; true

# Update both pre-commit hooks and virtual environment dependencies
update: update-pre-commit update-venv validate-update
	@echo "All dependencies updated and synced"
