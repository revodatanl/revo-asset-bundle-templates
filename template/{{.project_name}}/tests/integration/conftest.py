"""Pytest configuration file for PySpark testing."""

from collections.abc import Generator

import pytest
from pyspark.sql import SparkSession


@pytest.fixture(scope="session")
def spark() -> Generator[SparkSession, None, None]:
    """Fixture for a SparkSession instance for testing."""
    spark_session = SparkSession.builder.master("local[*]").appName("test").getOrCreate()
    yield spark_session
    spark_session.stop()
