.PHONY: repo module module_%

.DEFAULT_GOAL := module

# Add custom RevoData modules to the project
module:
	@echo "Select the module to deploy:"
	@echo "1) Deploy Databricks Asset Bundle pipeline for GitHub"
	@echo "2) Deploy Databricks Asset Bundle pipeline for Azure DevOps"
	@echo "Enter the number of the module you want to deploy: "
	@read choice; \
	case "$$choice" in \
		1) $(MAKE) module_github-deploy-dab ;; \
		2) $(MAKE) module_azure-devops-deploy-dab ;; \
		*) echo "Invalid choice. Exiting.";; \
	esac

module_%:
	@if [ "$*" != "github-deploy-dab" ] && [ "$*" != "azure-devops-deploy-dab" ]; then \
		echo "Error: Invalid module. Use 'github-deploy-dab' or 'azure-devops-deploy-dab'."; \
		exit 1; \
	fi
	@{ \
		set -e; \
		trap 'if [ -f databricks.yml.bak ]; then mv databricks.yml.bak databricks.yml; fi' EXIT; \
		if [ -f databricks.yml ]; then mv databricks.yml databricks.yml.bak; fi; \
		if ! databricks bundle init https://github.com/revodatanl/revo-asset-bundle-templates --template-dir modules/$* 2>&1; then \
			echo "Exiting." >&2; \
		fi; \
	}

# Create a repository in RevoData's GitHub, and adds a remote to the local git repo
repo:
	@printf "Creating repository in RevoData's GitHub...\n"
	@PROJECT_NAME=$$(grep 'name =' pyproject.toml | awk -F'"' '{print $$2}')
	@REPO_DESCRIPTION=$$(grep 'description =' pyproject.toml | awk -F'"' '{print $$2}')
	@if ! gh auth status >/dev/null 2>&1; then \
		echo "Error: GitHub CLI is not authenticated. Please run 'gh auth login' first."; \
		exit 1; \
	fi
	@if ! gh repo view revodatanl/$$PROJECT_NAME > /dev/null 2>&1; then \
		gh repo create revodatanl/$$PROJECT_NAME -y --private -d "$$REPO_DESCRIPTION" > /dev/null 2>&1; \
		(git remote | grep origin || git remote add origin git@github.com:revodatanl/$$PROJECT_NAME.git) > /dev/null 2>&1; \
		printf "Repository created at revodatanl/$$PROJECT_NAME...\n"; \
		printf "Publishing project...\n"; \
		printf "Repository published.\n"; \
	else \
		printf "Repository revodatanl/$$PROJECT_NAME already exists.\n"; \
	fi

# Create an pre-configured python-only project
