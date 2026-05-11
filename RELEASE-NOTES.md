# XRStack v0.0.2 — Trim Pass

A focused trim of the v0.0.1 inventory. Agents, skills, and rules that didn't earn their context budget have been cut. What remains is sharper and matches how the harness is actually used.

## What's In the Box

| Component | Count | Change |
|-----------|-------|--------|
| Specialist agents | 14 | -4 from v0.0.1 |
| Slash commands | 14 | -10 from v0.0.1 |
| Auto-loaded rules | 21 | -4 from v0.0.1 |
| Lifecycle hooks | 10 | +2 from v0.0.1 |
| Document templates | 14 | -4 from v0.0.1 |

## Highlights

**Scheduling is no longer an agent's job.** The `producer` agent is gone. Sprint-style planning is replaced by `/feature-plan` (one plan per coherent feature) plus `/milestone-gate` (PASS / CONCERNS / FAIL verdict). The user owns scheduling, scope, and release coordination.

**`/brainstorm` is now XR-aware.** A new Phase 0 (XR Device Discovery) captures display class, input fidelity, performance budget, and comfort defaults — producing an "XR Envelope" that hard-filters concept generation downstream. A flat-screen survival test in Phase 2 rejects concepts that are flat-screen ideas with a headset gimmick.

**`/start-harness` got honest.** Discovery is now a printed checklist with ticked items, not a silent gather. SDK packages are detected by shape (`file:` manifest entries + native binaries), not by hardcoded name — works with private/confidential SDKs.

**Two new hint hooks.** `code-review-hint.sh` reminds you to run `/code-review` before committing C# changes. `milestone-gate-hint.sh` suggests `/milestone-gate` when a milestone tracker is fully resolved and the verdict is still TBD. Advisory, never blocking.

**Templates rebuilt around Unity paths.** `project-stage-report.md` now references `Assets/Scripts/`, `Assets/Tests/`, `Assets/Prototypes/`, and `docs/app design docs/` instead of the generic `src/` / `design/` / `tests/` layout. `systems-index.md` categories rewritten for XR (Interaction added, Economy and Narrative removed).

**One merged tech-art agent.** `technical-artist` + `unity-shader-specialist` became `unity-technical-artist`, with added ShaderLab/HLSL, compute shaders, URP render features, and post-processing duties.

## Removed

Agents that didn't fit a solo / small-team XR workflow:
- `producer`, `sdk-developer`, `security-engineer`, `technical-artist`, `unity-shader-specialist`

Skills that didn't carry their weight:
- `/sprint-plan` (replaced by `/feature-plan`), `/prototype`, `/team-ui`
- `/verify`, `/eval`, `/checkpoint` (verification & eval pipeline)
- `/save-session`, `/sessions` (session-state pipeline)
- `/learn-eval`, `/instinct-status`, `/evolve` (continuous learning pipeline)

Rules:
- `security.md` (common), `data-files.md`, `network-code.md`, `prototype-code.md`

Templates:
- `sprint-plan.md`, `milestone-definition.md`

## Installation

```bash
# Option A — Plugin (recommended, auto-updates)
/plugin marketplace add LewisZhao97/XRStack
/plugin install xrstack@xrstack

# Option B — Git submodule
git submodule add https://github.com/LewisZhao97/XRStack.git XRStack
# Then symlink .claude/ to XRStack/.claude/

# Option C — Direct copy
cp -r XRStack/.claude YourProject/.claude
cp XRStack/CLAUDE.md YourProject/CLAUDE.md
```

## Requirements

- Claude Code CLI
- Unity 6.x project
- Git, Bash (Git Bash on Windows)
- Optional: Node.js (no longer required since session scripts were removed)

## Upgrading from v0.0.1

If you were using removed skills or agents in your own files:
- `/sprint-plan` → use `/feature-plan` per feature instead
- `producer` agent → user owns scheduling; consult `technical-director` for technical priorities and `qa-lead` for quality
- `sdk-developer` agent → escalate SDK API changes to `lead-programmer` + `technical-director`
- Removed continuous-learning skills → no replacement; the pipeline was cut entirely
