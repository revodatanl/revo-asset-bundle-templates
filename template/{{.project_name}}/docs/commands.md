# Command Reference

The project contains a `Makefile` with several commands to simplify common development tasks.

### `make (setup)`

**Sets up the project development environment.**

The command installs [`Git`](https://git-scm.com), [`uv`](https://github.com/astral-sh/uv), and the [Databricks CLI](https://docs.databricks.com/dev-tools/cli/databricks-cli.html), configures Python, sets up a virtual environment, and installs pre-commit hooks. The current project configuration matches Databricks Runtime `15.4-LTS`.

<details>
<summary>example output</summary>

![make-setup](images/make-setup.png)
</details>

### `make clean`

**Cleans up the project by removing any Python virtual environments, cached files, and artifacts.**

<details>
<summary>example output</summary>

![make-clean](images/make-clean.png)
</details>

### `make test`

**Runs a full test suite and generates a coverage report using `pytest`.**

Prior to running the test suite, it updates dependencies, builds the package, and runs pre-commit hooks over all files, to mimic functionality during CI.

<details>
<summary>example output</summary>

![make-test](images/make-test.png)
</details>

### `make validate`

**Validates the bundle resources.**

Prior to validation, it updates dependencies, builds the package, and runs pre-commit hooks over all files, to mimic functionality during CI.

<details>
<summary>example output</summary>

![make-validate](images/make-validate.png)
</details>

### `make deploy`

**Deploys bundle resources to the default Databricks environment.**

Prior to deployment, it updates dependencies, builds the package, and runs pre-commit hooks over all files, to mimic functionality during CI.

<details>
<summary>example output</summary>

![make-deploy](images/make-deploy.png)
</details>

### `make destroy`

**Destroys bundle resources deployed to the default Databricks environment.**

<details>
<summary>example output</summary>

![make-destroy](images/make-destroy.png)
</details>

### `make tree`

**Generates a tree representation of the project directory structure, excluding irrelevant directories.**

<details>
<summary>example output</summary>

![make-tree](images/make-tree.png)
</details>

### `make lint`

**Runs linters on the project code: `ruff`, `mypy`, and `pydoclint`.**

<details>
<summary>example output</summary>

![make-lint](images/make-lint.png)
</details>
