<p align="center">
  <h1 align="center">Unity XR Claude Code Workflow</h1>
  <p align="center">
    A pre-built <a href="https://docs.anthropic.com/en/docs/claude-code">Claude Code</a> workflow for Unity XR development.
    <br />
    Drop it into any Unity project and get 30 specialist agents, 43 slash commands, 25 auto-loaded rules, and 8 lifecycle hooks — all tuned for XR development.
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue" alt="MIT License"></a>
  <a href=".claude/agents"><img src="https://img.shields.io/badge/agents-30-blueviolet" alt="30 Agents"></a>
  <a href=".claude/skills"><img src="https://img.shields.io/badge/skills-43-green" alt="43 Skills"></a>
  <a href=".claude/hooks"><img src="https://img.shields.io/badge/hooks-8+2-darkcyan" alt="8+2 Hooks"></a>
  <a href=".claude/rules"><img src="https://img.shields.io/badge/rules-25-red" alt="25 Rules"></a>
  <a href=".claude/mcps"><img src="https://img.shields.io/badge/mcps-under_construction-steelblue" alt="coming.."></a>
  <a href="https://docs.anthropic.com/en/docs/claude-code"><img src="https://img.shields.io/badge/built_for-Claude_Code-goldenrod?logo=anthropic" alt="Built for Claude Code"></a>
  <a href=".claude/rules"><img src="https://img.shields.io/badge/status-experimental-chocolate" alt="Experimental"></a>
</p>

## Why This Exists

### The Problem

Claude Code is powerful out of the box, but a raw session knows nothing about your Unity project's architecture, XR constraints, naming conventions, or performance budgets. Every conversation starts from zero. Without structure, AI agents:

- Invent their own naming conventions (`.NET` style one session, Unity style the next)
- Ignore XR frame budgets and allocate freely in hot paths
- Duplicate utilities that already exist because they can't see the full codebase
- Lose context across sessions — each conversation re-litigates the same decisions
- Generate "slop" at machine speed — inconsistent patterns, dead code, over-engineered abstractions

### Three Layers of AI Engineering

Most teams stop at layer 1 and wonder why results are inconsistent:

1. **Prompt Engineering** (how to say it) — single-call intent and format. Necessary but insufficient.
2. **Context Engineering** (what to know) — feeding the right information at the right time. Better, but still passive.
3. **Harness Engineering** (how to stay correct) — the feedback loop that catches drift and pulls the agent back. This is where production reliability lives.

This workflow operates at **layer 3**.

### What Is Harness Engineering?

Harness engineering is cybernetics applied to AI-assisted development. The pattern is ancient — James Watt's centrifugal governor, thermostat controllers, Kubernetes reconciliation loops — all share the same structure:

```
Goal State + Sensor + Actuator + Feedback Loop = Control System
```

- **Without a goal**, the agent generates blindly (no `CLAUDE.md` / rules = no conventions)
- **Without sensors**, it doesn't know it's wrong (no hooks = no validation)
- **Without actuators**, it can't fix what it finds (no agents = no specialist correction)
- **Without feedback**, it repeats the same mistakes forever (no rules = no learning)

A documented convention will be violated. A lint rule won't. This workflow pushes constraints as high up the enforcement hierarchy as possible:

| Layer | Mechanism | Reliability |
|-------|-----------|-------------|
| **Blocked** | `settings.json` deny-list | Impossible to violate |
| **Caught pre-commit** | Hooks (`validate-commit.sh`) | Caught before damage |
| **Auto-loaded** | Rules (path-matched `.md` files) | In context when relevant |
| **Project-wide** | `CLAUDE.md` | Read every conversation |
| **Verbal** | Chat corrections | Least reliable, but saved to memory |

The engineer's role shifts from writing code to **designing the control system** that lets agents write code correctly. You steer; the agent executes.

### What This Workflow Provides

- **Encodes XR knowledge** — frame budgets, draw call limits, GC-free hot paths, stereo rendering constraints
- **Enforces conventions** — Unity-style naming (`m_Field`, `k_Constant`, `s_Static`), Allman braces, commit message format
- **Provides specialist agents** — ask the `xr-specialist` about hand tracking or the `performance-analyst` about frame time, instead of getting generic answers
- **Automates guardrails** — hooks validate commits, block force-pushes, and audit agent invocations
- **Scales with your team** — everyone shares the same rules, agents, and commands via git
- **Self-corrects** — the harness catches drift mechanically, not through human vigilance
- **Learns over time** — continuous learning extracts patterns from sessions into reusable instincts that evolve into skills

## Table of Contents

- [What's Included](#whats-included)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Working Agents (30)](#working-agents-30)
- [Slash Commands (43)](#slash-commands-43)
- [Rules (25)](#rules-25)
- [Hooks (8 + 2 optional)](#hooks-8--2-optional)
- [Design Philosophy](#design-philosophy)
- [Customization](#customization)
- [License](#license)

## What's Included

| Component | Count | Purpose |
|-----------|-------|---------|
| **Agents** | 30 | Specialist sub-agents with domain expertise |
| **Skills** | 43 | One-command workflows (`/plan`, `/code-review`, `/xr-test`, ...) |
| **Rules** | 25 | Auto-loaded coding standards and constraints |
| **Hooks** | 8 + 2 | 8 lifecycle hooks + 2 optional learning/optimization hooks |
| **Scripts** | 3 | Node.js session management utilities |
| **Templates** | 18 | Document templates for design, production, and release artifacts |
| **CLAUDE.md** | 1 | Project-wide instructions loaded every conversation |
| **settings.json** | 1 | Permissions, hook wiring, safety deny-list |

## Documentations

- [Agent Roster](.claude/docs/agent-roster.md) — 30 agents, tier hierarchy, delegation map
- [Skills Reference](.claude/docs/skills-reference.md) — 43 slash commands by category
- [Rules Reference](.claude/docs/rules-reference.md) — 25 auto-loaded rules by path
- [Hooks Reference](.claude/docs/hooks-reference.md) — 8 core + 2 optional learning hooks
- [Quick Start](.claude/docs/quick-start.md) — Onboarding paths for new users
- [Agent Coordination Map](.claude/docs/agent-coordination-map.md) — Workflow patterns and delegation rules
- [Review Workflow](.claude/docs/review-workflow.md) — Code review routing
- [Technical Preferences](.claude/docs/technical-preferences.md) — Engine, framework, and tooling details

## Quick Start

### Prerequisites

- Bash (Git Bash on Windows works)
- Unity 6.x project (tested with 6000.0.27f1)
- [Git](https://git-scm.com/)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed (`irm https://claude.ai/install.ps1 | iex`)
- **Recommended**: 
  - [jq](https://jqlang.github.io/jq/) (for hook validation)
  - Python 3 (for JSON validation, continuous learning observation hooks)
  - [Node.js](https://nodejs.org/) (for session management scripts)

### Option A — Git Submodule (recommended for teams)

Keep this workflow as a separate repo inside your Unity project, linked via symlink:

```bash
# 1. Add as submodule
cd YourUnityProject/
git submodule add <this-repo-url> ClaudeWorkflow

# 2. Create symlink to .claude/ (Windows — requires Developer Mode)
mklink /D .claude ClaudeWorkflow\.claude

# On Windows without Developer Mode, use a junction instead:
# mklink /J .claude ClaudeWorkflow\.claude

# On macOS/Linux:
# ln -s ClaudeWorkflow/.claude .claude

# 3. Optional
# Copy CLAUDE.md as a starting template (customize for your project)
cp ClaudeWorkflow/CLAUDE.md ./CLAUDE.md

# 4. Add to .gitignore
echo ".claude" >> .gitignore
echo "docs/unity" >> .gitignore

# 5. Launch Claude Code
claude

# 6. Run /start-harness — discovers your project, generates or audits CLAUDE.md, then routes you
/start-harness
```

`/start-harness` is the single entry point. It scans your Unity project (version, XR packages, SDK, scripts), generates a harness-compliant `CLAUDE.md` if none exists (or audits and fixes an existing one), then routes you to the right workflow.

> **Tip:** You can also use Claude Code's built-in `/init` to generate a basic `CLAUDE.md`,
> or copy `ClaudeWorkflow/CLAUDE.md` as a starting template. `/start-harness` produces
> the most harness-compliant result because it enforces all required sections.

### Option B — Direct Copy (simple, no upstream updates)

```bash
cp -r ClaudeWorkflow/.claude YourUnityProject/.claude

# template — customize for your project
cp ClaudeWorkflow/CLAUDE.md YourUnityProject/CLAUDE.md

# Optional: copy Unity API reference docs
cp -r ClaudeWorkflow/docs YourUnityProject/docs
```

## Project Structure

### This Repo

```
ClaudeWorkflow/
├── .claude/
│   ├── settings.json           # Permissions, hooks, safety rules
│   ├── agents/                 # 30 specialist agent definitions
│   ├── skills/                 # 43 slash command implementations
│   ├── rules/
│   │   ├── common/             # 19 rules (loaded for all files)
│   │   └── csharp/             # 6 rules (loaded for *.cs files only)
│   ├── hooks/                  # 8 lifecycle shell scripts
│   ├── scripts/
│   │   └── lib/                # Node.js session management utilities
│   └── docs/
│       ├── templates/          # 18 document templates
│       └── unity-references/   # Unity API reference docs
├── CLAUDE.md                   # Template — copy to your project root and customize
└── README.md
```

### Your Unity Project (after integration)

```
YourUnityProject/
├── .claude                             # agents, skills, rules
├── docs
│   └── app design docs/                # Game design artifacts (from /brainstorm)
├── CLAUDE.md                           # Your project's instructions
├── Assets/
│   ├── Scripts/
│   │   ├── Core/
│   │   ├── XR/
│   │   ├── Interaction/
│   │   ├── UI/
│   │   └── Gameplay/
│   ├── Shaders/
│   ├── Models/
│   ├── Textures/
│   ├── Prefabs/
│   └── Tests/
├── Packages/
│   └── com.yourcompany.xr.sdk/         # XR SDK
│       ├── Runtime/
│       ├── Editor/
│       └── Tests/
├── ProjectSettings/
├── UserSettings/
└── *.sln
```

## How It Works

Claude Code auto-discovers the `.claude/` directory at your project root:

```
You type a message
       |
       v
  [CLAUDE.md loaded] ── Project context, conventions, constraints
       |
       v
  [Rules matched] ── e.g., editing a .cs file loads csharp/coding-style.md
       |
       v
  [Hooks fire] ── SessionStart, PreToolUse, PostToolUse, etc.
       |
       v
  [Agent selected] ── Claude delegates to specialist (xr-specialist, etc.)
       |
       v
  [Slash commands available] ── /plan, /code-review, /xr-test, etc.
```

**Rules** are path-matched — `csharp/coding-style.md` has a `paths: ["**/*.cs"]` frontmatter, so it only loads when Claude touches C# files. Common rules load always.

**Agents** are specialist sub-processes. When you ask about XR interaction design, Claude can spawn the `xr-specialist` agent which has deep XR knowledge. Agents run in isolated contexts and report back.

**Hooks** are shell scripts triggered by lifecycle events. `validate-commit.sh` runs before every `git commit` to check for hardcoded values and JSON validity. `session-start.sh` loads branch context when you start a session.

## Working Agents (30)

The workflow is organized in three tiers, from strategic to tactical:

### Tier 1 — Directors (Strategic Decisions)

High-level decision makers. Use Opus model for deepest reasoning.

| Agent | Responsibility |
|-------|---------------|
| `technical-director` | Architecture, technology choices, performance strategy, technical risk |
| `producer` | Sprint planning, milestone tracking, scope negotiation, cross-team coordination |

### Tier 2 — Leads (Tactical Decisions)

Domain leads who translate strategy into concrete plans. Use Sonnet model.

| Agent | Responsibility |
|-------|---------------|
| `lead-programmer` | Code architecture, code review, coding standards, work assignment |
| `qa-lead` | Test strategy, quality gates, release readiness |
| `xr-specialist` | XR interaction authority, tracking, spatial UI, cross-platform XR |
| `release-manager` | Release pipeline, certification, store submission, versioning |

### Tier 3 — Specialists (Implementation)

Domain experts who execute specific work. Use Sonnet or Haiku model.

| Category | Agents |
|----------|--------|
| **XR** | `unity-xri-specialist`, `openxr-runtime-specialist`, `platform-specialist`, `sdk-developer` |
| **Unity Engine** | `unity-specialist`, `unity-shader-specialist`, `unity-ui-specialist`, `unity-dots-specialist`, `unity-addressables-specialist` |
| **Programming** | `gameplay-programmer`, `network-programmer`, `tools-programmer`, `ui-programmer` |
| **Art & Tech Art** | `technical-artist` |
| **Quality** | `qa-tester`, `security-engineer`, `accessibility-specialist`, `performance-analyst` |
| **Design** | `game-designer` |
| **Production** | `analytics-engineer`, `localization-lead`, `ux-designer`, `devops-engineer`, `prototyper` |

### Engine Specialists

The Unity engine specialists form a sub-hierarchy for deep engine knowledge:

```
unity-specialist (lead)
├── unity-dots-specialist         # ECS, Jobs, Burst compiler
├── unity-shader-specialist       # Shader Graph, VFX Graph, URP customization
├── unity-addressables-specialist # Asset loading, bundles, memory management
├── unity-ui-specialist           # UI Toolkit, UGUI, data binding
└── unity-xri-specialist          # XR Interaction Toolkit components
```

The `unity-specialist` is the generalist authority on Unity APIs and patterns. Sub-specialists handle deep subsystem work. When Claude encounters a Shader Graph question, it routes to `unity-shader-specialist`; for an Addressables loading issue, to `unity-addressables-specialist`.

XR-specific engine work has its own parallel hierarchy:

```
xr-specialist (authority)
├── unity-xri-specialist          # XRI interactors, interactables, locomotion
├── openxr-runtime-specialist     # OpenXR loader, runtime, API layers
├── platform-specialist           # XR glasses / PC streaming builds
└── sdk-developer                 # SDK public API, versioning, UPM
```

## Slash Commands (43)

### XR-Specific
| Command | Purpose |
|---------|---------|
| `/xr-test` | Generate XR interaction, locomotion, and comfort tests |
| `/build-platform` | Validate build settings for XR glasses or PC streaming |
| `/xr-perf-profile` | Frame budget analysis (72/90/120Hz targets) |

### Development
| Command | Purpose |
|---------|---------|
| `/plan` | Create implementation plan (waits for confirmation before coding) |
| `/code-review` | Architectural and quality code review |
| `/perf-profile` | General performance profiling |
| `/architecture-decision` | Create an Architecture Decision Record |
| `/prototype` | Rapid prototyping with relaxed standards |
| `/reverse-document` | Generate design docs from existing code |
| `/bug-report` | Structured bug report creation |
| `/design-review` | Review game design docs for completeness and implementability |
| `/brainstorm` | Guided concept ideation from zero to structured design |

### Production
| Command | Purpose |
|---------|---------|
| `/sprint-plan` | Plan or update a sprint |
| `/estimate` | Task effort estimation with confidence levels |
| `/scope-check` | Detect scope creep against original plan |
| `/milestone-review` | Milestone progress and go/no-go assessment |
| `/gate-check` | Phase readiness validation |
| `/retrospective` | Sprint or milestone retrospective |
| `/changelog` | Generate changelog from git history |

### Quality & Release
| Command | Purpose |
|---------|---------|
| `/tech-debt` | Track and prioritize technical debt |
| `/asset-audit` | Asset naming, size, and format compliance |
| `/release-checklist` | Pre-release validation checklist |
| `/hotfix` | Emergency fix workflow with audit trail |
| `/localize` | Localization readiness and string extraction |

### Verification & Evaluation
| Command | Purpose |
|---------|---------|
| `/verify` | Run 6-phase verification loop (build, compile, analysis, tests, XR perf, diff) |
| `/eval` | Define, check, and report eval-driven development criteria |
| `/checkpoint` | Create or verify named git checkpoints during implementation |

### Continuous Learning
| Command | Purpose |
|---------|---------|
| `/learn-eval` | Extract reusable patterns from current session with quality gate |
| `/instinct-status` | Show learned instincts (project + global) with confidence scores |
| `/evolve` | Cluster related instincts into skills, commands, or agents |
| `/prune` | Delete expired instincts older than 30 days |
| `/instinct-import` | Import instincts from file or URL |
| `/instinct-export` | Export instincts to shareable format |
| `/skill-create` | Generate skills from local git history patterns |

### Session Management
| Command | Purpose |
|---------|---------|
| `/save-session` | Save full session state for future resume |
| `/sessions` | List, load, alias, and browse saved sessions |
| `/strategic-compact` | Context compaction suggestions at logical phase transitions |

### Onboarding & Team
| Command | Purpose |
|---------|---------|
| `/start-harness` | Discover project, ensure CLAUDE.md harness compliance, route to workflow |
| `/onboard` | Generate onboarding doc for a new contributor |
| `/team-ui` | Orchestrate UX designer + UI programmer + art review |
| `/team-release` | Orchestrate release manager + QA + DevOps + producer |
| `/project-stage-detect` | Auto-detect project stage and recommend next steps |

## Rules (25)

Rules auto-load based on file path patterns. You never invoke them manually.

### Common Rules (19) — Always Active
| Rule | Enforces |
|------|----------|
| `coding-style.md` | Unity naming conventions (`m_`, `k_`, `s_`), formatting, immutability |
| `xr-development.md` | XR performance budgets, interaction patterns, comfort |
| `git-workflow.md` | Commit message format, PR workflow |
| `code-review.md` | Review checklist, severity levels |
| `testing.md` | TDD workflow, 80% coverage requirement |
| `security.md` | Secret management, input validation |
| `development-workflow.md` | Feature implementation pipeline |
| `patterns.md` | ScriptableObject events, service locator, state machine |
| `performance.md` | Model selection, context window management |
| `engine-code.md` | Core/SDK/Runtime code standards |
| `gameplay-code.md` | Interaction and feature code standards |
| `shader-code.md` | Shader naming, precision, XR stereo rendering |
| `ui-code.md` | Spatial UI, world-space canvas patterns |
| `network-code.md` | Networking standards |
| `data-files.md` | JSON/config file standards |
| `prototype-code.md` | Relaxed standards for prototype code |
| `test-standards.md` | Test naming, AAA pattern |
| `agents.md` | Agent orchestration and delegation rules |
| `hooks.md` | Hook types and best practices |

### C# Rules (6) — Active for `*.cs` Files Only
| Rule | Enforces |
|------|----------|
| `coding-style.md` | Unity C# conventions, ScriptableObjects, async patterns |
| `unity-xr.md` | XRI component patterns, common XR pitfalls |
| `patterns.md` | ScriptableObject config, event channels, SDK `Result<T>` |
| `testing.md` | Unity Test Framework, `XRDeviceSimulator`, Play/Edit mode |
| `security.md` | XR input validation, network security |
| `hooks.md` | `dotnet format`, build verification |

## Hooks (8 + 2 optional)

### Core Hooks (always active)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `session-start.sh` | Session start | Load branch, Unity version, XR package context |
| `detect-gaps.sh` | Session start | Flag missing docs, tests, or XR packages |
| `validate-commit.sh` | Before `git commit` | JSON validation, hardcoded value detection, TODO format |
| `validate-push.sh` | Before `git push` | Protected branch warning, test reminder |
| `validate-assets.sh` | After file write/edit | Asset naming and JSON validation |
| `pre-compact.sh` | Before context compaction | Dump session state for recovery |
| `session-stop.sh` | Session end | Log session summary, archive state |
| `log-agent.sh` | Agent spawn | Audit trail for agent invocations |

### Optional Learning Hooks (enable in settings.json)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `observe.sh` | Every tool call (Pre/PostToolUse) | Capture tool use events for instinct pattern analysis |
| `suggest-compact.sh` | Before Edit/Write | Suggest `/compact` at logical phase transitions (50+ calls) |

These hooks power the continuous learning system. `observe.sh` captures tool usage patterns into project-scoped observation logs. A background observer (optional, uses Haiku) analyzes observations and creates atomic "instincts" — small learned behaviors with confidence scoring. See [Hooks Reference](.claude/docs/hooks-reference.md) for setup instructions.

## Design Philosophy

### 1. Harness, Not Prompts

Telling the agent "use Unity conventions" in every message doesn't scale. This workflow encodes constraints into **rules** (auto-loaded), **hooks** (auto-enforced), and **settings** (permissions). The agent follows conventions because the harness makes it the path of least resistance.

### 2. Specialist Over Generalist

A single Claude session answering XR questions, reviewing code, and planning sprints produces mediocre results everywhere. Specialist agents carry deep domain context — the `xr-specialist` knows about motion sickness, the `performance-analyst` knows about frame budgets, and the `sdk-developer` knows about semantic versioning. Routing to the right specialist produces better output.

### 3. Progressive Disclosure

`CLAUDE.md` is a table of contents, not an encyclopedia. It gives Claude the essentials (tech stack, conventions, budgets) and points to deeper docs. Rules load only when relevant files are touched. This keeps the context window focused on what matters for the current task.

### 4. Mechanical Enforcement Over Documentation

A documented convention will be violated. A lint rule won't. This workflow pushes constraints as high up the enforcement hierarchy as possible:

1. **settings.json deny-list** — impossible to violate (blocked commands)
2. **Hooks** — caught before commit/push
3. **Rules** — loaded into agent context per file type
4. **CLAUDE.md** — project-wide instructions
5. **Verbal corrections** — least reliable (but saved to memory for future sessions)

### 5. XR-First, Not XR-Added

XR constraints aren't a separate checklist bolted onto a generic Unity workflow — they're embedded into every layer. The coding-style rule mentions GC-free hot paths because XR frame drops cause nausea. The shader rule enforces `half` precision because XR glasses have mobile GPUs. The performance-analyst agent knows 11ms frame budgets by default. Every agent, rule, and skill already "thinks in XR" rather than treating it as an afterthought — like a building designed for earthquakes from day one, not retrofit with brackets after construction.

## Customization

### Adding an Agent

Create a file in `.claude/agents/`:

```markdown
---
name: my-specialist
description: "One-line description of when to use this agent."
tools: Read, Glob, Grep, Write, Edit, Bash
model: sonnet
maxTurns: 20
---

You are the [Role] for a Unity XR project. [Core responsibilities...]

## Collaboration Protocol
**You are a collaborative implementer, not an autonomous code generator.**

## Core Responsibilities
- [What this agent owns]
- [What it enforces]

## Delegation Map
**Reports to**: [parent agent]
**Coordinates with**: [sibling agents]
```

Available models: `opus` (deepest reasoning), `sonnet` (best coding), `haiku` (fast/cheap).

### Adding a Slash Command (Skill)

Create a directory in `.claude/skills/` with a `SKILL.md`:

```
.claude/skills/my-command/
└── SKILL.md
```

```markdown
---
name: my-command
description: "What this command does."
argument-hint: "[optional-arg]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
---

When this skill is invoked:

1. **Step one** — what to analyze
2. **Step two** — what to generate
3. **Output format** — the report structure
```

### Adding a Rule

Create a file in `.claude/rules/common/` (always loaded) or `.claude/rules/csharp/` (loaded for C# files):

```markdown
---
paths:
  - "Assets/Scripts/**/*.cs"
---

# My Rule

## What to enforce
- [Convention or constraint]
- [Anti-pattern to prevent]
```

The `paths` frontmatter controls when the rule loads. Omit it for always-on rules.

### Removing Components

- **Remove an agent**: Delete its `.md` file from `.claude/agents/`
- **Remove a skill**: Delete its directory from `.claude/skills/`
- **Remove a rule**: Delete its `.md` file from `.claude/rules/`
- **Remove a hook**: Delete its `.sh` file from `.claude/hooks/` and remove the reference in `.claude/settings.json`

### Adapting for Non-XR Unity Projects

1. Remove XR-specific agents: `xr-specialist`, `unity-xri-specialist`, `openxr-runtime-specialist`, `platform-specialist`, `sdk-developer`
2. Remove XR-specific rules: `xr-development.md`, `unity-xr.md`
3. Remove XR-specific commands: `/xr-test`, `/xr-perf-profile`, `/build-platform`
4. Update `CLAUDE.md` to remove XR constraints and performance budgets
5. Keep everything else — the Unity engine specialists, coding standards, review workflow, and production tools are engine-agnostic

> [!NOTE]
> This workflow is in active development. The current release covers agents, skills, rules, and hooks.
> Upcoming additions include MCP server integrations, more XR-specific validation tools, and expanded
> platform coverage. Contributions and feedback are welcome.

## License

MIT
