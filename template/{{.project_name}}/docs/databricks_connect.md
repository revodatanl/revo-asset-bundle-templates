# Working with Databricks Connect

Databricks Connect allows you to run your local code on Databricks compute directly from your development environment. This enables you to develop and test PySpark applications locally while enabling interacting with data stored on Databricks. For more details, see the [official Databricks Connect documentation](https://docs.databricks.com/en/dev-tools/databricks-connect/index.html).

To work with Databricks Connect you have several options at your disposal.

## Option 1: VS Code Databricks Extension

> **Best for integrated development experience.**

Configure the [Databricks Connect extension in VS Code](https://marketplace.visualstudio.com/items?itemName=databricks.databricks) to select clusters through the UI.

**Advantages:**

- Visual compute selection
- Integrated with VS Code
- No configuration files needed

**Disadvantages:**

- Typically runs whole notebooks at once
- Less flexible for cell-by-cell execution

## Option 2: Serverless Compute

> **Recommended for development, testing, and interactive work.**

```python
from databricks.connect import DatabricksSession

spark = DatabricksSession.builder.serverless(True).getOrCreate()

df = spark.read.table("samples.nyctaxi.trips")
df.show(10)
```

**Advantages:**

- No cluster management/configuration required
- Instant startup and auto-scaling resources
- Enable cell-by-cell execution in notebooks
- Recommended for testing (configured in `tests/conftest.py`)

## Option 3: Explicit credential configuration

> **Best for programmatic control over compute selection.**

```python
from databricks.connect import DatabricksSession
from databricks.sdk.core import Config

config = Config(
    profile="<profile_name>",
    cluster_id="<cluster_name>",
)

spark = DatabricksSession.builder.sdkConfig(config).getOrCreate()

df = spark.read.table("samples.nyctaxi.trips")
df.show(10)
```

**Advantages:**

- Full programmatic control
- Specify configs per script

## Option 4: Environment-based Configuration

> **Best for environment-wide credentials configurations.**

Create an `.env` file in your project root and enable one of the following options:

```bash
# Profile configuration for Databricks Connect

# Option A: Use an existing profile
DATABRICKS_CONFIG_PROFILE=<profile_name>

# Option B: Specify host and cluster directly
DATABRICKS_HOST=<host_name>
DATABRICKS_CLUSTER_ID=<cluster_name>

# Option C: Serverless compute
DATABRICKS_HOST=<host_name>
DATABRICKS_SERVERLESS_COMPUTE_ID=auto
```

Then use:

```python
from databricks.connect import DatabricksSession

spark = DatabricksSession.builder.getOrCreate()

df = spark.read.table("samples.nyctaxi.trips")
df.show(10)
```

**Advantages:**

- Easy to switch between different compute types
- Environment-specific configurations
- Enable cell-by-cell execution in notebooks

## Troubleshooting

Common issues and solutions:

1. **Authentication**: Ensure your `.databrickscfg` is properly configured
2. **Environment conflicts**: Check that your `.env` file doesn't conflict with system environment variables
3. **Cluster access**: Verify you have permission to access the specified cluster or serverless compute
4. **Version compatibility**: Ensure your local Databricks Connect version is compatible with your workspace
5. **Conflict with PySpark**: [Databricks Connect conflicts with PySpark](https://docs.databricks.com/aws/en/dev-tools/databricks-connect/python/troubleshooting#conflicting-pyspark-installations). Having both installed will cause errors when initializing the Spark context in Python.
