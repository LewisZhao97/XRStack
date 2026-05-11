# Agent Coordination and Delegation Map

## Organizational Hierarchy

```
                        [Human Developer]
                              |
                      technical-director
                              |
         lead-programmer ─── xr-specialist ─── qa-lead
                |                  |
     +----------+----------+       |
     |    |    |    |    |         |
    gp   tl   ui  uta  perf        |
                                   |
                     +-------------+-------------+
                     |      |      |
                    xri   openxr  plat
                                  unity
                                    |
                                  uta (delegate)

  Additional agents:
    game-designer  — Mechanics, progression, player experience
```

### Legend
```
gp     = gameplay-programmer     xri    = unity-xri-specialist
tl     = tools-programmer        openxr = openxr-runtime-specialist
ui     = ui-programmer           plat   = platform-specialist
uta    = unity-technical-artist  unity  = unity-specialist
perf   = performance-analyst
```

## Delegation Rules

### Who Can Delegate to Whom

| From | Can Delegate To |
|------|----------------|
| technical-director | lead-programmer, xr-specialist, performance-analyst |
| lead-programmer | gameplay-programmer, tools-programmer, ui-programmer, unity-technical-artist |
| xr-specialist | unity-xri-specialist, openxr-runtime-specialist, platform-specialist |
| unity-specialist | unity-technical-artist |

### Escalation Paths

| Situation | Escalate To |
|-----------|------------|
| Code architecture disagreement | technical-director |
| Cross-system code conflict | lead-programmer, then technical-director |
| XR interaction design conflict | xr-specialist |
| Performance budget violation | performance-analyst flags, technical-director decides |
| Schedule / scope conflict | the user |
| Quality gate disagreement | qa-lead, then technical-director |

## Common Workflow Patterns

### Pattern 1: New XR Feature

```
1. user / technical-director — Identifies the feature, runs /feature-plan
2. xr-specialist             — Reviews XR constraints (platform, input, comfort)
3. lead-programmer           — Designs code architecture
4. [specialist]              — Implements the feature
5. lead-programmer           — Code review (/code-review)
6. qa-lead                   — Writes test cases, executes tests
7. performance-analyst       — Verifies frame budget
```

### Pattern 2: Bug Fix

```
1. qa-lead             — Files bug report with /bug-report, triages
2. lead-programmer     — Identifies root cause, assigns to programmer
3. [specialist]        — Fixes the bug
4. lead-programmer     — Code review
5. qa-lead             — Verifies fix and runs regression
```

### Pattern 3: Feature Cycle

```
1. user                — Plans the next feature with /feature-plan
2. [Specialist agents] — Execute the feature plan's phases
3. qa-lead             — Continuous testing as phases land
4. lead-programmer     — Continuous code review as phases land
5. user                — Milestone readiness check with /milestone-gate
```

### Pattern 4: Release Pipeline

```
1. user                — Declares release candidate, cuts release branch
2. qa-lead             — Full regression, signs off on quality
3. performance-analyst — Confirms performance within budgets
4. user                — Builds release artifacts, tags release
5. technical-director  — Final sign-off
```

## Anti-Patterns to Avoid

1. **Bypassing the hierarchy**: A specialist should never make decisions that belong to their lead without consultation.
2. **Cross-domain implementation**: An agent should never modify files outside their area without explicit delegation.
3. **Shadow decisions**: All decisions must be documented.
4. **Assumption-based implementation**: If a spec is ambiguous, ask rather than guess.
