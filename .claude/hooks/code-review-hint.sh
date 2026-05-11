#!/bin/bash
# Claude Code PreToolUse hook: hints at /code-review on `git commit`
# when C# files are staged. Advisory only — never blocks the commit.
# Exit 0 always; stderr is shown to Claude.

INPUT=$(cat)

if command -v jq >/dev/null 2>&1; then
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
else
    COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi

# Only act on git commit
if ! echo "$COMMAND" | grep -qE '^git[[:space:]]+commit'; then
    exit 0
fi

# Staged .cs files (added, copied, modified, renamed)
STAGED_CS=$(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null | grep -E '\.cs$' || true)

if [ -z "$STAGED_CS" ]; then
    exit 0
fi

echo "=== /code-review hint ===" >&2
echo "Staged C# files about to be committed:" >&2
echo "$STAGED_CS" | sed 's/^/  /' >&2
echo "" >&2
echo "If /code-review hasn't been run on these in this session," >&2
echo "consider doing so before the commit lands. Trivial / mechanical" >&2
echo "changes are fine to skip." >&2
echo "=========================" >&2

exit 0
