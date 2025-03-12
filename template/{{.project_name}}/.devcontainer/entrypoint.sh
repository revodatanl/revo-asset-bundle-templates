#!/bin/bash

# Exit immediately if any command within the script returns an error
set -e

# Check if the SSH directory exists and is not empty
if [ ! -d "/root/.ssh" ] || [ -z "$(ls -A /root/.ssh 2>/dev/null)" ]; then
  echo "WARNING: /root/.ssh is either missing or empty. SSH keys may not be available."
  echo "ERROR: Required SSH configuration is missing. Exiting."
  exit 1
else
  echo "SUCCESS: /root/.ssh directory exists and contains files: SSH seems to be configured."
fi

# Check if the Databricks config exists as a regular file
# If Docker created an empty folder due to a bind mount, warn and raise error accordingly
if [ ! -f "/root/.databrickscfg" ]; then
  if [ -d "/root/.databrickscfg" ]; then
    echo "WARNING: /root/.databrickscfg is a directory but a file was expected. Databricks configuration may not be available."
    echo "ERROR: Expected /root/.databrickscfg to be a file, but found a directory instead. Exiting."
    exit 1
  else2
    echo "WARNING: /root/.databrickscfg is missing. Databricks configuration may not be available."
    echo "ERROR: Required Databricks configuration file is missing. Exiting."
    exit 1
  fi
else
  echo "SUCCESS: /root/.databrickscfg file exists. Databricks configuration is available."
fi

# Keep the container running
exec "$@"
