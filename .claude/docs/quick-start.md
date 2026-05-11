# Quick Start Guide

## What Is This?

A pre-built Claude Code workflow for Unity XR development. 14 specialist agents,
14 slash commands, 21 auto-loaded rules, and 10 lifecycle hooks — all tuned for
XR applications targeting XR glasses and PC streaming.

## How to Use

### 1. Understand the Hierarchy

Two tiers of agents, plus the user at the top:

- **Director (Opus)**: `technical-director` — architecture and technology decisions
- **Leads (Sonnet)**: `lead-programmer`, `xr-specialist`, `qa-lead`
- **Specialists (Sonnet/Haiku)**: XR, Unity engine, programming, design

Scheduling, scope, and release are owned by the user, not an agent.

### 2. Pick the Right Agent

| I need to... | Use this agent |
|-------------|---------------|
| Design XR interaction architecture | `xr-specialist` |
| Implement an XR feature | `gameplay-programmer` |
| Review code quality | `lead-programmer` |
| Write a shader for XR | `unity-technical-artist` |
| Fix a performance problem | `performance-analyst` |
| Write test cases | `qa-lead` |
| Make an architecture decision | `technical-director` |
| Work with XRI components | `unity-xri-specialist` |
| Review rendering/VFX | `unity-technical-artist` |
| Design game mechanics | `game-designer` |

### 3. Use Slash Commands

| Command | What it does |
|---------|-------------|
| `/start-harness` | Discover project, ensure CLAUDE.md compliance, route workflow |
| `/plan` | Create implementation plan (waits for confirmation) |
| `/code-review` | Review code for quality and architecture |
| `/xr-test` | Generate XR interaction and comfort tests |
| `/xr-perf-profile` | XR frame budget analysis |
| `/build-platform` | Validate build settings for glasses or PC streaming |
| `/feature-plan` | Draft a feature plan in `docs/production/features/` |
| `/architecture-decision` | Create an ADR |
| `/bug-report` | Create structured bug report |
| `/milestone-gate` | Phase readiness check |

See `skills-reference.md` for the full list of 14 commands.

### 4. Follow the Coordination Rules

1. Work flows down the hierarchy: Director → Leads → Specialists
2. Conflicts escalate up the hierarchy
3. Cross-system work is coordinated by the user
4. Agents do not modify files outside their domain without delegation
5. All decisions are documented

## First Steps

**Don't know where to begin?** Run `/start-harness`. It discovers your project,
ensures CLAUDE.md is harness-compliant, and routes you to the right workflow.

### Path A: Starting a New XR Feature

1. Run `/plan [feature description]` — creates implementation plan
2. Confirm the plan
3. Implement with TDD (write tests first, then code)
4. Run `/code-review` on your changes
5. Run `/xr-perf-profile` to verify frame budget
6. Run `/build-platform validate` to check platform settings

### Path B: Existing Project, First Time Using This Workflow

1. Run `/start-harness` or `/project-stage-detect` — analyzes what exists
2. Run `/milestone-gate` to validate phase readiness
3. Run `/feature-plan` to plan the next feature in the active milestone

### Path C: Bug Fix

1. Run `/bug-report [description]` to create structured report
2. Use `lead-programmer` to identify root cause
3. Fix with TDD approach
4. Run `/code-review` on the fix

## File Structure

```
CLAUDE.md                           — Project instructions (~100 lines)
.claude/
  settings.json                     — Permissions, hooks, safety rules
  agents/                           — 14 agent definitions
  skills/                           — 14 slash command definitions
  rules/
    common/                         — 15 rules (always active)
    csharp/                         — 6 rules (active for *.cs files)
  hooks/                            — 10 lifecycle scripts
  docs/                             — references and guides
```
