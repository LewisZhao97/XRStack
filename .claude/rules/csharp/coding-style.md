---
paths:
  - "**/*.cs"
  - "**/*.csx"
---
# C# Coding Style (Unity Convention)

> This file extends [common/coding-style.md](../common/coding-style.md) with Unity C#-specific content.
> We follow **Unity's official package conventions** (`com.unity.xr.arfoundation` as reference).

## Standards

- Follow Unity conventions — **NOT** Microsoft .NET conventions
- Explicit access modifiers always (`private`, `public`, `internal`, `protected`)
- `[SerializeField] private` over `public` for Unity inspector fields
- Nullable reference types enabled where supported (SDK projects)

## Types and Models

- `record` / `record struct` for immutable data models (SDK layer)
- `class` for MonoBehaviours and stateful entities
- `ScriptableObject` for data-driven configuration (items, configs, events)
- `interface` for service boundaries and abstractions

```csharp
[CreateAssetMenu(fileName = "InteractionConfig", menuName = "XR/InteractionConfig")]
public class InteractionConfig : ScriptableObject
{
    [Header("Grab Settings")]
    [SerializeField] float m_GrabRange = 0.5f;

    [Tooltip("Force applied when throwing grabbed objects")]
    [SerializeField] float m_ThrowForce = 10f;

    public float grabRange => m_GrabRange;
    public float throwForce => m_ThrowForce;
}
```

## Example Class

```csharp
public class PlayerController : MonoBehaviour, IInteractable
{
    const float k_MaxSpeed = 10.0f;

    static PlayerController s_Instance;

    [SerializeField] int m_Health = 100;

    bool m_IsDead;

    public static PlayerController instance => s_Instance;
    public int health => m_Health;

    public event Action onPlayerDied;

    void Awake()
    {
        if (s_Instance == null)
        {
            s_Instance = this;
        }
    }

    public void TakeDamage(int amount)
    {
        m_Health -= amount;

        if (m_Health <= 0)
        {
            Die();
        }
    }

    void Die()
    {
        m_IsDead = true;
        onPlayerDied?.Invoke();
    }
}
```

## Async and Coroutines

- `async`/`await` with `UniTask` (if available) or `Task` for complex async operations
- Coroutines for simple frame-based sequences in MonoBehaviours
- Pass `CancellationToken` through async APIs
- Never use `.Result` or `.Wait()` — Unity main thread will deadlock

## Formatting

- 4-space indentation
- Allman brace style (opening brace on new line)
- Expression-bodied members for simple accessors (`get => m_Field;`)
- Remove unused `using` directives
