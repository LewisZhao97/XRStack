---
name: instinct-import
description: Import instincts from file or URL into project/global scope
command: true
---

# Instinct Import Command

## Implementation

```bash
python3 .claude/skills/continuous-learning-v2/scripts/instinct-cli.py import <file-or-url> [--dry-run] [--force] [--min-confidence 0.7] [--scope project|global]
```

Import instincts from local file paths or HTTP(S) URLs.

## Usage

```
/instinct-import team-instincts.yaml
/instinct-import team-instincts.yaml --dry-run
/instinct-import team-instincts.yaml --scope global --force
```

## What to Do

1. Fetch the instinct file (local path or URL)
2. Parse and validate the format
3. Check for duplicates with existing instincts
4. Merge or add new instincts
5. Save to inherited instincts directory:
   - Project scope: `~/.claude/homunculus/projects/<project-id>/instincts/inherited/`
   - Global scope: `~/.claude/homunculus/instincts/inherited/`

## Merge Behavior

When importing an instinct with an existing ID:
- Higher-confidence import becomes an update candidate
- Equal/lower-confidence import is skipped
- User confirms unless `--force` is used

## Flags

- `--dry-run`: Preview without importing
- `--force`: Skip confirmation prompt
- `--min-confidence <n>`: Only import instincts above threshold
- `--scope <project|global>`: Select target scope (default: `project`)

## Related

- `/instinct-export` — Export instincts to share
- `/instinct-status` — View all instincts after import
