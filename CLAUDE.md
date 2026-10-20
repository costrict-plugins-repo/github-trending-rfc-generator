# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code plugin that helps draft Request for Comments (RFC) documents through interactive, multi-option exploration. The plugin enforces "thinking partner" mode — preventing code generation and discouraging premature decisions until trade-offs have been examined.

## Architecture

### Plugin System
- **`.claude-plugin/plugin.json`** - Plugin metadata (name: `rfc`, version, description)
- **`commands/*.md`** - 7 slash commands with YAML frontmatter + Claude instructions
- **`hooks/hooks.json`** - Hook configuration binding tools to approval scripts
- **`hooks/rfc-enforcer.sh`** - UserPromptSubmit hook that injects rules on every prompt when `.rfc-state` exists

### Hook Enforcement Flow
1. User runs `/rfc:start` → `start-rfc-session.sh` creates `.rfc-state` + `rfc-*.md`
2. `rfc-enforcer.sh` fires on every prompt, checks for `.rfc-state`
3. If active, outputs `<rfc-mode-enforced>` rules blocking code generation and single-option thinking
4. PreToolUse hooks validate Write/Bash/WebSearch operations
5. `/rfc:done` → `generate-rfc-draft.sh` creates clean draft, then `end-rfc-session.sh` removes `.rfc-state`

### Auto-Approval Scripts (`scripts/`)
- **`approve-rfc-write.sh`** - Only auto-approves `rfc-*.md` files
- **`approve-rfc-bash.sh`** - Only auto-approves session scripts (`start-rfc-session.sh`, `end-rfc-session.sh`, `generate-rfc-draft.sh`)
- **`approve-rfc-websearch.sh`** - Allows web searches when RFC session is active (for prior art research)

### State Management
- **`.rfc-state`** - Bash-sourceable file with session variables (`RFC_ACTIVE`, `SESSION_FILE`, `CURRENT_SECTION`, `OPTION_COUNT`, etc.)
- **`rfc-[topic]-[timestamp].md`** - Working RFC document with 8-section template and status markers
- **`rfc-[topic]-DRAFT.md`** - Clean draft ready to share (generated on `/rfc:done`)

## 8 RFC Sections

| # | Section | Purpose |
|---|---|---|
| 1 | Context & Problem | Frame the situation and who is affected |
| 2 | Goals | Outcome-focused success criteria |
| 3 | Non-Goals | What's explicitly out of scope |
| 4 | Proposed Solutions | **≥2 options required** — alternatives are the point |
| 5 | Trade-offs | What each option gains and gives up |
| 6 | Open Questions | Unknowns surfaced explicitly |
| 7 | Prior Art | What others have tried |
| 8 | Recommendation | Optional, non-binding leaning |

## Key Design Decisions

1. **Hook-enforced behavior** - Rules injected on EVERY prompt prevent Claude from "forgetting" it's in RFC mode
2. **Multi-option requirement** - The enforcer and `/rfc:done` both surface warnings when fewer than 2 options are present
3. **Warn-and-proceed** - The plugin never blocks the user; it surfaces quality signals and lets them decide
4. **Defense in depth** - 4 layers prevent code generation: rules injection, file approval restriction, bash restriction, explicit exit only
5. **Separate state from output** - `.rfc-state` is deleted on exit; `rfc-*.md` documents are preserved

## Command Reference

| Command | Purpose |
|---------|---------|
| `/rfc:start [topic] --from file.md` | Initialize session, optionally import brainstorm |
| `/rfc:section <name>` | Navigate to specific section (8 sections with aliases) |
| `/rfc:status` | Show drafting progress with option/question counts |
| `/rfc:review` | Gap analysis: missing options, weak trade-offs, tone flags |
| `/rfc:refine` | Iterate on current section |
| `/rfc:done` | Generate RFC draft and exit mode |
| `/rfc:help` | Show help |

## Git Conventions

- Commit messages are always one line
- No Co-Authored-By or other AI attribution in commits
