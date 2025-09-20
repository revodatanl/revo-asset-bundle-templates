# Coding Standards

## Style Guide

- Follow `PEP 8` for Python code style
- Always lint and format your code
- Always use type hints for function signatures
- Prefer functions over classes (except for _e.g._ test classes)
- Write testable code, and test using `pytest`
- Write `numpy`-style docstrings for all functions and classes
- Use `.py` files for notebooks (easier to review than `.ipynb`)
- Always `import pyspark.sql.functions as F`
- Use `UpperCamelCase` for classes, use `snake_case` for variables/functions
- Explicit names over abbreviations
- Consistency is most important

## Testing

- Tests are located in the `tests` directory
- All tests have a leading `test_` (or `_test` suffix) to the function and/or class - following the [`pytest`](https://docs.pytest.org/en/stable/) convention
- We aim for at least 80% test coverage, quantified by [`pytest-cov`](https://pytest-cov.readthedocs.io/en/latest/)

## Commit Conventions

We write our commit messages following the [Conventional Commits](https://www.conventionalcommits.org) standard, and follow the [Angular Commit Message Conventions](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format). Conventional Commits are enfordced by pre-commit hooks.

### Commit Message Format

Each commit message consists of a **header**, an optional **body**, and an optional **footer**. The header has a special format that includes a **type**, an optional **scope**, and a **subject**:

```text
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
| `revert`   | Reverts a previous commit | None |

#### Scope

The scope is optional and should specify the place of the commit change (e.g., component or file name).

#### Subject

The subject contains a succinct description of the change:

- Use the imperative, present tense: "change" not "changed" or "changes"
- Do not capitalize the first letter
- Do not end with a period

#### BREAKING CHANGES

Breaking changes should be indicated by:

1. Adding an exclamation mark after the type/scope: `feat!: introduce breaking change`
2. Adding a `BREAKING CHANGE:` footer with description: `BREAKING CHANGE: environment variables now take precedence over config files`
