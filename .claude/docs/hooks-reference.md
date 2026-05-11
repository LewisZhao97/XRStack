# Active Hooks

Hooks are configured in `.claude/settings.json` and fire automatically:

## Core Hooks

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` commands | Validates design doc sections, JSON data files, hardcoded values, TODO format |
| `validate-push.sh` | PreToolUse (Bash) | `git push` commands | Warns on pushes to protected branches (develop/main) |
| `code-review-hint.sh` | PreToolUse (Bash) | `git commit` with staged `.cs` files | Advisory reminder to run `/code-review` before the commit lands |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Asset file changes | Checks naming conventions and JSON validity for files in `assets/` |
| `milestone-gate-hint.sh` | PostToolUse (Write/Edit) | Milestone tracker fully resolved | Suggests `/milestone-gate` when no ⏳/🚧 rows remain and verdict is TBD |
| `session-start.sh` | SessionStart | Session begins | Loads recent context, milestone, git activity |
| `detect-gaps.sh` | SessionStart | Session begins | Detects fresh projects (suggests /start-harness) and missing documentation |
| `pre-compact.sh` | PreCompact | Context compression | Dumps session state (modified files, WIP design docs) before compaction |
| `session-stop.sh` | Stop | Session ends | Summarizes accomplishments and updates session log |
| `log-agent.sh` | SubagentStart | Agent spawned | Audit trail of all subagent invocations with timestamps |
