# For more information about just and how to use it, see https://just.systems/man/en/

# Prequisites:
# Installations: `just`, . Windows users also need to install `bash` (e.g. Git Bash) and add it to the PATH.

# This sets the default shell to use for all recipes.
set shell := ["bash", "-cu"]

# These import local justfiles (gitignored) if they exists. This is useful for local overrides, such as a different shell or custom recipes.
# At Revo template level, create manually when needed.
import? 'shell.justlocal'

# Setting the justfile as quiet means commands are no longer printed to the terminal, without having to mark them all as silent (`@`) individually.
set quiet := true

template_dir := "template/{{.project_name}}/"

# DEFAULT: This will setup the git hooks.
[default]
setup:
	if [ ! -d ".git" ]; then \
		echo "Setting up git..."; \
		git init -b main > /dev/null; \
	fi;
	uv tool install commitizen
	uv tool install prek;
	uv run prek install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push --overwrite;
	uv run prek autoupdate;

# Cleanup template .git folder if it exists
clean:
	echo "Cleaning up project artifacts...";
	find . \( \
		-name "__pycache__" -o \
		-name ".ipynb_checkpoints" -o \
		-name ".mypy_cache" -o \
		-name ".pytest_cache" -o \
		-name ".ruff_cache" -o \
		-name ".venv" -o \
		-name "dist" -o \
		-name "site" -o \
		-name "*.egg-info" -o \
		-name "uv.lock" -o \
		-name ".coverage" \) \
		-exec rm -rf {} + 2>/dev/null || true;
	if [ -d "{{template_dir}}/.git" ]; then \
		echo "Cleaning up template .git folder..."; \
		rm -rf "{{template_dir}}/.git"; \
	fi;

check-commit:
	uv run cz check;

# Run all precommit hooks.
prek:
	uv run prek run -a;

# List all available recipes in original justfile order.
list:
	printf "\033[33m\n";
	just --list --unsorted --alias-style right;

# Perform all operations to get your changes to the remote repository. Type should be any of [fix,feat,docs,style,refactor,perf,test,build,c]
sync type message scope="":
	set -e; \
	git fetch; \
	git pull; \
	if [ -z "{{scope}}" ]; then \
		uv run cz commit --type "{{type}}" --message "{{message}}" -a -- -s; \
	else \
		uv run cz commit --type "{{type}}" --scope "{{scope}}" --message "{{message}}" -a -- -s; \
	fi; \
	git push;

cz:
	set -e; \
	git fetch; \
	git pull; \
	uv run cz commit -a -s; \
	git push;
