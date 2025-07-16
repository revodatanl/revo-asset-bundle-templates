"""Pytest configuration file for PySpark testing."""

from collections.abc import Generator

import pytest
from databricks.connect import DatabricksSession
from pyspark.sql import SparkSession


@pytest.fixture(scope="session")
def spark() -> Generator[SparkSession, None, None]:
    """Fixture for a serverless DatabricksSession instance for testing."""
    spark_serverless_session = DatabricksSession.builder.serverless(True).getOrCreate()
    yield spark_serverless_session
    spark_serverless_session.stop()
