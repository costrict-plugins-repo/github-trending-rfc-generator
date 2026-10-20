---
description: Show current RFC session progress including section drafting status.
---

# RFC Status

The user wants to see their progress on the RFC.

## Actions

1. **Read `.rfc-state`** to get current state
2. **Read session file** to assess section content
3. **Display status overview**

## Display Format

```
RFC STATUS

Topic: [topic from state]
Source: [brainstorm file or "None"]
Started: [timestamp]
Current Section: [current section name]

Sections drafted: X/8
Options proposed: N  (need ≥2 for a strong RFC)
Open questions raised: N

Section Progress:

✓ 1. Context & Problem    [IN DRAFT]
→ 2. Goals                [IN DRAFT — current]
○ 3. Non-Goals            [NOT STARTED]
○ 4. Proposed Solutions   [NOT STARTED — 0 options drafted]
○ 5. Trade-offs           [NOT STARTED]
○ 6. Open Questions       [NOT STARTED]
○ 7. Prior Art            [NOT STARTED]
○ 8. Recommendation       [NOT STARTED — optional]

Session file: [path]
```

Legend:
- ✓ = In draft (has content)
- → = Current section being worked on
- ○ = Not started

Note: RFC sections are never "complete" — they're in draft until the RFC is superseded or accepted. "In draft" is the normal state.

## After Status

Use AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "How would you like to continue?",
      "header": "Continue",
      "multiSelect": false,
      "options": [
        {"label": "Continue current", "description": "Keep working on the current section"},
        {"label": "Jump to section", "description": "Go to a different section"},
        {"label": "Review RFC", "description": "Check for gaps, missing options, or weak trade-offs"},
        {"label": "Generate draft", "description": "Produce the RFC draft with /rfc:done"}
      ]
    }
  ]
}
```

## Important

- This command does NOT exit RFC mode
- Do NOT write code
- Sections that are "NOT STARTED" are fine — RFCs are iterative
- The key health signals are option count and open question count, not section completion
