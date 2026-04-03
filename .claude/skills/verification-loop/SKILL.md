---
name: verification-loop
description: "A comprehensive verification system for Unity XR projects."
---

# Verification Loop

A comprehensive verification system for Unity XR projects. Runs a structured checklist against the current work state and reports PASS/FAIL per phase.

## When to Use

- After completing a feature or significant code change
- Before creating a PR
- When you want to ensure quality gates pass
- After refactoring

## Verification Phases

### Phase 1: Build Verification

```bash
# Unity Editor batch mode build check
"${UNITY_PATH}" -batchmode -nographics -projectPath . \
  -executeMethod BuildScript.BuildAll \
  -logFile - -quit 2>&1 | tail -30
```

If build fails, STOP and fix before continuing.
Check for:
- Missing assembly references
- Platform-specific compilation errors (Android vs Standalone)
- UPM package resolution failures

### Phase 2: Compile Check

```bash
# Check Unity Editor log for C# compilation errors
"${UNITY_PATH}" -batchmode -nographics -projectPath . \
  -logFile - -quit 2>&1 | grep -E "(error CS|Error|Failed)"
```

Report all compilation errors. Fix critical ones before continuing.
Common Unity-specific issues:
- Missing `using` directives for XRI namespaces
- Incorrect `#if UNITY_ANDROID` guards
- Assembly definition (.asmdef) dependency issues

### Phase 3: Code Analysis

Static analysis checks:
- **Naming conventions**: `m_` prefix for private fields, `k_` for constants, `s_` for statics
- **SerializeField audit**: Public fields that should be `[SerializeField] private`
- **Missing null checks**: Unchecked `GetComponent<T>()` return values
- **GC allocation patterns**: `new` in Update/FixedUpdate/LateUpdate, string concatenation in hot paths
- **XR safety**: Camera manipulation without user control, hardcoded device paths

```bash
# Grep for common violations
grep -rn "public .* m_" --include="*.cs" Assets/    # m_ fields shouldn't be public
grep -rn "new List\|new Dictionary\|\.ToString()" --include="*.cs" Assets/ | grep -i "update\|fixed\|late"
grep -rn "string +" --include="*.cs" Assets/ | grep -i "update\|fixed\|late"
```

### Phase 4: Test Suite

```bash
# Run Unity Test Framework — EditMode tests
"${UNITY_PATH}" -batchmode -nographics -projectPath . \
  -runTests -testPlatform EditMode \
  -testResults TestResults-EditMode.xml \
  -logFile - -quit

# Run PlayMode tests
"${UNITY_PATH}" -batchmode -nographics -projectPath . \
  -runTests -testPlatform PlayMode \
  -testResults TestResults-PlayMode.xml \
  -logFile - -quit
```

Report:
- EditMode tests: X passed / Y failed
- PlayMode tests: X passed / Y failed
- Coverage: X% (target: 80% for core logic)

### Phase 5: XR Performance Gate

Hard limits — these are non-negotiable:

| Metric | XR Glasses | PC Streaming |
|--------|-----------|--------------|
| Frame time | < 11ms (90Hz) | < 11ms (90Hz) |
| Draw calls | < 100 | < 300 |
| GC Alloc/frame | 0 bytes | 0 bytes |
| Triangles/frame | < 200K | < 750K |

Check:
- Run `/xr-perf-profile` for detailed analysis
- Grep for GC-allocating patterns in Update loops
- Count SetPass calls in changed shaders
- Verify Single Pass Instanced rendering is not broken

### Phase 6: Diff Review

```bash
# Show what changed
git diff --stat
git diff HEAD~1 --name-only
```

Review each changed file for:
- Unintended changes
- Missing `.meta` files for new assets (every Unity asset needs one)
- Orphaned `.meta` files for deleted assets
- Missing error handling
- Potential edge cases
- SDK public API changes (breaking changes need ADR)

## Output Format

After running all phases, produce a verification report:

```
VERIFICATION REPORT
==================

Build:       [PASS/FAIL]
Compile:     [PASS/FAIL] (X errors)
Analysis:    [PASS/FAIL] (X violations)
Tests:       [PASS/FAIL] (EditMode: X/Y, PlayMode: X/Y, Z% coverage)
XR Perf:     [PASS/FAIL] (frame: Xms, draws: Y, GC: Z bytes)
Diff:        [X files changed, Y .meta files]

Overall:     [READY/NOT READY] for PR

Issues to Fix:
1. ...
2. ...
```

## Continuous Mode

For long sessions, run verification after major changes:

```markdown
Set a mental checkpoint:
- After completing each MonoBehaviour
- After finishing a system (input, locomotion, UI)
- Before moving to next feature

Run: /verify
```

## Integration with Other Skills

- `/code-review` — Detailed code quality review (Phase 3 deep dive)
- `/xr-perf-profile` — Full XR performance profiling (Phase 5 deep dive)
- `/xr-test` — XR-specific test generation
- `/build-platform validate` — Platform-specific build validation
- `/checkpoint` — Save a known-good state before continuing
