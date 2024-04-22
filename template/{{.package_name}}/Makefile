# ANSI escape codes
GREEN=\033[0;32m
ORANGE=\033[38;5;208m
RESET=\033[0m

setup:
	@echo "Before continuing, please ensure you have the following tools installed and configured:"
	@echo "  - python"
	@echo "  - pyenv"
	@echo "  - poetry >= 1.6.1"
	@echo ""

	@read -p "Continue? (Y/n)" -n 1 -r; echo ""; \
	if [[ ! $$REPLY =~ ^[Yy]$$ ]] && [[ -n $$REPLY ]]; then \
		echo "Exiting."; \
		exit 1; \
	fi

	@PYTHON_VERSION=$$(cat .python-version); \
	echo "Using Python version $$PYTHON_VERSION"; \
	pyenv install --skip-existing $$PYTHON_VERSION; \
	pyenv local $$PYTHON_VERSION; \
	which python; \
	python --version;

	curl -sSL https://install.python-poetry.org | python -; \
	poetry --version; \
	poetry config virtualenvs.in-project true --local; \
	poetry env use python $$PYTHON_VERSION; \
	poetry install;

	. .venv/bin/activate;
	.venv/bin/pre-commit install;

test:
	.venv/bin/pre-commit run --all-files
	poetry update
	poetry build
	poetry install --only-root
	pytest --cov=src tests/

clean:
	-@if command -v deactivate &> /dev/null; then \
		bash -c "source deactivate" || true; \
	fi
	rm -rf .venv
	rm -rf poetry.lock
	find . -name ".pytest_cache" -type d -exec rm -rf {} +
	find . -name ".mypy_cache" -type d -exec rm -rf {} +
	find . -name ".ruff_cache" -type d -exec rm -rf {} +

dev_deploy:
	.venv/bin/pre-commit run --all-files
	poetry update
	poetry build

	@PROFILE_NAME="profile_name"; \
	output=$$(databricks auth env --profile "$$PROFILE_NAME" 2>&1); \
	if [[ $$output == *"Error: resolve:"* ]]; then \
		databricks configure --profile "$$PROFILE_NAME"; \
	else \
		databricks bundle deploy --profile "$$PROFILE_NAME"; \
	fi

# This target initializes a local git repo, creates a repository in RevoData's GitHub, 
# adds a remote to the local git repo, and publishes the project.
publish:
	@printf "$(GREEN)Initializing git repository...$(RESET)\n"
	@(git init && \
	git add . && \
	(git diff --cached --exit-code || git commit -m "Initial commit")) > /dev/null;
	@printf "Local git repository set up.\n"

	@printf "$(GREEN)Creating repository in RevoData's GitHub...$(RESET)\n"
	@if ! gh repo view revodatanl/${project_name} > /dev/null 2>&1; then \
		REPO_DESCRIPTION=$$(grep 'description =' pyproject.toml | awk -F'"' '{print $$2}'); \
		gh repo create revodatanl/${project_name} -y --private -d "$$REPO_DESCRIPTION" > /dev/null 2>&1; \
		printf "Repository created at revodatanl/${project_name}...$(RESET)\n"; \
		printf "$(GREEN)Publishing project...$(RESET)\n"; \
		(git remote | grep origin || git remote add origin git@github.com:revodatanl/${project_name}.git && \
		git push -u origin main) > /dev/null 2>&1; \
		printf "Repository published.\n"; \
	else \
		printf "Repository revodatanl/${project_name} already exists.\n"; \
	fi