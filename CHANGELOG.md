# Changelog

All notable changes to XRStack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2026-05-11

### Changed

- **Trimmed agent roster from 18 → 14**: removed `producer` and `sdk-developer`. Scheduling, scope, and release coordination are now owned by the user, supported by `/feature-plan` and `/milestone-gate`.
- **Trimmed skill set from 24 → 14**: removed `/sprint-plan`, `/prototype`, `/team-ui`, `/verify` (verification-loop), `/eval` (eval-harness), `/checkpoint`, `/save-session`, `/sessions`, `/learn-eval`, `/instinct-status`, `/evolve`. The continuous-learning and session-state pipelines never carried their weight.
- **Replaced `/sprint-plan` with `/feature-plan`**: one plan per coherent feature, sized to the work rather than to a calendar. Lifecycle is delete-on-ship, with durable rationale promoted to GDDs/ADRs.
- **`/code-review` exports**: now offers a dated export to `docs/production/code-reviews/` with collision handling and a `## Resolution` tracking section.
- **`/start-harness` redesigned**: prints a visible discovery checklist instead of silent gathering; detects the SDK package by shape (`file:` manifest entries + native binaries), not by hardcoded name.
- **`/brainstorm` Phase 0**: new XR Device Discovery phase produces an XR Envelope that hard-filters concept generation. Adds "Why XR?" / flat-screen survival test in Phase 2, device-specific session profiles in Phase 3, XR-specific risk categories in Phase 6.
- **Merged `technical-artist` + `unity-shader-specialist` → `unity-technical-artist`** with added ShaderLab/HLSL, compute shaders, URP render features, and post-processing duties.

### Added

- **`xr-constraints.md` template** capturing device class, input fidelity, performance budget, comfort rules, and display-driven art direction. Generated as a 4th document by `/brainstorm`. Includes a typical-values appendix for AR / passthrough MR / immersive VR.
- **`feature-plan.md` template** with goal, why-now, in-vs-out scope, architecture, phase-level effort, and acceptance criteria.
- **`code-review-hint.sh` hook**: PreToolUse on `git commit`; advisory reminder to run `/code-review` when staged `.cs` files are about to land.
- **`milestone-gate-hint.sh` hook**: PostToolUse on milestone tracker writes; suggests `/milestone-gate` when no ⏳/🚧 rows remain and the verdict is still TBD.

### Removed

- Agents: `producer`, `sdk-developer`, `security-engineer`, `technical-artist`, `unity-shader-specialist`.
- Skills: `/sprint-plan`, `/prototype`, `/team-ui`, `/verify`, `/eval`, `/checkpoint`, `/save-session`, `/sessions`, `/learn-eval`, `/instinct-status`, `/evolve`.
- Rules: `security.md` (common), `data-files.md`, `network-code.md`, `prototype-code.md`.
- Templates: `sprint-plan.md`, `milestone-definition.md`.

### Fixed

- Template paths now match Unity project structure: `Assets/Scripts/`, `Assets/Tests/`, `Assets/Prototypes/`, `docs/app design docs/`, `Packages/com.yourcompany.xr.sdk/` (replaces generic `design/`, `src/`, `tests/`, `prototypes/`).
- `systems-index.md` categories rewritten for XR: removed Economy and Narrative; added Interaction; renamed UI → Spatial UI.
- All stale skill/agent/rule references cleaned across docs, agent definitions, templates, `CLAUDE.md`, `README.md`, and `.mcp.json`.

[0.0.2]: https://github.com/LewisZhao97/XRStack/releases/tag/v0.0.2

## [0.0.1] - 2026-04-05

### Added

- **30 specialist agents** organized in 3 tiers (Directors, Leads, Specialists)
  - 5 XR-specific: `xr-specialist`, `unity-xri-specialist`, `openxr-runtime-specialist`, `platform-specialist`, `sdk-developer`
  - 5 Unity core: `unity-specialist`, `unity-shader-specialist`, `unity-ui-specialist`, `unity-dots-specialist`, `unity-addressables-specialist`
  - 11 development: `lead-programmer`, `gameplay-programmer`, `technical-director`, `performance-analyst`, `technical-artist`, `tools-programmer`, `ui-programmer`, `network-programmer`, `devops-engineer`, `prototyper`, `game-designer`
  - 9 quality/release/support: `qa-lead`, `qa-tester`, `security-engineer`, `accessibility-specialist`, `release-manager`, `producer`, `analytics-engineer`, `localization-lead`, `ux-designer`

- **43 slash commands** across 8 categories
  - XR-specific: `/xr-test`, `/build-platform`, `/xr-perf-profile`
  - Development: `/plan`, `/code-review`, `/perf-profile`, `/architecture-decision`, `/prototype`, `/reverse-document`, `/bug-report`, `/design-review`, `/brainstorm`
  - Production: `/sprint-plan`, `/estimate`, `/scope-check`, `/milestone-review`, `/gate-check`, `/retrospective`, `/changelog`
  - Quality & release: `/tech-debt`, `/asset-audit`, `/release-checklist`, `/hotfix`, `/localize`
  - Verification: `/verify`, `/eval`, `/checkpoint`
  - Continuous learning: `/learn-eval`, `/instinct-status`, `/evolve`, `/prune`, `/instinct-import`, `/instinct-export`, `/skill-create`
  - Session management: `/save-session`, `/sessions`, `/strategic-compact`
  - Onboarding: `/start-harness`, `/onboard`, `/team-ui`, `/team-release`, `/project-stage-detect`

- **25 auto-loaded rules**
  - 19 common rules (always active): coding style, XR development, git workflow, code review, testing, security, patterns, performance, and more
  - 6 C# rules (active for `*.cs` files): Unity conventions, XRI patterns, ScriptableObject patterns, Unity Test Framework, security, hooks

- **8 lifecycle hooks + 2 optional learning hooks**
  - Core: `session-start`, `detect-gaps`, `validate-commit`, `validate-push`, `validate-assets`, `pre-compact`, `session-stop`, `log-agent`
  - Optional: `observe` (tool use capture), `suggest-compact` (phase transition detection)

- **18 document templates** for ADRs, GDDs, sprint plans, release checklists, and more

- **3 Node.js session management scripts** for state persistence and retrieval

- **Claude Code plugin format** (`.claude-plugin/plugin.json` + `marketplace.json`) for distribution

- **CLAUDE.md template** with Unity XR project instructions, XR constraints, naming conventions, and workflow guidance

- **settings.json** with permissions, hook wiring, and safety deny-list

[0.0.1]: https://github.com/LewisZhao97/XRStack/releases/tag/v0.0.1
