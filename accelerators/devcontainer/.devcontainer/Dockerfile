# Use the prebuilt image as the base
FROM ghcr.io/revodatanl/revo-devcontainer-databricks:latest

# Set environment variables
ENV EDITOR=nano \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    SHELL=/bin/zsh \
    UV_CACHE_DIR=/uv-cache \
    UV_LINK_MODE=copy

# Install just (the project's build-automation tool)
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

# Set the working directory
WORKDIR /workspace/

# Copy entrypoint script
COPY .devcontainer/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Validate SSH and Databricks configuration
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]
