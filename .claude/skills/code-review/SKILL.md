---
name: code-review
description: "Performs an architectural and quality code review on a specified file or set of files. Checks for coding standard compliance, architectural pattern adherence, SOLID principles, testability, and performance concerns. Offers to export the review as a dated document under docs/production/code-reviews/."
argument-hint: "[path-to-file-or-directory]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write
---

When this skill is invoked:

1. **Read the target file(s)** in full.

2. **Read the CLAUDE.md** for project coding standards.

3. **Identify the system category** (engine, gameplay, AI, networking, UI, tools)
   and apply category-specific standards.

4. **Evaluate against coding standards**:
   - [ ] Public methods and classes have doc comments
   - [ ] Cyclomatic complexity under 10 per method
   - [ ] No method exceeds 40 lines (excluding data declarations)
   - [ ] Dependencies are injected (no static singletons for game state)
   - [ ] Configuration values loaded from data files
   - [ ] Systems expose interfaces (not concrete class dependencies)

5. **Check architectural compliance**:
   - [ ] Correct dependency direction (engine <- gameplay, not reverse)
   - [ ] No circular dependencies between modules
   - [ ] Proper layer separation (UI does not own game state)
   - [ ] Events/signals used for cross-system communication
   - [ ] Consistent with established patterns in the codebase

6. **Check SOLID compliance**:
   - [ ] Single Responsibility: Each class has one reason to change
   - [ ] Open/Closed: Extendable without modification
   - [ ] Liskov Substitution: Subtypes substitutable for base types
   - [ ] Interface Segregation: No fat interfaces
   - [ ] Dependency Inversion: Depends on abstractions, not concretions

7. **Check for common game development issues**:
   - [ ] Frame-rate independence (delta time usage)
   - [ ] No allocations in hot paths (update loops)
   - [ ] Proper null/empty state handling
   - [ ] Thread safety where required
   - [ ] Resource cleanup (no leaks)

8. **Output the review** in this format:

```
## Code Review: [File/System Name]

### Standards Compliance: [X/6 passing]
[List failures with line references]

### Architecture: [CLEAN / MINOR ISSUES / VIOLATIONS FOUND]
[List specific architectural concerns]

### SOLID: [COMPLIANT / ISSUES FOUND]
[List specific violations]

### Game-Specific Concerns
[List game development specific issues]

### Positive Observations
[What is done well -- always include this section]

### Required Changes
[Must-fix items before approval]

### Suggestions
[Nice-to-have improvements]

### Verdict: [APPROVED / APPROVED WITH SUGGESTIONS / CHANGES REQUIRED]
```

9. **Offer to export.** After delivering the review in chat, ask the user a single short question — e.g. *"Want me to save this review to `docs/production/code-reviews/` as a dated document?"* — and wait for their answer. Don't auto-export. Don't bundle the question with other follow-up work; it's a clean yes/no.

10. **If the user says yes**, write the full review to `docs/production/code-reviews/code-review-YYYY-MM-DD.md` (today's date in ISO format). Add a short header with date, scope (which files/system was reviewed), and reviewer (e.g. *self-review* or the agent that produced it). Preserve the section structure exactly as delivered above. After saving, append a `## Resolution` section as a placeholder for tracking which review items get fixed later — leave it empty for the user to fill in or for a future session to populate.

    - **Filename collision**: if `code-review-YYYY-MM-DD.md` already exists, append a counter — `code-review-YYYY-MM-DD-2.md`, `code-review-YYYY-MM-DD-3.md`, etc. Don't overwrite. Multiple reviews on the same day are normal.
    - **Lazy scaffolding**: the `code-reviews/` directory should already exist (it's a durable production folder per the milestone tracker convention). If for some reason it doesn't, create it.

11. **If the user says no** (or doesn't want it persisted), do nothing further. The chat output is the deliverable.
