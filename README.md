# claude-rfc-plugin

A Claude Code plugin for drafting Request for Comments (RFC) documents through interactive, multi-option exploration.

Good decisions need good options. This plugin locks Claude into "thinking partner" mode — no code, no premature decisions — until you've explored the problem space together. It surfaces multiple solution approaches, captures trade-offs honestly, and names open questions explicitly. The output is a draft RFC ready for team review, not a final spec.

## Installation

Add to `~/.claude/settings.json`:

```json
{
  "pluginDirs": ["/path/to/claude-rfc-plugin"]
}
```

Or use the CLI flag:

```bash
claude --plugin-dir /path/to/claude-rfc-plugin
```

## Commands

| Command | Description |
|---------|-------------|
| `/rfc:start [topic]` | Start a new RFC session |
| `/rfc:section <name>` | Jump to a specific section |
| `/rfc:status` | Show drafting progress |
| `/rfc:review` | Analyze RFC for gaps, missing options, tone issues |
| `/rfc:refine` | Iterate on current section |
| `/rfc:done` | Generate draft and exit RFC mode |
| `/rfc:help` | Show help |

### Starting a session

```
/rfc:start session retention strategy
```

Import from a brainstorm session:

```
/rfc:start api versioning --from brainstorm-api-20260503.md
```

## RFC Sections (8 total)

| # | Section | Purpose |
|---|---|---|
| 1 | Context & Problem | What's going on and why it matters |
| 2 | Goals | What success looks like (outcome-focused) |
| 3 | Non-Goals | What's explicitly out of scope |
| 4 | Proposed Solutions | **≥2 options required** — alternatives are the point |
| 5 | Trade-offs | What each option gains and gives up |
| 6 | Open Questions | What we don't know yet (surface, don't suppress) |
| 7 | Prior Art | What others have tried; what's in the codebase |
| 8 | Recommendation | Optional, non-binding leaning with rationale |

## How it works

1. `/rfc:start` creates a `.rfc-state` file and a `rfc-[topic]-[timestamp].md` session file
2. The `rfc-enforcer.sh` hook injects rules on every prompt while RFC mode is active
3. Claude explores each section collaboratively — sections can stay open, no forced completion
4. You navigate, review, and refine at your own pace
5. `/rfc:done` generates a clean `rfc-[topic]-DRAFT.md` with warnings for missing options or open questions, then removes the state file

## Hook enforcement

While RFC mode is active, Claude:
- Cannot write code files (only `rfc-*.md` files are auto-approved)
- Cannot run arbitrary bash commands (only session scripts are approved)
- Cannot present a single solution as the only option
- Cannot exit RFC mode except via `/rfc:done`

## Files generated

- `.rfc-state` - Session state (deleted on `/rfc:done`)
- `rfc-[topic]-[timestamp].md` - Working document with full session history (preserved)
- `rfc-[topic]-DRAFT.md` - Clean draft ready to share (generated on `/rfc:done`)

## Project structure

```
claude-rfc-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── start.md
│   ├── section.md
│   ├── status.md
│   ├── review.md
│   ├── refine.md
│   ├── done.md
│   └── help.md
├── hooks/
│   ├── hooks.json
│   └── rfc-enforcer.sh
└── scripts/
    ├── start-rfc-session.sh
    ├── end-rfc-session.sh
    ├── generate-rfc-draft.sh
    ├── approve-rfc-write.sh
    ├── approve-rfc-bash.sh
    └── approve-rfc-websearch.sh
```

## License

MIT
