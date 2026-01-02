# Internal target: sync dependencies and run pre-commit hooks
[group('ci')]
_prepare:
  @set -euo pipefail
  uv sync
  uv run prek run --all-files
#

# Run pre-commit hooks, build package, and execute tests with coverage
[group('ci')]
@test:
  just _prepare
  just _banner "Running tests..."
  uv run pytest -v tests
alias tests := test
alias check := test
alias checks := test
alias ci := test

# Only run pytest, skips linters
[group('ci')]
@unittest:
  echo "Skipping linters and running tests..."
  uv run pytest -s tests
#

# Run code quality checks: ruff linting, mypy type checking, and pydoclint
[group('ci')]
@lint:
	echo "Linting the project..."
	uv sync
	echo "Running ruff..."
	uv run ruff check --output-format=concise .
	echo "Running pyright..."
	uv run pyright .
	echo "Running pydoclint..."
	uv run pydoclint .
	just _banner "Linting completed!"
#

# Format all files using ruff
[group('ci')]
@format:
	echo "Running ruff..."
	uv run ruff format
alias format-only := format
alias formatonly := format
alias fmt := format
