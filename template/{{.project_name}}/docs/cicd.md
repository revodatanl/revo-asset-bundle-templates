# CI/CD

The project uses GitHub Actions for CI/CD. The pipeline configuration, including a pull request template, is located in the `.github` directory.

Two pipelines are defined in the `.github/workflows` directory:

- `ci.yml`: The CI pipeline runs on every pull request.
- `semantic-release.yml`: The semantic release pipeline runs on every push to the `main` branch and, based upon pull request tags, automatically bumps the version of the package.

### Pipeline 1: CI

This `CI` pipeline is triggered upon a pull request to any branch. It runs continuous integration tasks across multiple operating systems, setting up the environment, installing dependencies, running formatting checks with `ruff` and `mypy`, executing unit tests with coverage reporting, and finally building and validating the package to ensure consistency between source and built files.

### Pipeline 2: Semantic Release

This pipeline is triggered when a pull request is closed and merged into the main branch. It checks out the code, sets up the environment, and uses `python-semantic-release` to handle versioning and releasing the package. To trigger the automated versioning process, please ensure your commit messages follow semantic versioning conventions. Use prefixes like `fix:`, `feat:`, or `*!:` (or using `BREAKING CHANGES` in the commit message) in your commits to indicate the type of change:

| Commit Type                               | Description                                     | Example                     |
|-------------------------------------------|-------------------------------------------------|-----------------------------|
| `fix:`                                    | for bug fixes: triggers a **patch** version update | 1.0.0 -> 1.0.1              |
| `feat:`                                   | for new features: triggers a **minor** version update | 1.0.0 -> 1.1.0              |
| `*!:` (or using `BREAKING CHANGES` in the commit message) | for breaking changes: triggers a **major** version update | 1.0.0 -> 2.0.0              |

This ensures automated semantic versioning and release management, maintaining consistency and clarity in version updates.
