# Accelerators

> **Status: work in progress.** This directory is **not** wired into the
> template's automatic rendering and is not a default component of Databricks
> custom bundle templates. Treat everything here as experimental.

Accelerators are optional add-on modules that layer extra capabilities onto a
generated project (for example a dev container, SQLFluff configuration, or
MkDocs documentation).

## How they are applied

There are two patterns in use:

- **`bundle init --template-dir`** — modules such as `devcontainer/` are
  themselves small bundle templates and are applied on top of a generated
  project with `databricks bundle init <repo> --template-dir accelerators/<name>`.
- **`*.additions` snippets** — files like `pyproject.toml.additions` or
  `Makefile.additions` contain fragments meant to be merged into the
  corresponding base file. **There is currently no automated applier for these
  snippets**; they are applied manually. Until an applier exists, keep these
  fragments in sync with the files they patch by hand.
