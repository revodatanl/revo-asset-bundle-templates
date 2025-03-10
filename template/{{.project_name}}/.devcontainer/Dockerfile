# Use the Databricks Runtime image as the base image.
FROM databricksruntime/standard:15.4-LTS

# Install system packages: git, curl, zip, and make.
RUN apt-get update && apt-get install -y \
    curl \
    git \
    make \
    nano \
    tree \
    zip

# Set the default editor to nano
ENV EDITOR=nano

# Install the Databricks CLI
RUN curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh

# Ensure the Databricks Python is used by default
ENV PATH="/databricks/python3/bin:$PATH"

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set the working directory
WORKDIR /workspace/

# Configure Poetry to use the Databricks Python interpreter
ENV POETRY_VIRTUALENVS_CREATE=false

# Copy repo files to temporary directory to install dependencies (remove afterward)
COPY . /tmp/code
RUN cd /tmp/code && make setup && rm -rf /tmp/code

# Copy entrypoint script into the container
COPY .devcontainer/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use entrypoint script to install dependencies
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
