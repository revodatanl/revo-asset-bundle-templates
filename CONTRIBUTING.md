# Contributing

To contribute to this GitHub project, you can follow these steps:

1. you can take two paths:

    a. Developing within the RevoData organisation: create a feature branch and work from there.
    b. Developing outside the RevoData organisation: fork the repository by clicking the "Fork" button on the project page.

2. Clone the repository to your local machine using the following command:

    ```bash
    git clone https://github.com/revodatanl/revo-asset-bundle-templates.git
    ```

3. Create a new branch for your changes using the following command:

    ```bash
    git checkout -b "branch-name"
    ```

4. Make your changes to the code or documentation. Do not forget to add tests (if needed).

5. Add the changes to the staging area using the following command:

    ```bash
    git add .
    ```

6. Commit the changes with a meaningful commit message using the [Angular Commit Message Conventions](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format). For example:

    ```bash
    git commit -m "fix(semantic-release): add GitLab support"
    ```

7. Push the changes to your forked repository using the following command:

    ```bash
    git push origin branch-name
    ```

8. Go to the GitHub website and navigate to your forked repository.

9. Click the "New pull request" button.

10. Select the branch you just pushed to and the branch you want to merge into on the original repository.

11. Add a meaningful description of your changes and click the "Create pull request" button.

12. Wait for the project maintainer to review your changes and provide feedback. Also, the `CI DABs` pipeline must pass succesfully. You may need to add secrets to your repository.

13. Make any necessary changes based on feedback and repeat steps 5-12 until your changes are accepted and merged into the main project.

14. Once your changes are merged, you can update your forked repository and local copy of the repository with the following commands:

```bash
git fetch upstream
git checkout main
git merge upstream/main
```

Finally, delete the branch you created with the following command:

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
| `template\__preamble.tmpl` | Contains rules that define what is included when the templated is rendered. |
| `library\template_variables.tmpl` | Contains variable manipulations that are not directly derived from the cli-input and can be used throughout the template. |
| `accelerators\*` | This directory is a work in progress and is not currently used. This is not a default component of Databricks custom bundle templates. |

This repository also provides a `justfile` which can help you properly setup git hooks, which will keep your commits compliant with contributing-rules.
