# Path-Specific Rules

Rules in `.claude/rules/` are automatically loaded when editing files in matching paths.

## Common Rules (19) — Always Active

| Rule File | Enforces |
|-----------|----------|
| `coding-style.md` | Unity naming (`m_`, `k_`, `s_`), Allman braces, formatting |
| `xr-development.md` | XR frame budgets, draw calls, comfort, interaction patterns |
| `git-workflow.md` | Commit message format, PR workflow |
| `code-review.md` | Review checklist, severity levels, approval criteria |
| `development-workflow.md` | Feature implementation pipeline (research, plan, TDD, review) |
| `testing.md` | TDD workflow, 80% coverage requirement |
| `test-standards.md` | Test naming (`[Method]_[Scenario]_[Expected]`), AAA pattern |
| `security.md` | Secret management, input validation, OWASP |
| `performance.md` | Model selection, context window management |
| `patterns.md` | ScriptableObject events, service locator, state machine |
| `agents.md` | Agent orchestration and delegation rules |
| `hooks.md` | Hook types and best practices |
| `engine-code.md` | Core/SDK code: zero allocs in hot paths, thread safety |
| `gameplay-code.md` | Feature code: data-driven values, delta time, no UI coupling |
| `network-code.md` | Networking: server-authoritative, versioned messages |
| `ui-code.md` | Spatial UI: no game state ownership, localization-ready |
| `shader-code.md` | Shader naming, precision, XR stereo rendering |
| `data-files.md` | JSON validity, naming conventions, schema rules |
| `prototype-code.md` | Relaxed standards for prototype code |

## C# Rules (6) — Active for `*.cs` / `*.csx` Files

| Rule File | Enforces |
|-----------|----------|
| `coding-style.md` | Unity C# conventions, ScriptableObjects, async patterns |
| `unity-xr.md` | XRI component patterns, XROrigin usage, common XR pitfalls |
| `patterns.md` | ScriptableObject config, event channels, SDK `Result<T>` |
| `testing.md` | Unity Test Framework, `XRDeviceSimulator`, Play/Edit mode |
| `security.md` | XR input validation, network security |
| `hooks.md` | `dotnet format`, build verification |
