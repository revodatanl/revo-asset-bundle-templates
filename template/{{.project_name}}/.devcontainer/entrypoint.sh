#!/bin/bash

# Exit immediately if any command within the script returns an error
set -e

# Check if the SSH directory exists and is not empty
if [ ! -d "/root/.ssh" ] || [ -z "$(ls -A /root/.ssh 2>/dev/null)" ]; then
  echo "WARNING: /root/.ssh is either missing or empty. SSH keys may not be available."
fi

# Check if the Databricks config exists as a regular file
# If Docker created an empty folder due to a bind mount, warn accordingly
if [ ! -f "/root/.databrickscfg" ]; then
  if [ -d "/root/.databrickscfg" ]; then
    echo "WARNING: /root/.databrickscfg is a directory but a file was expected. Databricks configuration may not be available."
  else
    echo "WARNING: /root/.databrickscfg is missing. Databricks configuration may not be available."
  fi
fi

# Execute the next command to keep the container running
exec "$@"
