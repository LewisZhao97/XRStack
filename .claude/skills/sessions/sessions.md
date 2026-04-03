---
name: sessions
description: Manage Claude Code session history — list, load, alias, and browse sessions stored in ~/.claude/session-data/.
command: true
---

# Sessions Command

Manage Claude Code session history — list, load, alias, and browse sessions.

## Usage

`/sessions [list|load|alias|info|aliases|help] [options]`

## Actions

### List Sessions

```bash
/sessions                              # List all sessions (default)
/sessions list                         # Same as above
/sessions list --limit 10              # Show 10 sessions
/sessions list --date 2026-04-01       # Filter by date
/sessions list --search abc            # Search by session ID
```

**Script:**
```bash
node -e "
const sm = require('./.claude/scripts/lib/session-manager');
const aa = require('./.claude/scripts/lib/session-aliases');
const path = require('path');

const result = sm.getAllSessions({ limit: 20 });
const aliases = aa.listAliases();
const aliasMap = {};
for (const a of aliases) aliasMap[a.sessionPath] = a.name;

console.log('Sessions (showing ' + result.sessions.length + ' of ' + result.total + '):');
console.log('');
console.log('ID        Date        Time     Branch       Alias');
console.log('──────────────────────────────────────────────────');

for (const s of result.sessions) {
  const alias = aliasMap[s.filename] || '';
  const metadata = sm.parseSessionMetadata(sm.getSessionContent(s.sessionPath));
  const id = s.shortId === 'no-id' ? '(none)' : s.shortId.slice(0, 8);
  const time = s.modifiedTime.toTimeString().slice(0, 5);
  const branch = (metadata.branch || '-').slice(0, 12);

  console.log(id.padEnd(8) + '  ' + s.date + '  ' + time + '   ' + branch.padEnd(12) + ' ' + alias);
}
"
```

### Load Session

Load and display a session's content (by ID or alias).

```bash
/sessions load <id|alias>
/sessions load a1b2c3d4
/sessions load my-alias
```

**Script:**
```bash
node -e "
const sm = require('./.claude/scripts/lib/session-manager');
const aa = require('./.claude/scripts/lib/session-aliases');
const id = process.argv[1];

const resolved = aa.resolveAlias(id);
const sessionId = resolved ? resolved.sessionPath : id;

const session = sm.getSessionById(sessionId, true);
if (!session) {
  console.log('Session not found: ' + id);
  process.exit(1);
}

const stats = sm.getSessionStats(session.sessionPath);
const size = sm.getSessionSize(session.sessionPath);
const aliases = aa.getAliasesForSession(session.filename);

console.log('Session: ' + session.filename);
console.log('Path: ' + session.sessionPath);
console.log('');
console.log('Statistics:');
console.log('  Lines: ' + stats.lineCount);
console.log('  Total items: ' + stats.totalItems);
console.log('  Completed: ' + stats.completedItems);
console.log('  In progress: ' + stats.inProgressItems);
console.log('  Size: ' + size);

if (aliases.length > 0) {
  console.log('Aliases: ' + aliases.map(a => a.name).join(', '));
}

if (session.metadata.branch) {
  console.log('Branch: ' + session.metadata.branch);
}
" "$ARGUMENTS"
```

### Create Alias

```bash
/sessions alias <id> <name>
/sessions alias 2026-04-01 today-work
```

**Script:**
```bash
node -e "
const sm = require('./.claude/scripts/lib/session-manager');
const aa = require('./.claude/scripts/lib/session-aliases');

const sessionId = process.argv[1];
const aliasName = process.argv[2];

if (!sessionId || !aliasName) {
  console.log('Usage: /sessions alias <id> <name>');
  process.exit(1);
}

const session = sm.getSessionById(sessionId);
if (!session) {
  console.log('Session not found: ' + sessionId);
  process.exit(1);
}

const result = aa.setAlias(aliasName, session.filename);
if (result.success) {
  console.log('Alias created: ' + aliasName + ' -> ' + session.filename);
} else {
  console.log('Error: ' + result.error);
  process.exit(1);
}
" "$ARGUMENTS"
```

### List Aliases

```bash
/sessions aliases
```

**Script:**
```bash
node -e "
const aa = require('./.claude/scripts/lib/session-aliases');

const aliases = aa.listAliases();
console.log('Session Aliases (' + aliases.length + '):');
console.log('');

if (aliases.length === 0) {
  console.log('No aliases found.');
} else {
  console.log('Name          Session File');
  console.log('──────────────────────────────────────');
  for (const a of aliases) {
    const name = a.name.padEnd(12);
    const file = a.sessionPath.length > 30 ? a.sessionPath.slice(0, 27) + '...' : a.sessionPath;
    console.log(name + '  ' + file);
  }
}
"
```

## Arguments

$ARGUMENTS:
- `list [options]` — List sessions
  - `--limit <n>` — Max sessions to show (default: 50)
  - `--date <YYYY-MM-DD>` — Filter by date
  - `--search <pattern>` — Search in session ID
- `load <id|alias>` — Load session content
- `alias <id> <name>` — Create alias for session
- `alias --remove <name>` — Remove alias
- `info <id|alias>` — Show session statistics
- `aliases` — List all aliases
- `help` — Show this help

## Notes

- Sessions are stored as markdown files in `~/.claude/session-data/`
- Aliases are stored in `~/.claude/session-aliases.json`
- Session IDs can be shortened (first 4-8 characters usually unique)
- Scripts require Node.js and `.claude/scripts/lib/utils.js`

## Related

- `/save-session` — Create a new session file
- `/checkpoint` — Create a lightweight git checkpoint
