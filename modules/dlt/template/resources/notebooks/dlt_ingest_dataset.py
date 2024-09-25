# Databricks notebook source
# MAGIC file_path = str(spark.conf.get("bundle.sourcePath", "."))
# MAGIC %pip install --no-deps --force-reinstall {file_path}/dist/*.whl

# COMMAND ----------

# MAGIC %md
# MAGIC # Data ingestion with Delta Live Tables
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### Load libraries and functions
# MAGIC

# COMMAND ----------

import dlt
from pyspark.sql import DataFrame
from pyspark.sql import functions as F

# COMMAND ----------

# MAGIC %md
# MAGIC ### Set parameters
# MAGIC

# COMMAND ----------

table = spark.conf.get("table")
autoloader_path = spark.conf.get("autoloader_path")

# COMMAND ----------

# MAGIC %md
# MAGIC ## Ingest data with the Auto Loader
# MAGIC

# COMMAND ----------


@dlt.table(
    name=f"raw_{table}",
    # temporary=True,
    table_properties={"quality": "raw"},
    comment="Data loaded from Landing Zone",
)
def ingest() -> DataFrame:
    """Ingest raw data from the landing zone using the Auto Loader."""
    return (
        spark.readStream.format("cloudFiles")
        .option("cloudFiles.format", "parquet")
        .option("pathGlobfilter", "*.parquet")
        .load(autoloader_path)
        .withColumn("load_date", F.current_timestamp())
        .select("*", "_metadata")
    )


# COMMAND ----------

# MAGIC %md
# MAGIC ## Set [expectations](https://learn.microsoft.com/en-us/azure/databricks/delta-live-tables/expectations)
# MAGIC

# COMMAND ----------

expectations: dict[str, str] = {}

# COMMAND ----------


@dlt.table(
    name=f"bronze_{table}",
    # temporary=True,
    table_properties={"quality": "bronze"},
    comment="Data transformed from raw",
)
@dlt.expect_all_or_drop(expectations)
def set_expectations() -> DataFrame:
    """Set expectations on raw data to set bronze quality."""
    return dlt.read_stream(f"raw_{table}")


# COMMAND ----------

# MAGIC %md
# MAGIC ## Calculate SCD2
# MAGIC

# COMMAND ----------

# Set the date_column as a string
date_column = "registration_dttm"

# Set the key_columns, track_columns, and exclude_columns as a list of strings
key_columns = ["id"]
track_columns = [
    "first_name",
    "last_name",
    "email",
    "gender",
    "ip_address",
    "cc",
    "country",
    "birthdate",
    "salary",
    "title",
]
except_columns = ["comments", "_metadata"]

# COMMAND ----------

dlt.create_streaming_table(
    name=f"silver_{table}",
    comment="SCD2 implemented",
    table_properties={"quality": "silver"},
)

dlt.apply_changes(
    target=f"silver_{table}",
    source=f"bronze_{table}",
    keys=key_columns,
    sequence_by=F.col(date_column),
    except_column_list=except_columns,
    ignore_null_updates=False,
    track_history_column_list=track_columns,
    stored_as_scd_type="2",
)
