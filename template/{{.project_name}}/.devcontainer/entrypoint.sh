#!/bin/bash

# Exit immediately if any command within the script returns an error
set -e

# Output to stderr for better visibility in VS Code
echo "Validating required configuration..." >&2

# Check if the SSH directory exists and is not empty
if [ ! -d "/root/.ssh" ] || [ -z "$(ls -A /root/.ssh 2>/dev/null)" ]; then
  echo "❌ ERROR: /root/.ssh is either missing or empty. SSH keys are required for this devcontainer." >&2
  echo "   Please ensure your ~/.ssh directory exists locally with required keys." >&2
  exit 1
else
  echo "✅ SSH: /root/.ssh directory exists and contains files." >&2
  # Set appropriate security permissions for the mounted SSH keys
  chmod 600 ~/.ssh/id_rsa 2>/dev/null || echo "   Note: id_rsa not found, skipping permissions setting" >&2
fi

# Check if the Databricks config exists as a regular file
if [ ! -f "/root/.databrickscfg" ]; then
  if [ -d "/root/.databrickscfg" ]; then
    echo "❌ ERROR: /root/.databrickscfg is a directory but a file was expected." >&2
    echo "   This can happen if Docker created a directory instead of mounting a file." >&2
    echo "   Please ensure you have a valid ~/.databrickscfg file locally." >&2
    exit 1
  else
    echo "❌ ERROR: /root/.databrickscfg is missing." >&2
    echo "   Please ensure you have a valid ~/.databrickscfg file locally." >&2
    exit 1
  fi
else
  echo "✅ Databricks: /root/.databrickscfg file exists." >&2
fi

echo "✅ All required configuration is available!" >&2

# Keep the container running by executing the command passed to docker run
exec "$@"
