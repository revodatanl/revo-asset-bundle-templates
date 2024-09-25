## Dependabot

We use GitHub's Dependabot to automatically check for updates to GitHub Actions and Python dependencies. It performs daily checks and groups dependencies as follows:

- **GitHub Actions**: All dependencies within GitHub Actions are monitored and updated daily.
- **Python Dependencies**:
  - **Development Dependencies**: Development-specific dependencies are updated daily.
  - **Production Dependencies**: Production-specific dependencies are also checked daily.

This ensures dependencies are regularly maintained while adhering to the fixed environment constraints.

By default, we are excluding `pandas` and `numpy`, since they are fixed at Databricks Runtime 14.3 LTS.
