# Unity XR Studio — Project Instructions

## Project Overview

This is a **Unity XR development** project for a **self-developed XR glasses product**.

| Component | Details |
|-----------|---------|
| **Engine** | Unity 6.0.27f1 |
| **Language** | C# (Unity app), C++/Java (native runtime) |
| **XR Framework** | XR Interaction Toolkit (XRI) |
| **XR Runtime** | OpenXR (self-developed, native C++/Java → `.aar`) |
| **SDK** | Self-developed XR SDK (UPM package) |
| **Platforms** | Self-developed XR glasses (standalone), PC streaming to glasses |
| **Render Pipeline** | URP (Universal Render Pipeline) |
| **Rendering** | Single Pass Instanced (mandatory for XR) |

## Critical XR Constraints

- **Frame budget**: 11ms at 90Hz, 8.3ms at 120Hz — XR frame drops cause nausea
- **Draw calls**: < 100 — mobile XR GPU budget is tight
- **GC allocations in hot paths**: ZERO tolerance — use pools, NonAlloc APIs, NativeArray
- **Never move camera programmatically** without user control (motion sickness)
- **Always support both controllers AND hand tracking**
- **All input via OpenXR action bindings** — never hardcode device-specific paths

## Project Structure

```
Packages/
└── com.yourcompany.xr.sdk/      # XR SDK (installed in manifest.json or UPM)
    ├── package.json
    ├── Runtime/                 # SDK C# scripts (public API, subsystem wrappers)
    │   └── Android/             # Runtime
    ├── Editor/                  # SDK editor tools
    └── Tests/                   # SDK package tests

Assets/
├── Scripts/
│   ├── Core/                    # Core framework, shared utilities
│   ├── XR/                      # XR interaction and tracking systems
│   ├── Interaction/             # User interaction logic
│   ├── UI/                      # Spatial UI components
│   ├── Networking/              # Multiplayer (if applicable)
│   └── Gameplay/                # Application-specific features
├── Shaders/                     # Custom shaders (URP, XR-compatible)
├── Prefabs/                     # Reusable prefabs
├── Data/                        # Configuration data (ScriptableObjects, JSON)
├── Tests/                       # Unity Test Framework tests
│   ├── EditMode/                # Pure logic tests
│   └── PlayMode/                # MonoBehaviour and XR tests
└── Prototypes/                  # Isolated prototype experiments
```

> **Architecture note:** The SDK is installed as a UPM package, not part of Assets/Scripts.
> The OpenXR runtime is a native C++/Java project compiled into an `.aar` file, stored
> inside the SDK package at `Runtime/Android/`. Unity C# code calls into the runtime
> via the SDK's managed API — never directly.

## Coding Standards

### C# Naming (Unity convention, NOT .NET)

| Element | Convention | Example |
|---------|-----------|---------|
| Classes / Structs | PascalCase | `ARTrackedImageManager` |
| Interfaces | `I` + PascalCase | `IReferenceImageLibrary` |
| Enums & Members | PascalCase | `TrackingState.Tracking` |
| Constants | `k_` + PascalCase | `k_MaxRetries` |
| Static fields | `s_` + PascalCase | `s_Instance` |
| Instance private fields | `m_` + PascalCase | `m_Camera` |
| Public/Protected properties | camelCase | `referenceLibrary` |
| Public/Protected events | camelCase | `trackablesChanged` |
| All methods | PascalCase | `TryGetRenderingParameters()` |
| Parameters & locals | camelCase | `commandBuffer` |

### C# Formatting
- Allman brace style (opening brace on new line)
- 4-space indentation
- `[SerializeField] private` over `public` for inspector fields
- Expression-bodied members for simple accessors (`get => m_Field;`)
- Space after keywords (`if (`, `for (`), no space before method parens (`DoSomething()`)
- Assembly definitions (`.asmdef`) for all code folders
- `readonly` and `const` where applicable

### Unity XR Patterns
- Use `XROrigin` (not deprecated `XRRig`)
- Use `ActionBasedController` (not `DeviceBasedController`)
- ScriptableObjects for data-driven configuration
- Events/UnityEvents for cross-system communication
- `ObjectPool<T>` for frequently instantiated objects
- `Physics.RaycastNonAlloc()`, `OverlapSphereNonAlloc()` — avoid allocating variants

### Forbidden in Hot Paths
- `GetComponent<>()` in Update — cache in Awake
- `Find()`, `FindObjectOfType()`, `SendMessage()`
- String concatenation, LINQ, closures (GC allocation)
- `new List<>()`, `new Dictionary<>()` — pre-allocate and reuse
- `Physics.Raycast()` (allocating variant) — use NonAlloc

## Available Slash Commands

| Command | Purpose |
|---------|---------|
| `/start` | Project onboarding and routing |
| `/plan` | Implementation planning (wait for confirmation) |
| `/code-review` | Architectural and quality code review |
| `/xr-test` | XR-specific test generation and validation |
| `/xr-perf-profile` | XR performance profiling (frame budget) |
| `/build-platform` | Cross-platform build validation |
| `/perf-profile` | General performance profiling |
| `/bug-report` | Structured bug report creation |
| `/architecture-decision` | Architecture Decision Record |
| `/tech-debt` | Technical debt tracking |
| `/asset-audit` | Asset compliance audit |
| `/hotfix` | Emergency fix workflow |
| `/release-checklist` | Pre-release validation |
| `/sprint-plan` | Sprint planning |
| `/prototype` | Rapid prototyping workflow |
| `/reverse-document` | Generate docs from existing code |
| `/onboard` | New contributor onboarding |

## Available Agents

### XR-Specific
- `xr-specialist` — XR interaction, tracking, spatial UI authority
- `unity-xri-specialist` — XR Interaction Toolkit deep implementation
- `openxr-runtime-specialist` — OpenXR runtime and SDK layer
- `platform-specialist` — Build management for glasses and PC streaming
- `sdk-developer` — SDK API design and versioning

### Unity Core
- `unity-specialist` — Unity Engine patterns, APIs, optimization
- `unity-shader-specialist` — Shader Graph, VFX, URP customization
- `unity-ui-specialist` — UI Toolkit, UGUI, data binding
- `unity-dots-specialist` — ECS, Jobs, Burst compiler
- `unity-addressables-specialist` — Asset loading, bundles, memory

### Development
- `lead-programmer` — Code architecture, code review
- `gameplay-programmer` — Feature implementation
- `technical-director` — High-level technical decisions
- `performance-analyst` — Performance profiling
- `technical-artist` — Shaders, VFX, rendering optimization
- `tools-programmer` — Editor extensions, pipeline automation
- `ui-programmer` — Spatial UI, world-space canvas
- `network-programmer` — Multiplayer networking
- `devops-engineer` — CI/CD, build automation

### Quality & Release
- `qa-lead` — Test strategy, quality gates
- `qa-tester` — Test cases, bug reports
- `security-engineer` — Security, anti-cheat
- `accessibility-specialist` — XR accessibility, comfort
- `release-manager` — Platform certification, submission

## Testing Requirements

- **Framework**: Unity Test Framework (NUnit-based)
- **Coverage target**: 80%+ for core logic and SDK public API
- **Edit Mode tests**: Pure logic, no MonoBehaviour dependencies
- **Play Mode tests**: XR interactions via `XRDeviceSimulator`
- **Test naming**: `[MethodUnderTest]_[Scenario]_[ExpectedResult]`

## Git Workflow

- **Commit format**: `<type>: <description>` (feat, fix, refactor, docs, test, chore, perf, ci)
- **Branch strategy**: feature branches from main/develop
- **Pre-commit**: JSON validation, hardcoded value detection, TODO format check

## SDK Development Guidelines

- Public API surface must be minimal and well-documented (XML docs)
- Use Semantic Versioning (MAJOR.MINOR.PATCH)
- `[Obsolete]` with migration message before removing any public API
- UPM-compatible package structure
- `Result<T>` pattern for error handling — never throw from public API
- All native ↔ managed transitions via proper P/Invoke with error handling

## Performance Budgets

| Metric | XR Glasses (standalone) | PC Streaming |
|--------|------------------------|--------------|
| Frame time | 11ms (90Hz) | 11ms (90Hz) |
| Draw calls | < 100 | < 300 |
| Triangles | < 750K | < 2M |
| Texture memory | < 1GB | < 4GB |
| GC Alloc/frame | 0 bytes | 0 bytes |
