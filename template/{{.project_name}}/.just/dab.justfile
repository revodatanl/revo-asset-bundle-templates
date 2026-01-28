# Loads the PROFILE_NAME for the Databricks CLI from your environment, or defaults to "DEFAULT" if not set.
PROFILE_NAME := env("PROFILE_NAME", "DEFAULT")

# The default target for all databricks bundle commands, defaults to "dev" if not set.
DEFAULT_TARGET := env("DEFAULT_TARGET", "dev")

# Validate Databricks bundle configuration and resources, targets development environment by default
[group('dab')]
validate target=DEFAULT_TARGET:
	uv sync;
	uv build > /dev/null 2>&1;
	echo "Validating resources...";
	databricks bundle validate --profile {{ PROFILE_NAME }} --target {{ target }};

# Provides a list of actions that would be performed against a target when the bundle would be deployed.
[group('dab')]
plan target=DEFAULT_TARGET:
	databricks bundle plan --profile {{ PROFILE_NAME }} --target {{ target }};

# Deploy the Databricks bundle, targets development environment by default
[group('dab')]
deploy target=DEFAULT_TARGET:
	uv sync;
	uv build > /dev/null 2>&1;
	echo "Deploying resources...";
	databricks bundle deploy --profile {{ PROFILE_NAME }} --target {{ target }};

# Destroy all deployed Databricks resources against target environment, targets development environment by default
[group('dab')]
[confirm('Are you certain you want to destroy all resources? (y/n)')]
destroy target=DEFAULT_TARGET:
	echo "Destroying resources...";
	databricks bundle destroy --profile {{ PROFILE_NAME }} --target {{ target }} --auto-approve;

# Provide overview of the currently deployed resources.
[group('dab')]
summary target=DEFAULT_TARGET:
	echo "Deployed resources:";
	databricks bundle summary --profile {{ PROFILE_NAME }} --target {{ target }};
alias bundle-info := summary

# Open a resource in the browser, you will be prompted to select the desired resource.
[group('dab')]
[script]
open target=DEFAULT_TARGET:
	databricks bundle open --profile {{ PROFILE_NAME }} --target {{ target }};
alias go-to-bundle := open
alias bundle-open := open
