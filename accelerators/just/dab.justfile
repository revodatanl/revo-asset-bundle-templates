# Validate Databricks bundle configuration and resources
[group('dab')]
@validate target='dev':
  just _prepare
  just _configure_dbx_profile
  just _banner "Validating resources..."
  databricks bundle validate --profile {{PROFILE_NAME}} --target {{target}}
alias validation := validate

# Deploy Databricks bundle to development environment
[group('dab')]
@deploy target='dev':
  just _prepare
  just _configure_dbx_profile
  just _banner "Deploying resources..."
  databricks bundle deploy --profile {{PROFILE_NAME}} --target {{target}}
alias deployment := deploy
