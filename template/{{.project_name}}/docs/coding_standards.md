# Coding Standards

## Style Guide

- Follow `PEP 8` for Python code style.
- Use type hints for function signatures.
- Preferably use functions over classes, unless you have a good reason to use classes (e.g. test classes).
- Write docstrings for all functions and classes, following the `numpy` style.
- Make sure that your functions have clear inputs and outputs, are testable, and are are well-documented.
- Use `.py` files rather than `ipynb` files for notebooks (easier to review).
- Consistency within a module/pipeline is most important.

## Code Quality

Ensure that the [`pre-commit`](https://pre-commit.com) hook defined in `.pre-commit-config.yaml` passes successfully:

- [`conventional-pre-commit`](https://github.com/compilerla/conventional-pre-commit) to enforce conventional commit standards.
- [`Ruff`](https://docs.astral.sh/ruff/) for linting and formatting.
- [`mypy`](https://mypy.readthedocs.io/en/stable/) for static type checking (in `strict` mode)
- [`pydoclint`](https://github.com/shmsi/pydoclint) to lint docstrings.
- [`pytest`](https://docs.pytest.org/en/stable/) for testing.
- [`pytest-cov`](https://pytest-cov.readthedocs.io/en/latest/) for test coverage: aim for at least 80% test coverage.

## Data Processing

- When interacting with a Delta table, use `spark.sql.DataFrame` in subsequent transformations.
- For small datasets, use the `coalesce(1)` method to process on a single node.
- For large datasets, use the default method to process the data (i.e. let Spark handle the partitioning).
