#!/bin/bash
# Claude Code PostToolUse hook: when a milestone tracker is fully resolved
# (no ⏳ pending or 🚧 prototype rows) AND the verdict is still TBD,
# suggest running /milestone-gate.
# Exit 0 always (PostToolUse cannot block); stderr shown to Claude.

INPUT=$(cat)

if command -v jq >/dev/null 2>&1; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
    FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')

# Only act on milestone trackers
if ! echo "$FILE_PATH" | grep -qE 'docs/production/m[0-9]+-completion\.md$'; then
    exit 0
fi

if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

# Any outstanding work? Silent if so.
if grep -qE '(⏳ pending|🚧 prototype)' "$FILE_PATH"; then
    exit 0
fi

# Verdict already written? Silent if so.
if ! grep -qE '\*\*Verdict\*\*.*TBD' "$FILE_PATH"; then
    exit 0
fi

echo "=== /milestone-gate hint ===" >&2
echo "$FILE_PATH has no ⏳ or 🚧 rows and the verdict is still TBD." >&2
echo "When you're ready, run /milestone-gate to produce the PASS /" >&2
echo "CONCERNS / FAIL verdict." >&2
echo "============================" >&2

exit 0
