---
description: Display help and reference for RFC commands, sections, and usage.
---

# RFC Help

The user wants help with the RFC plugin.

## Display Format

```
RFC HELP

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COMMANDS:

  /rfc:start [topic]     Start a new RFC session
                         Options: --from <brainstorm-file.md>

  /rfc:section <name>    Jump to a specific section
                         Names: context, goals, nongoals, solutions,
                                tradeoffs, questions, prior, recommendation

  /rfc:status            Show drafting progress and key metrics

  /rfc:review            Analyze RFC for gaps, missing options, tone issues

  /rfc:refine            Iterate on current section

  /rfc:done              Generate RFC draft and exit

  /rfc:help              Show this help

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RFC SECTIONS (8 total):

  1. Context & Problem   What's going on and why it matters
  2. Goals               What success looks like (outcome-focused)
  3. Non-Goals           What's explicitly out of scope, and why
  4. Proposed Solutions  Two or more options — alternatives are the point
  5. Trade-offs          What each option gains and gives up
  6. Open Questions      What we don't know yet (an asset, not a problem)
  7. Prior Art           What others have tried; what's in the codebase
  8. Recommendation      Optional, non-binding leaning with rationale

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

HOW IT WORKS:

  1. Start with /rfc:start
  2. Frame the problem in Context & Problem
  3. For each section:
     - I frame the question the section answers
     - We discuss; I draft with options open
     - You review — approve, revise, or leave it open
  4. Sections can stay in draft — ambiguity is fine
  5. Use /rfc:review to check for gaps
  6. Generate draft with /rfc:done

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SESSION FILES:

  Working document:  rfc-[topic]-[timestamp].md
  RFC draft:         rfc-[topic]-DRAFT.md
  Located in:        current working directory

  The working document preserves the full session and status markers.
  The draft is clean and ready to share — still a starting point for discussion.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TIPS:

  • Prefer two viable options to one polished one
  • Open questions are an asset — surface them, don't resolve them prematurely
  • Avoid "must" / "shall" — RFCs propose, they don't decree
  • Trade-offs are the point — if one option has no downsides, look harder
  • The Recommendation section is optional — it's fine to leave no leaning
```

## After Help

Use AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "What would you like to do?",
      "header": "Next",
      "multiSelect": false,
      "options": [
        {"label": "Start RFC", "description": "Begin a new RFC session"},
        {"label": "Learn about sections", "description": "Get details on a specific section"},
        {"label": "Continue", "description": "Return to current work"}
      ]
    }
  ]
}
```

## If User Wants Section Details

Provide an explanation of the selected section, including:
- The question the section is trying to answer
- What makes a strong version of this section
- Common mistakes that undermine it (e.g., Proposed Solutions with only one real option)

## Important

- This command works whether or not an RFC session is active
- If a session is active, stay in RFC mode after showing help
- Do NOT write code
