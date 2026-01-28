# For more information about just and how to use it, see https://just.systems/man/en/

# Prequisites:
# Installations: `just`, . Windows users also need to install `bash` (e.g. Git Bash) and add it to the PATH.

# This sets the default shell to use for all recipes.
set shell := ["bash", "-cu"]

set dotenv-load

# These import local justfiles (gitignored) if they exists. This is useful for local overrides, such as a different shell or custom recipes.
# At Revo template level, create manually when needed.
import? 'shell.justlocal'
import? 'personal.justlocal'

# Setting the justfile as quiet means commands are no longer printed to the terminal, without having to mark them all as silent (`@`) individually.
set quiet := true

template_dir := "template/{{.project_name}}/"

# DEFAULT: This will setup the git hooks.
[default]
setup:
	just loud "Running setup...";
	echo "Installing uv tools..."
	uv tool install prek;
	just restore-hooks;
	uv run prek autoupdate;
	just loud "✅  Setup complete!";

# Echoes a message in a box.
[private]
loud msg:
	printf '─%.0s' $(seq 1 "${COLUMNS:-80}");
	printf " {{msg}}\n";
	printf '─%.0s' $(seq 1 "${COLUMNS:-80}");

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
	just restore-hooks;

# Removes the content of the .git/hooks folder and installs prek hooks.
[private]
restore-hooks:
	echo "Removing all existing hooks and installing desired ones...";
	rm -rf .git/hooks && mkdir .git/hooks;
	uv run prek install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push --overwrite;

# List all available recipes in original justfile order.
[private]
list:
	printf "\033[33m\n";
	just --list --unsorted --alias-style right;

# Validates whether the templates justfile contains valid recipes.
[group('template')]
test-justfile:
	cd "template/{{{{.project_name}}"; \
	just --list >/dev/null;
	echo "✅  Justfile is valid!";
alias just-test := test-justfile

PROFILE_NAME := env("PROFILE_NAME", "DEFAULT")

# Initializes a new Databricks Asset Bundle project using the template.
[group('template')]
test-deploy profile=PROFILE_NAME:
	-rm -rf temporary_deployment;
	mkdir -p temporary_deployment;
	echo '{ \
		"project_name": "temporary_deployment", \
		"project_description": "This project is generated using our own RevoData Asset Bundle Templates.", \
		"author": "Thomas Brouwer", \
		"email": "thomas.brouwer@revodata.nl", \
		"setup_type": "tailored", \
		"include_cicd": "yes", \
		"cicd_provider": "azure", \
		"cloud_provider": "azure", \
		"include_example_jobs": "yes", \
		"support_windows": "yes", \
		"include_dab_recipes": "yes" \
		}' > temporary_deployment/init_params.json;
	echo "Initializing a new Databricks Asset Bundle from template...";
	databricks bundle init . --config-file "temporary_deployment/init_params.json" -p {{ PROFILE_NAME }};
	cd "temporary_deployment"; \
	if [ "{{ os_family() }}" = "windows" ]; then \
		pwsh .just/just_bash.ps1; \
	else \
		just setup; \
	fi; \
	git add . ;\
	git commit -m "feat: initial commit"
	#-rm -rf temporary_deployment;
