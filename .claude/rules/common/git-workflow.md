# Git Workflow

## Commit Message Format
```
<type>: <description>

<optional body>
```

Note: Attribution disabled globally via ~/.claude/settings.json.

### Commit Types

| Type | Purpose | Example |
|------|---------|---------|
| `feat` | New feature or functionality | `feat: add hand tracking support` |
| `fix` | Bug fix | `fix: resolve pose jitter on fast movement` |
| `perf` | Performance optimization | `perf: reduce memory allocation in tracking loop` |
| `refactor` | Code restructuring (no behavior change) | `refactor: extract common utilities to shared module` |
| `revert` | Revert a previous change | `revert: remove experimental API` |
| `docs` | Documentation only | `docs: update SDK integration guide` |
| `test` | Adding or updating tests | `test: add hand tracking unit tests` |
| `chore` | Build, tooling, config changes | `chore: update UPM package manifest` |
| `ci` | CI/CD pipeline changes | `ci: add build validation step` |

## Pull Request Workflow

When creating PRs:
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

> For the full development process (planning, TDD, code review) before git operations,
> see [development-workflow.md](./development-workflow.md).
