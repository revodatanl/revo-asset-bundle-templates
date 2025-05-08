# Use the prebuilt image as the base
FROM ghcr.io/revodatanl/databricksruntime-development-container:latest

# Set environment variables
ENV PATH="/databricks/python3/bin:$PATH" \
    EDITOR=nano \
    UV_PROJECT_ENVIRONMENT="/databricks/python3" \
    UV_SYSTEM_PYTHON=true

# Set the working directory
WORKDIR /workspace/

# Copy entrypoint script
COPY .devcontainer/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Validate SSH and Databricks configuration
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]
