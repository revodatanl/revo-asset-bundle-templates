"""Module for default Spark tests."""

import pytest
from pyspark.sql import DataFrame, SparkSession
from pyspark.sql.types import (
    IntegerType,
    StringType,
    StructField,
    StructType,
)


@pytest.fixture(scope="session")
def create_test_df(spark: SparkSession) -> DataFrame:
    """Fixture for creating a test DataFrame with columns 'name' and 'age'."""
    schema = StructType(
        [
            StructField("name", StringType(), nullable=False),
            StructField("age", IntegerType(), nullable=False),
        ],
    )
    data = [("Alice", 25), ("Bob", 30), ("Charlie", 35)]
    return spark.createDataFrame(data, schema)


def test_create_dataframe(
    create_test_df: DataFrame,
) -> None:
    """Tests DataFrame creation with schema validation using the 'create_test_df' fixture."""
    test_df = create_test_df
    assert test_df.count() == 3, "DataFrame should have 3 rows."
    assert len(test_df.columns) == 2, "DataFrame should have 2 columns."
    assert test_df.schema["name"].dataType == StringType(), "Name column should be StringType."
    assert test_df.schema["age"].dataType == IntegerType(), "Age column should be IntegerType."


def test_filter_operation(create_test_df: DataFrame) -> None:
    """Tests DataFrame filtering operations using the 'create_test_df' fixture."""
    test_df = create_test_df
    # Filter for the row with age == 35
    result = test_df.filter(test_df.age == 35).collect()
    assert len(result) == 1, "Filter should return exactly one row."
    assert result[0]["name"] == "Charlie", "Filtered result should contain Charlie."
    assert result[0]["age"] == 35, "Charlie's age should be 35."
