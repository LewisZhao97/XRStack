---
name: learn-eval
description: "Extract reusable patterns from the session, self-evaluate quality before saving, and determine the right save location (Global vs Project)."
---

# /learn-eval — Extract, Evaluate, then Save

Extract reusable patterns from the current session with a quality gate and save-location decision before writing any skill file.

## What to Extract

Look for:

1. **Error Resolution Patterns** — root cause + fix + reusability
2. **Debugging Techniques** — non-obvious steps, tool combinations
3. **Workarounds** — Unity quirks, XRI limitations, platform-specific fixes
4. **Project-Specific Patterns** — conventions, architecture decisions, XR interaction patterns

## Process

1. Review the session for extractable patterns
2. Identify the most valuable/reusable insight

3. **Determine save location:**
   - Ask: "Would this pattern be useful in a different project?"
   - **Global** (`~/.claude/skills/learned/`): Generic patterns usable across 2+ projects (Unity best practices, XR safety rules, debugging techniques)
   - **Project** (`.claude/skills/learned/` in current project): Project-specific knowledge (this project's architecture, specific SDK quirks)
   - When in doubt, choose Global

4. Draft the skill file using this format:

```markdown
---
name: pattern-name
description: "Under 130 characters"
user-invocable: false
origin: auto-extracted
---

# [Descriptive Pattern Name]

**Extracted:** [Date]
**Context:** [Brief description of when this applies]

## Problem
[What problem this solves — be specific]

## Solution
[The pattern/technique/workaround — with code examples]

## When to Use
[Trigger conditions]
```

5. **Quality gate — Checklist + Holistic verdict**

   ### 5a. Required checklist (verify by actually reading files)

   - [ ] Grep `~/.claude/skills/` and project `.claude/skills/` for content overlap
   - [ ] Check MEMORY.md (both project and global) for overlap
   - [ ] Consider whether appending to an existing skill would suffice
   - [ ] Confirm this is a reusable pattern, not a one-off fix

   ### 5b. Holistic verdict

   | Verdict | Meaning | Next Action |
   |---------|---------|-------------|
   | **Save** | Unique, specific, well-scoped | Proceed to Step 6 |
   | **Improve then Save** | Valuable but needs refinement | Revise and re-evaluate once |
   | **Absorb into [X]** | Should be appended to existing skill | Show target + additions |
   | **Drop** | Trivial, redundant, or too abstract | Explain and stop |

6. **Verdict-specific confirmation flow**

- **Save**: Present save path + checklist results + verdict rationale + full draft — save after user confirmation
- **Improve then Save**: Present improvements + revised draft — save after confirmation
- **Absorb into [X]**: Present target path + additions in diff format — append after confirmation
- **Drop**: Show reasoning only (no confirmation needed)

7. Save / Absorb to the determined location

## Notes

- Don't extract trivial fixes (typos, simple syntax errors)
- Don't extract one-time issues (specific API outages, etc.)
- Focus on patterns that will save time in future sessions
- Keep skills focused — one pattern per skill
- When the verdict is Absorb, append to the existing skill rather than creating a new file

## Related

- `/instinct-status` — View automatically learned instincts
- `/evolve` — Promote instinct clusters into full skills
