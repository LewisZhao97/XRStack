---
name: milestone-gate
description: "Evaluate milestone or phase readiness. Checks required artifacts, quality gates, and open work, then produces a PASS / CONCERNS / FAIL verdict with blockers and next actions."
argument-hint: "[target: concept | systems-design | technical-setup | pre-production | production | polish | release | current]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write
---

# Milestone Gate

Combines phase-gate validation and milestone review into one verdict: *are we ready to advance?*

## 1. Determine Target

- **With argument**: validate the named phase transition.
- **No argument / `current`**: auto-detect stage (same heuristics as `/project-stage-detect`) and check readiness for the next phase.

## 2. Phase Gates

| From → To | Required Artifacts | Quality Checks |
|---|---|---|
| Concept → Systems Design | `game-concept.md`, game pillars | Design-review PASS, core loop + audience defined |
| Systems Design → Technical Setup | `systems-index.md`, ≥1 GDD | GDDs have 8 required sections, dependencies mapped |
| Technical Setup → Pre-Production | Engine config, ≥1 ADR, tech-preferences populated | ADRs cover rendering/input/state, budgets set |
| Pre-Production → Production | ≥1 prototype, first sprint plan, MVP GDDs complete | Core-loop hypothesis validated, vertical slice scoped |
| Production → Polish | Core mechanics implemented, playable end-to-end, tests exist | Tests passing, no critical bugs, perf within budget |
| Polish → Release | All features done, localized, QA plan, release checklist run | QA sign-off, all tests pass, no critical/high bugs, legal done |

## 3. Run the Check

- **Artifacts**: Glob + Read. Confirm real content, not template stubs.
- **Tests**: run via Bash when a runner is configured.
- **Code vs design**: cross-reference `docs/app design docs/` against `Assets/Scripts/`.
- **Open work**: Grep for TODO/FIXME/HACK; count S1/S2 bugs if a tracker is present.
- **Unverifiable items**: ask the user; never assume PASS.

## 4. Output

```markdown
## Milestone Gate: [From] → [To]

**Artifacts**: X/Y present
**Quality**: X/Y passing
**Open work**: N TODO · N FIXME · N S1 bugs

### Blockers
1. [Item] — [fix suggestion]

### Concerns
- [Non-blocking gap]

### Verdict: PASS | CONCERNS | FAIL
**Rationale**: [1–2 sentences]

### Next Actions
- [Priority action → command/agent]
```

## 5. On PASS

Ask before advancing. If confirmed, write the new stage to `docs/production/stage.txt` (single line, no newline):

```bash
echo -n "Production" > docs/production/stage.txt
```

## Principles

- The verdict is **advisory** — the user makes the final call.
- Never block advancement silently; document risks instead.
- Prefer specific blockers ("3 failing tests in tests/unit/") over vague ones ("tests incomplete").
