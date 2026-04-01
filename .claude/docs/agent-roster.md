# Agent Roster

29 specialist agents organized into three tiers. Each has a definition file in `.claude/agents/`.

## Tier 1 — Directors (Opus)

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `technical-director` | Technical vision | Architecture decisions, technology choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

## Tier 2 — Leads (Sonnet)

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `lead-programmer` | Code architecture | System design, code review, API design, refactoring |
| `xr-specialist` | XR authority | XR interaction, tracking, spatial UI, cross-platform XR |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness |
| `release-manager` | Release pipeline | Versioning, certification, deployment |

## Tier 3 — Specialists (Sonnet / Haiku)

### XR Specialists

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `unity-xri-specialist` | XR Interaction Toolkit | XRI components, interactors, locomotion |
| `openxr-runtime-specialist` | OpenXR runtime/SDK | Runtime layer, OpenXR compliance, API layers |
| `platform-specialist` | Platform builds | XR glasses and PC streaming deployment |
| `sdk-developer` | SDK architecture | Public API design, versioning, UPM packaging |

### Unity Engine Specialists

| Agent | Subsystem | When to Use |
|-------|-----------|-------------|
| `unity-specialist` | Unity Engine (lead) | Unity APIs, project config, MonoBehaviour vs DOTS |
| `unity-dots-specialist` | DOTS/ECS | Entity Component System, Jobs, Burst compiler |
| `unity-shader-specialist` | Shaders/VFX | Shader Graph, VFX Graph, URP customization |
| `unity-addressables-specialist` | Asset management | Addressable groups, async loading, memory |
| `unity-ui-specialist` | UI systems | UI Toolkit, UGUI, data binding |

### Programming Specialists

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `gameplay-programmer` | Feature code | XR interaction systems, application logic |
| `network-programmer` | Networking | Multiplayer, state sync, lag compensation |
| `tools-programmer` | Dev tools | Editor extensions, pipeline automation |
| `ui-programmer` | UI implementation | Spatial UI, world-space canvas |
| `technical-artist` | Tech art | Shaders, VFX, rendering optimization |

### Quality & Support

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `qa-tester` | Test execution | Test cases, bug reports, regression checklists |
| `performance-analyst` | Performance | Profiling, frame budget analysis, optimization |
| `security-engineer` | Security | Anti-cheat, data privacy, network security |
| `accessibility-specialist` | Accessibility | Comfort settings, seated mode, visual aids |
| `devops-engineer` | Build/deploy | CI/CD, build pipelines, automation |
| `analytics-engineer` | Telemetry | Event tracking, dashboards, A/B test design |
| `localization-lead` | i18n | String management, translation pipeline |
| `ux-designer` | UX flows | User flows, interaction design, accessibility |
| `prototyper` | Rapid prototyping | Throwaway prototypes, concept validation |
