# Release

Our releases are automatically tagged by following [Semantic Versioning](https://semver.org). This ensures that versioning, changelog generation, and package publishing are handled consistently and efficiently.

## Semantic Release

We utilize the principles of Semantic Release to automatically bump the version of the repository based on the nature of the changes introduced. Semantic Release analyzes commit messages following the [Conventional Commits](https://www.conventionalcommits.org) standard (with the [Angular](https://angular.dev/style-guide) convention) to determine the next version number:

| Commit Type                               | Description                                     | Example                     |
|-------------------------------------------|-------------------------------------------------|-----------------------------|
| `fix:`                                    | triggers a **patch** version update             | `1.0.0` --> `1.0.1`         |
| `feat:`                                   | triggers a **minor** version update             | `1.0.0` --> `1.1.0`         |
| `*!:`                                     | triggers a **major** version update             | `1.0.0` --> `2.0.0`         |

The appropriate version number is then automatically updated in the repository.

## Automated CHANGELOG Generation

As part of the release process, we auto-generate a comprehensive [CHANGELOG](CHANGELOG.md). The CHANGELOG is automatically updated with each release, capturing all notable changes, enhancements, bug fixes, and breaking changes based on the commit messages.

## Automated Release

Not set up yet.
