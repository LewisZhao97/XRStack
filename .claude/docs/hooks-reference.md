# Active Hooks

Hooks are configured in `.claude/settings.json` and fire automatically:

## Core Hooks

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` commands | Validates design doc sections, JSON data files, hardcoded values, TODO format |
| `validate-push.sh` | PreToolUse (Bash) | `git push` commands | Warns on pushes to protected branches (develop/main) |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Asset file changes | Checks naming conventions and JSON validity for files in `assets/` |
| `session-start.sh` | SessionStart | Session begins | Loads sprint context, milestone, git activity |
| `detect-gaps.sh` | SessionStart | Session begins | Detects fresh projects (suggests /start-harness) and missing documentation |
| `pre-compact.sh` | PreCompact | Context compression | Dumps session state (modified files, WIP design docs) before compaction |
| `session-stop.sh` | Stop | Session ends | Summarizes accomplishments and updates session log |
| `log-agent.sh` | SubagentStart | Agent spawned | Audit trail of all subagent invocations with timestamps |

## Learning & Optimization Hooks (optional)

These hooks support the continuous learning and strategic compact systems. Add them to `.claude/settings.json` to enable:

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `observe.sh` | PreToolUse / PostToolUse | All tool calls (`*`) | Captures tool use events for instinct pattern analysis (continuous-learning-v2) |
| `suggest-compact.sh` | PreToolUse | Edit / Write | Suggests `/compact` at logical phase transitions after 50+ tool calls |

### Enabling Learning Hooks

Add to `.claude/settings.json` under `hooks`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "*",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/continuous-learning-v2/hooks/observe.sh pre" }]
      },
      {
        "matcher": "Edit",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/strategic-compact/suggest-compact.sh" }]
      },
      {
        "matcher": "Write",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/strategic-compact/suggest-compact.sh" }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "*",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/continuous-learning-v2/hooks/observe.sh post" }]
      }
    ]
  }
}
```

### Dependencies

- **observe.sh**: Requires Python 3 (for JSON parsing and secret scrubbing)
- **suggest-compact.sh**: Bash only, uses `$TMPDIR` for temp files

### Instinct Storage

Observations and instincts are stored at `~/.claude/homunculus/`:
- `projects/<hash>/observations.jsonl` — Raw tool call observations per project
- `projects/<hash>/instincts/personal/` — Project-scoped learned instincts
- `instincts/personal/` — Global instincts (promoted from projects)

See `/continuous-learning-v2` skill for full documentation.
