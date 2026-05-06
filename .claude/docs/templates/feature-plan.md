# Feature Plan: [Feature Name]

> **Milestone**: [M1 / M2 / M3 …]
> **References**: [link to relevant `game-*` doc sections, ADRs, or sibling feature plans]

## Goal

[One paragraph. What does this feature deliver, and what observable behaviour signals "done"? If you can't write this paragraph crisply, the feature isn't ready to plan — clarify scope first.]

## Why now

[One paragraph. Why is this feature scheduled now rather than later? Which milestone gate does it unlock? Which design pillar does it serve? If the answer is "because we said so," reconsider — the milestone tracker should already justify it.]

## What this *is* and *isn't*

[Optional but recommended for any feature whose scope is easy to inflate. A two-column table is often the clearest format:]

| In scope | Out of scope (deferred to …) |
|---|---|
| | |

## Architecture

[How does this feature fit into the existing code? Which files change? Which new files appear? Which subsystem boundaries does it touch? Reference `game-architecture.md` rather than restating it.]

| File | Change |
|---|---|
| | |

[Add focused sub-sections only when they're load-bearing — e.g. § *Topology surface lock*, § *Buffer ownership*, § *State machine transitions*. Don't add headings for ceremony.]

## Phases

[Decompose only as far as needed to make the work tractable. A small feature has 1 phase; a complex one has 3–5. Each phase must have an acceptance condition you can verify.]

### Phase 1 — [Name] (~[rough effort, e.g. half a day])
- [ ] Concrete task
- [ ] Concrete task

**Acceptance**: [verifiable condition]

### Phase 2 — [Name] (~[rough effort])
…

## Out of scope (still)

[Things explicitly *not* in this feature, with a pointer to where they belong instead. Useful as scope insurance against drift.]

- …

## Risks

| Risk | Severity | Mitigation |
|---|---|---|
| | | |

## Done criteria

- [ ] [verifiable condition]
- [ ] [verifiable condition]
- [ ] [verifiable condition]

## Status

[Drafted YYYY-MM-DD. Update at major checkpoints. When fully shipped, delete this file (and its containing directory if empty); tick the row in the milestone tracker. If any architectural rationale here is durable, promote it to a GDD or ADR before deleting.]
