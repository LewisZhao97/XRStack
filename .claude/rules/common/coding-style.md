# Coding Style

## Naming Convention (Unity style)

We follow **Unity's official package conventions** (as used in `com.unity.xr.arfoundation`).

| Element | Convention | Example |
|---------|-----------|---------|
| Classes / Structs | PascalCase | `ARTrackedImageManager` |
| Interfaces | `I` + PascalCase | `IReferenceImageLibrary` |
| Enums & Members | PascalCase | `TrackingState.Tracking` |
| Constants | `k_` + PascalCase | `k_MaxRetries` |
| Static fields (private) | `s_` + PascalCase | `s_Instance` |
| Instance private fields | `m_` + PascalCase | `m_Camera` |
| Public/Protected properties | camelCase | `referenceLibrary` |
| Public/Protected events | camelCase | `trackablesChanged` |
| All methods | PascalCase | `TryGetRenderingParameters()` |
| Parameters & locals | camelCase | `commandBuffer` |

> **We do NOT follow Microsoft .NET conventions.** No `_camelCase` private fields — use `m_` prefix.

## Formatting

- **Braces**: Allman style (opening brace on new line)
- **Indentation**: 4 spaces
- **SerializeField**: `[SerializeField] private` over `public` for inspector fields
- **Expression-bodied members**: Required for simple accessors (`get => m_Field;`)
- **Space after keywords**: `if (`, `for (`, `foreach (`, `while (`
- **No space before method parens**: `DoSomething()`, not `DoSomething ()`
- **Blank lines**: One between member groups (fields → properties → methods)

## Immutability

Prefer immutable patterns where practical:
- `readonly` fields and `const` for values that don't change
- `IReadOnlyList<T>`, `IReadOnlyDictionary<T,V>` for shared collections
- Do not mutate input models in-place when producing updated state
- Note: Unity MonoBehaviours are inherently stateful — apply immutability to data models and SDK API types

## File Organization

- High cohesion, low coupling
- 200-400 lines typical, 800 max
- Organize by feature/domain, not by type

## Error Handling

- Handle errors explicitly at every level
- Provide user-friendly error messages in UI-facing code
- Log detailed error context (use `Debug.LogError` / `Debug.LogException`)
- Never silently swallow errors

## Input Validation

- Validate all user input before processing
- Fail fast with clear error messages
- Never trust external data (API responses, user input, file content)

## Code Quality Checklist

Before marking work complete:
- [ ] Code is readable and follows Unity naming conventions
- [ ] Functions are small (<50 lines)
- [ ] Files are focused (<800 lines)
- [ ] No deep nesting (>4 levels)
- [ ] Proper error handling
- [ ] No hardcoded values (use `k_` constants or ScriptableObject config)
