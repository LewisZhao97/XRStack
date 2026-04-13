---
name: checkpoint
description: Create or verify a named git checkpoint for tracking progress during implementation
command: true
---

# Checkpoint Command

Create or verify a checkpoint in your workflow.

## Usage

`/checkpoint [create|verify|list] [name]`

## Create Checkpoint

1. Run `/verify` quick to ensure current state is clean
2. Create a git commit with checkpoint name
3. Log checkpoint to `.claude/checkpoints.log`:

```bash
echo "$(date +%Y-%m-%d-%H:%M) | $CHECKPOINT_NAME | $(git rev-parse --short HEAD)" >> .claude/checkpoints.log
```

4. Report checkpoint created

## Verify Checkpoint

Compare current state against a named checkpoint:

1. Read checkpoint from log
2. Compare current state:
   - Files added since checkpoint
   - Files modified since checkpoint
   - Test pass rate now vs then
   - Build status now vs then

3. Report:
```
CHECKPOINT COMPARISON: $NAME
============================
Files changed: X
Tests: +Y passed / -Z failed
Build: [PASS/FAIL]
```

## List Checkpoints

Show all checkpoints with:
- Name
- Timestamp
- Git SHA
- Status (current, behind, ahead)

## Workflow

Typical checkpoint flow:

```
[Start] --> /checkpoint create "feature-start"
   |
[Implement] --> /checkpoint create "core-done"
   |
[Test] --> /checkpoint verify "core-done"
   |
[Refactor] --> /checkpoint create "refactor-done"
   |
[PR] --> /checkpoint verify "feature-start"
```

## Arguments

$ARGUMENTS:
- `create <name>` - Create named checkpoint
- `verify <name>` - Verify against named checkpoint
- `list` - Show all checkpoints
- `clear` - Remove old checkpoints (keeps last 5)

## Related

- `/verify` — Run verification loop before checkpointing
- `/eval check` — Run evals against checkpoint baseline
- `/save-session` — Save full session context (broader than checkpoint)
