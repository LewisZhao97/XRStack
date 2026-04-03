---
name: strategic-compact
description: Suggests manual context compaction at logical intervals to preserve context through task phases rather than arbitrary auto-compaction.
---

# Strategic Compact Skill

Suggests manual `/compact` at strategic points in your workflow rather than relying on arbitrary auto-compaction.

## When to Activate

- Running long sessions that approach context limits (200K+ tokens)
- Working on multi-phase tasks (research -> plan -> implement -> test)
- Switching between unrelated tasks within the same session
- After completing a major milestone and starting new work
- When responses slow down or become less coherent (context pressure)

## Why Strategic Compaction?

Auto-compaction triggers at arbitrary points:
- Often mid-task, losing important context
- No awareness of logical task boundaries
- Can interrupt complex multi-step operations

Strategic compaction at logical boundaries:
- **After exploration, before execution** — Compact research context, keep implementation plan
- **After completing a milestone** — Fresh start for next phase
- **Before major context shifts** — Clear exploration context before different task

## How It Works

The `suggest-compact.sh` script runs on PreToolUse (Edit/Write) and:

1. **Tracks tool calls** — Counts tool invocations in session
2. **Threshold detection** — Suggests at configurable threshold (default: 50 calls)
3. **Periodic reminders** — Reminds every 25 calls after threshold

## Hook Setup

Add to your project's `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/strategic-compact/suggest-compact.sh" }]
      },
      {
        "matcher": "Write",
        "hooks": [{ "type": "command", "command": "bash .claude/skills/strategic-compact/suggest-compact.sh" }]
      }
    ]
  }
}
```

## Configuration

Environment variables:
- `COMPACT_THRESHOLD` — Tool calls before first suggestion (default: 50)

## Compaction Decision Guide

| Phase Transition | Compact? | Why |
|-----------------|----------|-----|
| Research -> Planning | Yes | Research context is bulky; plan is the distilled output |
| Planning -> Implementation | Yes | Plan is in tasks or a file; free up context for code |
| Implementation -> Testing | Maybe | Keep if tests reference recent code; compact if switching focus |
| Debugging -> Next feature | Yes | Debug traces pollute context for unrelated work |
| Mid-implementation | No | Losing variable names, file paths, and partial state is costly |
| After a failed approach | Yes | Clear the dead-end reasoning before trying a new approach |

## What Survives Compaction

| Persists | Lost |
|----------|------|
| CLAUDE.md instructions | Intermediate reasoning and analysis |
| Task list | File contents you previously read |
| Memory files | Multi-step conversation context |
| Git state (commits, branches) | Tool call history and counts |
| Files on disk | Nuanced user preferences stated verbally |

## Best Practices

1. **Compact after planning** — Once plan is finalized in tasks, compact to start fresh
2. **Compact after debugging** — Clear error-resolution context before continuing
3. **Don't compact mid-implementation** — Preserve context for related changes
4. **Read the suggestion** — The hook tells you *when*, you decide *if*
5. **Write before compacting** — Save important context to files or memory before compacting
6. **Use `/compact` with a summary** — Add a custom message: `/compact Focus on implementing hand tracking next`

## Related

- Pre-compact hook (`.claude/hooks/pre-compact.sh`) — Captures session state before compaction
- `/save-session` — Save full session state before compacting
- `/checkpoint` — Create a git checkpoint before compacting
