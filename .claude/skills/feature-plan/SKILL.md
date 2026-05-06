---
name: feature-plan
description: "Drafts an implementation plan for one coherent feature or module. Plans are sized to the work, not to a calendar. Sub-plans nest underneath when a feature is large enough to warrant decomposition. Pulls context from game-* design docs and the active milestone tracker."
argument-hint: "[feature-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

When this skill is invoked:

1. **Read the design constitution** to ground the plan in the project's design intent:
   - `docs/app design docs/game-concept.md`
   - `docs/app design docs/game-architecture.md`
   - `docs/app design docs/game-pillars.md`
   - Any relevant ADRs in `docs/app design docs/adr-*.md`

2. **Read the active milestone tracker** (e.g. `docs/production/m1-completion.md`) to confirm where this feature sits in the milestone, what it depends on, and which sibling features are already shipped or active.

3. **Scan existing feature plans** in `docs/production/features/` to avoid duplication and to match the established plan style. If a sibling feature plan covers part of this work, link it instead of restating.

4. **Establish scope and acceptance criteria first.** A feature plan is only useful if it has a verifiable "done" condition. If you can't write the acceptance criteria in one or two sentences, the feature is either too vague (push back to the user) or too large (decompose into sub-plans).

5. **Generate a feature plan** using the template at `.claude/docs/templates/feature-plan.md`, sized to the work — not padded to fit a calendar box.

6. **Write the plan** to `docs/production/features/<feature-name>/implementation-plan.md`. Lazy-scaffold the directory: don't create `features/<feature-name>/` until this plan is the file you're about to put inside it.

7. **Add a row** to the active milestone tracker pointing at the new plan, marking the feature as 🚧 active.

## Rules

- **One plan = one coherent feature or module.** No bundling unrelated work to fill space. If two features have meaningfully different scope, write two plans.
- **No capacity tables, no day estimates, no daily tracking grids.** Day estimates are aspirational fiction for solo dev with no external deadline pressure. Use rough phase-level effort if useful (e.g. `~1 day`, `~half a day`), nothing finer.
- **Sub-plans nest under the feature plan**. If a feature has sub-features worth decomposing, the feature plan lists them as phases or links to nested sub-plans in the same directory.
- **Lifecycle**: when the feature is fully shipped, delete the plan file (and its directory if empty), and tick the corresponding row in the milestone tracker. Don't accumulate "done" plans. If any architectural rationale in the plan is durable, promote it to a GDD or ADR before deleting.
- **Conform to design intent.** Every feature plan must trace back to a feature listed in the milestone tracker (which traces back to `game-concept.md` MVP scope). If the feature isn't in the milestone, escalate: either it's out of scope, or the milestone tracker needs updating first.

## Agent Consultation

Optional, if the feature is non-trivial and crosses domains:
- `lead-programmer` — for code-architecture-shaped features (subsystem boundaries, public APIs)
- `xr-specialist` — for XR-interaction-shaped features (gestures, spatial UI, comfort)
- `unity-technical-artist` — for visual-pipeline-shaped features (shaders, rendering, post-processing)
- `game-designer` — for player-facing-shaped features (mechanics, feel, progression)
