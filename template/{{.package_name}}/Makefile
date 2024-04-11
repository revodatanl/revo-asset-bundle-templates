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
