---
name: instinct-export
description: Export instincts from project/global scope to a shareable file
command: true
---

# Instinct Export Command

Exports instincts to a shareable format for teammates or cross-machine transfer.

## Implementation

```bash
python3 .claude/skills/continuous-learning-v2/scripts/instinct-cli.py export [options]
```

## Usage

```
/instinct-export                           # Export all personal instincts
/instinct-export --domain testing          # Export only testing instincts
/instinct-export --min-confidence 0.7      # Only export high-confidence instincts
/instinct-export --output team-instincts.yaml
/instinct-export --scope project --output project-instincts.yaml
```

## What to Do

1. Detect current project context
2. Load instincts by selected scope:
   - `project`: current project only
   - `global`: global only
   - `all`: project + global merged (default)
3. Apply filters (`--domain`, `--min-confidence`)
4. Write YAML-style export to file (or stdout if no output path provided)

## Flags

- `--domain <name>`: Export only specified domain
- `--min-confidence <n>`: Minimum confidence threshold
- `--output <file>`: Output file path (prints to stdout when omitted)
- `--scope <project|global|all>`: Export scope (default: `all`)

## Related

- `/instinct-import` — Import instincts from file
- `/instinct-status` — View instincts before exporting
