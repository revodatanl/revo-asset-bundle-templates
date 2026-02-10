# Contributing

## Prerequisites

- **[uv](https://docs.astral.sh/uv/)** - Fast Python package manager and project management
- **[git](https://git-scm.com/)** - Version control system
- **[Databricks CLI](https://docs.databricks.com/dev-tools/cli/index.html)** - Command-line interface for Databricks operations
- **[just](https://just.systems/man/en/packages.html)** - Build automation tool (very convenient during development)

## Step-by-step manual

To contribute to this GitHub project, you can follow these steps:

1. Creating a working branch

    **Internal contributors**:
    1. Run the following command from your terminal:
        `git clone https://github.com/revodatanl/revo-asset-bundle-templates.git`
    2. Create a feature branch using the following command:
        `git checkout -b "branch-name"`

    **External contributors**:
    1. fork the repository by clicking the "Fork" button on the project page.
    2. Clone the repo using the following command from your terminal:
        `git clone https://github.com/<path-to-your-repo>.git`
    3. Create a new branch for your changes using the following command:
        `git checkout -b "branch-name"`

2. Run setup

    1. - Windows users: create a `shell.justlocal` file and set the windows-shell with a path to your bash.exe. For example:
    `set windows-shell := ["C:\\\\Program Files\\\\Git\\\\bin\\\\bash.exe", "-lc"]`

    2. - All users: run `just setup` to install the pre-commit hooks.

3. Make your changes to the code or documentation. Do not forget to add tests (if needed).

4. Run deployment tests to ensure your changes work as expected. Use the following command to run the tests: `just test-deploy`.

5. Save and upload your changes.

    1. Stage all your changes locally using the following command:

        ```bash
        git add .
        ```

    2. Commit the changes with a meaningful commit message using the [Angular Commit Message Conventions](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format). For example:

        ```bash
        git commit -m "fix(semantic-release): add GitLab support"
        ```

    3. Push the changes using the following command:

        ```bash
        git push origin branch-name
        ```

6. Merge your changes into the main branch of the original repository.

    a. Go to the GitHub website and navigate to the repository.

    b. Click the "New pull request" button.

    c. Select the branch you just pushed to and the branch you want to merge into on the original repository.

    d. Add a meaningful description of your changes and click the "Create pull request" button.

    e. Confirm the `CI DABs` pipeline passes successfully. **Forked repositories need to have secrets added to them.**

    f. Wait for the project maintainer to review your changes and provide feedback.

    g. Make any necessary changes based on feedback and repeat steps from 3 upwards until your changes are accepted and merged into the main project.

7. Once your changes are merged, you can update your (forked) repository.

    **Internal contributors**:
    1. Go to your local repository and run the following commands in your terminal:

    ```bash
    git checkout main
    git pull
    ```

    **External contributors**:
    1. Go to your local repository and run the following commands in your terminal:

    ```bash
    git fetch upstream
    git checkout main
    git merge upstream/main
    ```

8. Finally, delete the branch you created with the following command:

    ```bash
    git branch -d branch-name
    ```

That's it, you made it! 🐣⭐⭐

## Repository and framework structure

This repository creates a `Databricks custom bundle template` which uses `Go package templating` syntax.

Find the official documentation [at docs.databricks.com](https://docs.databricks.com/aws/en/dev-tools/bundles/templates#custom-bundle-templates).

High level walk-through:

| File | Description |
| --- | --- |
| `databricks_template_schema.json` | Contains the cli prompts that allow the user to input values for the variables. |
| `template/__preamble.tmpl` | Contains rules that define what is included when the templated is rendered. |
| `library/template_variables.tmpl` | Contains variable manipulations that are not directly derived from the cli-input and can be used throughout the template. |
| `accelerators/*` | This directory is a work in progress and is not currently used. This is not a default component of Databricks custom bundle templates. |

This repository also provides a `justfile` which can help you properly setup git hooks, which will keep your commits compliant with contributing-rules.

### databricks_template_schema

An elaborate official example can be found in [an official Databricks Github repository](https://github.com/databricks/mlops-stacks/blob/main/databricks_template_schema.json).

For our installation it is important to understand at least the following topics:

1. The `order` determines the order in which the prompts are displayed, but also when values are available.

    This means you can't use the input from a prompt in any dynamic property or `skip_prompt_if` for a propertie with a lower ordernumber.
    To make it simple to expand the template without having to re-order everything, we have ordered the prompts in the following way:
    - 0-10: Fixed prompts, always required.
    - 11-20: CI/CD related prompts.
    - 20-30: DAB content related prompts.
    - 30-40: Supported platform/system related prompts.
    - 40-50: (just)-tooling related prompts.

2. `skip_prompt_if` is used to hide questions that are no longer relevant for the user.

    At the moment, this is the only property that allows preventing further prompts. It supports either a single property with a constant value comparison, or `anyOf` where multiple values have to match exactly in order for the prompt to show.

3. Prefer string values based on an `enum` whenever possible, this significantly increases user experience.

    For prompts where the `enum` property was set, there is no support for dynamic default values (derived from earlier input).
    This means that for cases where the prompt is optional, but a hardcoded default value is not always applicable, you have to provide a workaround in the `template_variables` file or in the template `__preamble`.
