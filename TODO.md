# TODO: Template Slimming Plan

This document outlines atomic improvements to slim down the RevoData Asset Bundle Templates. Each section represents a logical grouping that can be implemented independently.

## Group 1: Remove Bandit Security Scanning ✅ COMPLETED

**Objective**: Remove bandit completely from the core template

### Tasks:
- [x] Remove `bandit>=1.8.3` from `pyproject.toml.tmpl` dev dependencies (line 18)
- [x] Remove bandit configuration section from `pyproject.toml.tmpl` (lines 111-114)
- [x] Remove bandit pre-commit hook from `.pre-commit-config.yaml` (lines 46-54)
- [x] Remove bandit from Makefile lint target
- [x] Update CI workflows to remove bandit references (both GitHub and Azure DevOps)
- [x] Update documentation to remove bandit references
- [x] Update template documentation (CLAUDE.md)
- [x] Validate template generation works without bandit

**Files modified**:
- `template/{{.project_name}}/pyproject.toml.tmpl`
- `template/{{.project_name}}/.pre-commit-config.yaml`
- `template/{{.project_name}}/Makefile.tmpl`
- `template/{{.project_name}}/.github/workflows/ci.yml.tmpl`
- `template/{{.project_name}}/.azuredevops/.azure-pipelines/ci.yml.tmpl`
- `template/{{.project_name}}/docs/commands.md`
- `template/{{.project_name}}/docs/coding_standards.md.tmpl`
- `CLAUDE.md`

## Group 2: Create SQLFluff Module

**Objective**: Move SQLFluff to modules system for optional inclusion

### Tasks:
- [ ] Create `modules/sqlfluff/` directory structure
- [ ] Create `modules/sqlfluff/pyproject.toml.additions` with SQLFluff config (lines 34, 116-133)
- [ ] Create `modules/sqlfluff/pre-commit.additions` with SQLFluff hooks (lines 59-63)
- [ ] Create `modules/sqlfluff/vscode-settings.additions` with SQLFluff settings (lines 27-36, 50-54)
- [ ] Remove `sqlfluff>=3.3.1` from core dependencies
- [ ] Remove SQLFluff config from core `pyproject.toml.tmpl`
- [ ] Remove SQLFluff hooks from core `.pre-commit-config.yaml`
- [ ] Remove SQLFluff settings from core VS Code settings

**Files to create**:
- `modules/sqlfluff/pyproject.toml.additions`
- `modules/sqlfluff/pre-commit.additions`
- `modules/sqlfluff/vscode-settings.additions`

**Files to modify**:
- `template/{{.project_name}}/pyproject.toml.tmpl`
- `template/{{.project_name}}/.pre-commit-config.yaml`
- `template/{{.project_name}}/.vscode/settings.json.tmpl`

## Group 3: Create MkDocs Module

**Objective**: Move MkDocs documentation system to modules for optional inclusion

### Tasks:
- [ ] Create `modules/mkdocs/` directory structure
- [ ] Move entire `docs/` folder to `modules/mkdocs/docs/`
- [ ] Move `mkdocs.yml.tmpl` to `modules/mkdocs/`
- [ ] Create `modules/mkdocs/pyproject.toml.additions` with MkDocs dependencies (lines 24-25)
- [ ] Remove MkDocs dependencies from core `pyproject.toml.tmpl`
- [ ] Remove `make docs` target from core Makefile
- [ ] Update CI workflows to remove MkDocs references

**Files to move**:
- `template/{{.project_name}}/docs/` → `modules/mkdocs/docs/`
- `template/{{.project_name}}/mkdocs.yml.tmpl` → `modules/mkdocs/`

**Files to create**:
- `modules/mkdocs/pyproject.toml.additions`

**Files to modify**:
- `template/{{.project_name}}/pyproject.toml.tmpl`
- `template/{{.project_name}}/Makefile.tmpl`

## Group 4: Remove pre-commit-update Hook

**Objective**: Remove automatic pre-commit updating hook and replace with manual Makefile target

### Tasks:
- [ ] Remove pre-commit-update hook from `.pre-commit-config.yaml` (lines 2-7)
- [ ] Add `update-pre-commit` target to Makefile:
  ```makefile
  update-pre-commit:
      @echo "Updating pre-commit hooks..."
      @uv run pre-commit autoupdate
  ```
- [ ] Add `update-venv` target to Makefile:
  ```makefile
  update-venv:
      @echo "Updating virtual environment dependencies..."
      @uv sync --upgrade
  ```
- [ ] Add `update-all` target to Makefile:
  ```makefile
  update-all: update-pre-commit update-venv
      @echo "All dependencies updated and synced"
  ```

**Files to modify**:
- `template/{{.project_name}}/.pre-commit-config.yaml`
- `template/{{.project_name}}/Makefile.tmpl`

## Group 5: Create Static Documentation Structure

**Objective**: Replace dynamic MkDocs with static documentation that works out-of-the-box

### Tasks:
- [ ] Create new static documentation structure in `docs/`:
  - `docs/README.md` - Main documentation index
  - `docs/getting-started.md` - Quick start guide
  - `docs/development.md` - Development workflow
  - `docs/deployment.md` - Databricks deployment
  - `docs/troubleshooting.md` - Common issues
  - `docs/commands.md` - Command reference
- [ ] Update main `README.md.tmpl` to link to static documentation files
- [ ] Remove references to `make docs` from README
- [ ] Ensure documentation works without any build step

**Files to create**:
- `template/{{.project_name}}/docs/README.md`
- `template/{{.project_name}}/docs/getting-started.md`
- `template/{{.project_name}}/docs/development.md`
- `template/{{.project_name}}/docs/deployment.md`
- `template/{{.project_name}}/docs/troubleshooting.md`
- `template/{{.project_name}}/docs/commands.md`

**Files to modify**:
- `template/{{.project_name}}/README.md.tmpl`

## Group 6: Update CI Pipeline

**Objective**: Update CI to build from uv.lock and remove moved dependencies

### Tasks:
- [ ] Update CI to use `uv sync --frozen` for reproducible builds
- [ ] Remove SQLFluff checks from CI workflows
- [ ] Remove Bandit checks from CI workflows
- [ ] Remove MkDocs build from CI workflows
- [ ] Add uv.lock validation step to CI
- [ ] Ensure all template configurations still work in CI

**Files to modify**:
- `.github/workflows/ci-dabs.yml`
- `template/{{.project_name}}/.github/workflows/ci.yml`
- `template/{{.project_name}}/.github/workflows/deploy-dab.yml`

## Group 7: Update Template Schema and Documentation

**Objective**: Update template documentation and schema to reflect changes

### Tasks:
- [ ] Update `CLAUDE.md` to reflect new streamlined template structure
- [ ] Update main `README.md` to reflect changes
- [ ] Update `databricks_template_schema.json` if needed
- [ ] Document the new modules system
- [ ] Update generated project badges to reflect removed tools

**Files to modify**:
- `CLAUDE.md`
- `README.md`
- `databricks_template_schema.json` (if needed)
- `template/{{.project_name}}/README.md.tmpl`

## Implementation Notes

- **Atomic Changes**: Each group can be implemented independently
- **Testing**: Test template generation after each group is completed
- **Dependencies**: Groups 1-4 have no dependencies, Group 5 can be done anytime, Group 6 depends on 1-3, Group 7 is final cleanup
- **Validation**: Use the CI pipeline to validate changes don't break template generation

## Success Criteria

- [ ] Template generates successfully with all configurations
- [ ] Generated projects have all core functionality working
- [ ] Core template is ~30% smaller in terms of dependencies
- [ ] Documentation is accessible without build step
- [ ] CI pipeline is faster and more reliable
- [ ] Modules system is ready for future additions
