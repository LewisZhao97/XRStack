# Agent Coordination and Delegation Map

## Organizational Hierarchy

```
                        [Human Developer]
                              |
                +-------------+-------------+
                |                           |
        technical-director              producer
                |                    (coordinates all)
                |
         lead-programmer ─── xr-specialist ─── qa-lead
                |                  |               |
     +----------+----------+      |               |
     |    |    |    |    |  |     |               |
    gp   net  tl   ui   ta perf  |             qa-t
                                  |
                    +-------------+-------------+
                    |      |      |      |      |
                  xri   openxr  plat   sdk   unity
                                              |
                                    +---------+---------+
                                    |    |    |    |    |
                                  dots shader addr  ui-s

  Additional leads (report to producer / technical-director):
    release-manager         — Release pipeline, versioning, deployment
    localization-lead       — i18n, string tables, translation pipeline
    prototyper              — Rapid throwaway prototypes, concept validation
    security-engineer       — Security, data privacy, network security
    accessibility-specialist — XR comfort, seated mode, visual aids
    devops-engineer         — CI/CD, build pipelines, automation
    analytics-engineer      — Telemetry, data analysis
    ux-designer             — User flows, interaction design
```

### Legend
```
gp   = gameplay-programmer     xri   = unity-xri-specialist
net  = network-programmer      openxr = openxr-runtime-specialist
tl   = tools-programmer        plat  = platform-specialist
ui   = ui-programmer           sdk   = sdk-developer
ta   = technical-artist        unity = unity-specialist
perf = performance-analyst     dots  = unity-dots-specialist
qa-t = qa-tester               shader = unity-shader-specialist
                               addr  = unity-addressables-specialist
                               ui-s  = unity-ui-specialist
```

## Delegation Rules

### Who Can Delegate to Whom

| From | Can Delegate To |
|------|----------------|
| technical-director | lead-programmer, xr-specialist, devops-engineer, performance-analyst |
| producer | Any agent (task assignment within their domain only) |
| lead-programmer | gameplay-programmer, network-programmer, tools-programmer, ui-programmer, technical-artist |
| xr-specialist | unity-xri-specialist, openxr-runtime-specialist, platform-specialist, sdk-developer |
| qa-lead | qa-tester |
| unity-specialist | unity-dots-specialist, unity-shader-specialist, unity-addressables-specialist, unity-ui-specialist |
| release-manager | devops-engineer (release builds), qa-lead (release testing) |
| security-engineer | network-programmer (security review), lead-programmer (secure patterns) |
| accessibility-specialist | ux-designer (accessible patterns), ui-programmer (implementation) |

### Escalation Paths

| Situation | Escalate To |
|-----------|------------|
| Code architecture disagreement | technical-director |
| Cross-system code conflict | lead-programmer, then technical-director |
| XR interaction design conflict | xr-specialist |
| SDK public API change | sdk-developer + technical-director |
| Performance budget violation | performance-analyst flags, technical-director decides |
| Schedule conflict | producer |
| Scope exceeds capacity | producer, then technical-director for cuts |
| Quality gate disagreement | qa-lead, then technical-director |

## Common Workflow Patterns

### Pattern 1: New XR Feature

```
1. producer            — Schedules work, identifies dependencies
2. xr-specialist       — Reviews XR constraints (platform, input, comfort)
3. lead-programmer     — Designs code architecture
4. [specialist]        — Implements the feature
5. lead-programmer     — Code review
6. qa-tester           — Writes test cases, executes tests
7. performance-analyst — Verifies frame budget
8. producer            — Marks task complete
```

### Pattern 2: SDK API Change

```
1. sdk-developer       — Proposes API design
2. technical-director  — Reviews architecture impact
3. lead-programmer     — Reviews integration with app layer
4. sdk-developer       — Implements the change
5. lead-programmer     — Code review
6. qa-tester           — SDK test coverage
7. release-manager     — Version bump (semver)
```

### Pattern 3: Bug Fix

```
1. qa-tester           — Files bug report with /bug-report
2. qa-lead             — Triages severity and priority
3. lead-programmer     — Identifies root cause, assigns to programmer
4. [specialist]        — Fixes the bug
5. lead-programmer     — Code review
6. qa-tester           — Verifies fix and runs regression
```

### Pattern 4: Sprint Cycle

```
1. producer            — Plans sprint with /sprint-plan
2. [All agents]        — Execute assigned tasks
3. qa-lead             — Continuous testing during sprint
4. lead-programmer     — Continuous code review during sprint
5. producer            — Sprint retrospective with /retrospective
```

### Pattern 5: Release Pipeline

```
1. producer            — Declares release candidate
2. release-manager     — Cuts release branch, prepares release artifacts
3. qa-lead             — Full regression, signs off on quality
4. performance-analyst — Confirms performance within budgets
5. devops-engineer     — Builds release artifacts
6. release-manager     — Tags release, generates /changelog
7. technical-director  — Final sign-off
```

### Pattern 6: Rapid Prototype

```
1. producer            — Defines hypothesis and success criteria
2. prototyper          — Scaffolds prototype with /prototype
3. prototyper          — Builds minimal implementation
4. xr-specialist       — Evaluates XR feasibility
5. technical-director  — Go/no-go decision on production
```

## Anti-Patterns to Avoid

1. **Bypassing the hierarchy**: A specialist should never make decisions that belong to their lead without consultation.
2. **Cross-domain implementation**: An agent should never modify files outside their area without explicit delegation.
3. **Shadow decisions**: All decisions must be documented. Undocumented agreements lead to contradictions.
4. **Monolithic tasks**: Every task should be completable in 1-3 days. Break down larger work first.
5. **Assumption-based implementation**: If a spec is ambiguous, ask rather than guess.
