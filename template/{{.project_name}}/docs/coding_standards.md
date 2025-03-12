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

## Commit Conventions

We follow the [Angular Commit Message Conventions](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format) for structured, semantic commit messages. This standard ensures consistent commit history and enables automated versioning and changelog generation.

### Commit Message Format

Each commit message consists of a **header**, an optional **body**, and an optional **footer**. The header has a special format that includes a **type**, an optional **scope**, and a **subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

#### Type

The type must be one of the following:

| Type       | Description | Version Impact |
|------------|-------------|----------------|
| `feat`     | A new feature | Minor (`1.0.0` → `1.1.0`) |
| `fix`      | A bug fix | Patch (`1.0.0` → `1.0.1`) |
| `docs`     | Documentation only changes | None |
| `style`    | Changes that do not affect the meaning of the code (white-space, formatting, etc.) | None |
| `refactor` | A code change that neither fixes a bug nor adds a feature | None |
| `perf`     | A code change that improves performance | None |
| `test`     | Adding missing tests or correcting existing tests | None |
| `build`    | Changes that affect the build system or external dependencies | None |
| `ci`       | Changes to our CI configuration files and scripts | None |
| `chore`    | Other changes that don't modify src or test files | None |
| `revert`   | Reverts a previous commit | Depends on the reverted commit |

#### Scope

The scope is optional and should specify the place of the commit change (e.g., component or file name).

#### Subject

The subject contains a succinct description of the change:
- Use the imperative, present tense: "change" not "changed" or "changes"
- Don't capitalize the first letter
- No period (.) at the end

#### Breaking Changes

Breaking changes should be indicated by:
1. Adding an exclamation mark after the type/scope: `feat!: introduce breaking change`
2. Adding a `BREAKING CHANGE:` footer with description: `BREAKING CHANGE: environment variables now take precedence over config files`

Breaking changes trigger a major version update (`1.0.0` → `2.0.0`).

### Examples of Good Commit Messages

```
feat(auth): add OAuth2 authentication

Implement OAuth2 authentication flow with Google and GitHub providers.
```

```
fix(data): resolve null pointer in dataframe transformation

Fixes issue #123
```

```
refactor(api): simplify error handling middleware
```

```
docs(readme): update installation instructions
```

```
feat!: redesign public API

BREAKING CHANGE: The entire public API has been redesigned to improve usability.
```

## Data Processing

- When interacting with a Delta table, use `spark.sql.DataFrame` in subsequent transformations.
- For small datasets, use the `coalesce(1)` method to process on a single node.
- For large datasets, use the default method to process the data (i.e. let Spark handle the partitioning).
