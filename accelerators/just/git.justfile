# Clean stale branches that are not main or current
[group('git')]
@clean_branches:
  just _banner "Start cleaning stale branches"
  set -e; \
    export HOME="${HOME:-${USERPROFILE:-}}"; \
    export GIT_TERMINAL_PROMPT=0; \
    HELPER=store; \
    echo "Pruning stale branches..."; \
    git -c credential.helper="$HELPER" fetch -p; \
    current_branch="$(git rev-parse --abbrev-ref HEAD)"; \
    echo "Deleting local branches..."; \
    for branch_name in $(git for-each-ref refs/heads/ --format="%(refname:short)"); do \
      [ "$branch_name" = "main" ] && continue; \
      [ "$branch_name" = "$current_branch" ] && continue; \
      git branch -d "$branch_name"; \
    done; \
    just _banner "Finished cleaning stale branches"
alias cleanbranches := clean_branches

# Reset to origin/main, removes all local changes
[confirm("Are you sure you want to reset and lose all your changes?")]
[group('git')]
@hardreset:
	just _banner "resetting to 'origin/main'..."
	set -e; \
	git fetch origin; \
	git reset --hard origin/main; \
	git clean -fd;
	just _banner "reset completed."
alias gitreset := hardreset
alias hardgitreset := hardreset
alias githardreset := hardreset
