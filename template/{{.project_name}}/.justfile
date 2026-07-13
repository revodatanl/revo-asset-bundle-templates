# For more information about just and how to use it, see https://just.systems/man/en/

# This sets the default shell to use for all recipes.
set shell := ["bash", "-cu"]

# Import shell settings which could be overwritten by the user.
import? '.just/shell_settings.justfile'

# Setting the justfile as quiet means commands are no longer printed to the terminal, without having to mark them all as silent (`@`) individually.
set quiet := true

# Makes sure settings from your local .env file are loaded.
set dotenv-load

# We have to set the temp directory to prevent OS specific fallbacks that are not always available.
set tempdir := ".just"

# Imports Databricks Asset Bundle related recipes if they are deployed.
import? '.just/dab.justfile'

# Imports VS Code related recipes if they are deployed.
import? '.just/vscode.justfile'

# Complete project setup: check tools, sync dependencies, set up git and pre-commit hooks
[default]
[script]
setup:
	set -e;
	echo "ℹ️   running on shell [$SHELL] from [$(pwd)]";
	echo "Checking for required tools...";
	missing_tools="";
	for tool in uv git databricks; do
		if ! command -v "$tool" >/dev/null 2>&1; then
			echo "   ❌  Error: Prerequisite '$tool' is not installed.";
			missing_tools="$missing_tools $tool";
		else
			echo "   ✅  $tool is installed.";
		fi;
	done;
	if [ -n "$missing_tools" ]; then
		echo "❌  Missing tools:$missing_tools";
		exit 1;
	fi;
	echo "Setting up the project...";
	uv sync;
	if [ ! -d ".git" ]; then
		echo "Setting up git...";
		git init -b main > /dev/null;
	fi;
	echo "Setting up pre-commit hooks (with prek)...";
	uv run prek install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push;
	uv run prek autoupdate;
	echo "✅  Setup completed successfully!";

# Clean project artifacts and rebuild virtual environment. Does not reset local git nor local settings.
[script]
clean:
	set -e;
	echo "Cleaning up project artifacts...";
	# NOTE: keep this prune list in sync with the root .justfile clean recipe.
	# uv.lock is intentionally NOT removed: it is a committed reproducibility artifact.
	find . \( \
		-name "__pycache__" -o \
		-name ".ipynb_checkpoints" -o \
		-name ".pytest_cache" -o \
		-name ".ruff_cache" -o \
		-name ".venv" -o \
		-name "dist" -o \
		-name "site" -o \
		-name "*.egg-info" -o \
		-name "htmlcov" -o \
		-name ".coverage" \) \
		-exec rm -rf {} + || true;
	sleep 2;
	echo "Rebuilding the project...";
	uv sync;
	echo "✅  Cleanup completed!";

# Run code quality checks: ruff linting, ty type checking, and pydoclint
[script]
lint:
	set -e;
	echo "Linting the project...";
	uv sync;
	echo "Building the project...";
	uv build >/dev/null;
	# Run all checkers, collect their results, then fail if any failed.
	# This reports every problem in one pass while still failing the recipe
	# (and any CI gate that calls `just lint`) on a real violation.
	failed=0;
	echo "Running ruff...";
	uv run ruff check --output-format=concise . || failed=1;
	echo "Running ty...";
	uv run ty check --output-format=concise . || failed=1;
	echo "Running pydoclint...";
	uv run pydoclint . || failed=1;
	if [ "$failed" -ne 0 ]; then
		echo "❌  Linting failed!";
		exit 1;
	fi;
	echo "✅  Linting completed!";

# Build the package and run the test suite with coverage (pass open-coverage=true to open the HTML report)
test open-coverage="false":
	uv sync;
	uv build >/dev/null;
	echo "Running tests...";
	uv run pytest -v tests --cov=src --cov-report=term;
	if [[ "{{open-coverage}}" == "true" ]]; then \
		uv run coverage html; \
		python -m webbrowser "file://{{ justfile_directory() }}/htmlcov/index.html"; \
	fi;
	echo "✅  Testing completed!";

# List all available just recipes in the order they appear in this file with aliasses on the same line.
[private]
list:
	printf "\033[33m\n";
	just --list --unsorted --alias-style right;
