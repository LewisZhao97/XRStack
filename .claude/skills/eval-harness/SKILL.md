---
name: eval-harness
description: Formal evaluation framework for Unity XR projects implementing eval-driven development (EDD) principles
tools: Read, Write, Edit, Bash, Grep, Glob
---

# Eval Harness

A formal evaluation framework for Unity XR projects, implementing eval-driven development (EDD) principles.

## When to Activate

- Setting up eval-driven development (EDD) for XR features
- Defining pass/fail criteria for task completion
- Measuring agent reliability with pass@k metrics
- Creating regression test suites for XR interaction changes
- Benchmarking agent performance across model versions

## Philosophy

Eval-Driven Development treats evals as the "unit tests of AI development":
- Define expected behavior BEFORE implementation
- Run evals continuously during development
- Track regressions with each change
- Use pass@k metrics for reliability measurement

## Eval Types

### Capability Evals
Test if Claude can implement an XR feature correctly:
```markdown
[CAPABILITY EVAL: hand-tracking-grab]
Task: Implement XR hand tracking grab interaction using XRI
Success Criteria:
  - [ ] XRGrabInteractable responds to pinch gesture
  - [ ] Object follows hand pose while grabbed
  - [ ] Release on pinch release, no jitter
  - [ ] Zero GC allocations in grab loop
Expected Output: Working grab interaction in PlayMode
```

### Regression Evals
Ensure changes don't break existing XR functionality:
```markdown
[REGRESSION EVAL: locomotion-system]
Baseline: SHA or checkpoint name
Tests:
  - teleport-interaction: PASS/FAIL
  - snap-turn: PASS/FAIL
  - continuous-move: PASS/FAIL
  - comfort-vignette: PASS/FAIL
Result: X/Y passed (previously Y/Y)
```

## Grader Types

### 1. Code-Based Grader
Deterministic checks using Unity Editor:
```bash
# Check if C# compiles
"${UNITY_PATH}" -batchmode -nographics -projectPath . -logFile - -quit 2>&1 | grep -c "error CS" && echo "FAIL" || echo "PASS"

# Check if tests pass
"${UNITY_PATH}" -batchmode -nographics -projectPath . -runTests -testPlatform EditMode -logFile - -quit && echo "PASS" || echo "FAIL"

# Check for GC allocations in hot paths
grep -rn "new \|\.ToString()\|string +" --include="*.cs" Assets/ | grep -ci "update\|fixedupdate" && echo "FAIL: GC in hot path" || echo "PASS"
```

### 2. Model-Based Grader
Use Claude to evaluate open-ended outputs:
```markdown
[MODEL GRADER PROMPT]
Evaluate the following Unity XR code change:
1. Does it follow Unity naming conventions (m_, k_, s_)?
2. Is it XR-safe (no programmatic camera movement)?
3. Are input bindings via OpenXR actions (not hardcoded)?
4. Is performance within budget (no GC in Update)?

Score: 1-5 (1=poor, 5=excellent)
Reasoning: [explanation]
```

### 3. Human Grader
Flag for manual XR testing on device:
```markdown
[HUMAN REVIEW REQUIRED]
Change: Added snap-turn locomotion provider
Reason: Motion comfort requires on-device testing
Risk Level: HIGH — motion sickness potential
Test on: XR glasses headset with real head tracking
```

## Metrics

### pass@k
"At least one success in k attempts"
- pass@1: First attempt success rate
- pass@3: Success within 3 attempts
- Typical target: pass@3 > 90%

### pass^k
"All k trials succeed"
- Higher bar for reliability
- pass^3: 3 consecutive successes
- Use for critical XR interactions (grab, locomotion, UI)

## Eval Workflow

### 1. Define (Before Coding)
```markdown
## EVAL DEFINITION: hand-tracking-support

### Capability Evals
1. Can detect hand tracking subsystem availability
2. Can map pinch gesture to XRI select action
3. Can provide visual hand mesh feedback
4. Zero GC allocations in tracking update loop

### Regression Evals
1. Controller input still works when hands not tracked
2. Existing grab interactions unchanged
3. UI interaction via ray still functional

### Success Metrics
- pass@3 > 90% for capability evals
- pass^3 = 100% for regression evals
```

### 2. Implement
Write code to pass the defined evals.

### 3. Evaluate
```
/eval check hand-tracking-support
```

### 4. Report
```markdown
EVAL REPORT: hand-tracking-support
===================================

Capability Evals:
  detect-subsystem:    PASS (pass@1)
  pinch-to-select:     PASS (pass@2)
  hand-mesh-feedback:  PASS (pass@1)
  zero-gc-tracking:    PASS (pass@1)
  Overall:             4/4 passed

Regression Evals:
  controller-input:    PASS
  grab-interactions:   PASS
  ui-ray-interaction:  PASS
  Overall:             3/3 passed

Metrics:
  pass@1: 75% (3/4)
  pass@3: 100% (4/4)

Status: READY FOR DEVICE TESTING
```

## Eval Storage

Store evals in project:
```
.claude/
  evals/
    hand-tracking-support.md     # Eval definition
    hand-tracking-support.log    # Eval run history
    baseline.json                # Regression baselines
```

## Best Practices

1. **Define evals BEFORE coding** — Forces clear thinking about XR success criteria
2. **Run evals frequently** — Catch regressions early
3. **Track pass@k over time** — Monitor reliability trends
4. **Use code graders when possible** — Deterministic > probabilistic
5. **Human review for comfort** — Never fully automate motion sickness checks
6. **Keep evals fast** — Slow evals don't get run
7. **Version evals with code** — Evals are first-class artifacts

## Eval Anti-Patterns

- Overfitting prompts to known eval examples
- Measuring only happy-path outputs
- Ignoring frame budget while chasing pass rates
- Allowing flaky graders in release gates
- Skipping on-device testing for comfort-critical features

## Integration

- `/verify` — Run verification loop (includes eval checks)
- `/xr-test` — Generate XR-specific test cases
- `/checkpoint` — Save known-good state as eval baseline
- `/gate-check` — Phase gate validation using eval results
