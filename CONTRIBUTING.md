# Contributing

To contribute to this GitHub project, you can follow these steps:

1. Fork the repository you want to contribute to by clicking the "Fork" button on the project page.

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

12. Wait for the project maintainer to review your changes and provide feedback.

13. Make any necessary changes based on feedback and repeat steps 5-12 until your changes are accepted and merged into the main project.

14. Once your changes are merged, you can update your forked repository and local copy of the repository with the following commands:

```bash
git fetch upstream
git checkout master
git merge upstream/master
```

Finally, delete the branch you created with the following command:

```bash
git branch -d branch-name
```

That's it, you made it! 🐣⭐⭐
