# Release

Our project follows a streamlined and automated release process using Semantic Release. This ensures that versioning, changelog generation, and package publishing are handled consistently and efficiently.

## Semantic Release

We utilize Semantic Release to automatically bump the version of the repository based on the nature of the changes introduced. Semantic Release analyzes commit messages following the Conventional Commits standard to determine the next version number:

- `fix:` triggers a patch version bump.
- `feat:` triggers a minor version bump.
- `feat!:` or `BREAKING CHANGES:` trigger a major version bump.

The appropriate version number is then automatically updated in the repository.

## Automated Changelog Generation

As part of the release process, we auto-generate a comprehensive changelog. This changelog is automatically updated with each release, capturing all notable changes, enhancements, bug fixes, and breaking changes based on the commit messages.

## Automated Release

Not set up yet.
