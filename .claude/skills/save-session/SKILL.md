---
name: save-session
description: Save current session state to a dated file so work can be resumed in a future session with full context.
command: true
---

# Save Session Command

Capture everything that happened in this session and write it to a dated file so the next session can pick up where this one left off.

## When to Use

- End of a work session before closing Claude Code
- Before hitting context limits (run this first, then start a fresh session)
- After solving a complex problem you want to remember
- Any time you need to hand off context to a future session

## Process

### Step 1: Gather context

- Read all files modified during this session (use git diff or recall from conversation)
- Review what was discussed, attempted, and decided
- Note any errors encountered and how they were resolved (or not)
- Check current test/build status if relevant

### Step 2: Create the sessions folder if it doesn't exist

```bash
mkdir -p ~/.claude/session-data
```

### Step 3: Write the session file

Create `~/.claude/session-data/YYYY-MM-DD-<short-id>-session.tmp` using today's date and a short identifier (lowercase letters, digits, hyphens, 8+ characters).

### Step 4: Populate all sections below

Write every section honestly. Do not skip sections — write "Nothing yet" or "N/A" if a section has no content.

### Step 5: Show the file to the user

After writing, display the full contents and ask for confirmation.

## Session File Format

```markdown
# Session: YYYY-MM-DD

**Started:** [approximate time if known]
**Last Updated:** [current time]
**Project:** [project name or path]
**Branch:** [current git branch]
**Topic:** [one-line summary]

---

## What We Are Building

[1-3 paragraphs describing the feature, bug fix, or task. Include enough
context that someone with zero memory of this session can understand the goal.]

---

## What WORKED (with evidence)

- **[thing that works]** — confirmed by: [specific evidence]

If nothing confirmed: "Nothing confirmed working yet."

---

## What Did NOT Work (and why)

- **[approach tried]** — failed because: [exact reason / error message]

If nothing failed: "No failed approaches yet."

---

## What Has NOT Been Tried Yet

- [approach / idea]

---

## Current State of Files

| File | Status | Notes |
|------|--------|-------|
| `path/to/file.cs` | Complete | [what it does] |
| `path/to/file.cs` | In Progress | [what's done, what's left] |

---

## Decisions Made

- **[decision]** — reason: [why this was chosen over alternatives]

---

## Blockers & Open Questions

- [blocker / open question]

---

## Exact Next Step

[The single most important thing to do when resuming.]
```

## Notes

- Each session gets its own file — never append to a previous session's file
- The "What Did NOT Work" section is most critical — prevents retrying failed approaches
- Use `/sessions list` to browse saved sessions
- Use `/sessions load <id>` to resume from a saved session

## Related

- `/sessions` — Browse and load saved sessions
- `/checkpoint` — Create a git-level checkpoint (lighter than full session save)
