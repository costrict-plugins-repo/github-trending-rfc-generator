---
description: Navigate to a specific RFC section to view or edit it.
---

# Navigate to RFC Section

The user wants to jump to a specific section of the RFC.

## Arguments

`$ARGUMENTS` contains the section name. Valid sections:

- `context` or `problem` or `context_problem`
- `goals`
- `nongoals` or `non_goals`
- `solutions` or `options` or `proposed_solutions`
- `tradeoffs` or `trade_offs`
- `questions` or `open` or `open_questions`
- `prior` or `prior_art`
- `recommendation` or `lean`

## Actions

1. **Parse the section name** from `$ARGUMENTS`
2. **Read current session file** to see section content and status
3. **Display section content** and status
4. **Offer to work on it**

## Display Format

```
SECTION: [Section Name]
Status: [IN DRAFT / NOT STARTED]

Current Content:
[Show what's in the session file for this section]

---
```

Then use AskUserQuestion. If the section is `proposed_solutions`, include the "Add another option" choice:

```json
{
  "questions": [
    {
      "question": "What would you like to do with this section?",
      "header": "Action",
      "multiSelect": false,
      "options": [
        {"label": "Edit", "description": "Revise or add to this section"},
        {"label": "Add another option", "description": "Append Option C, D, ... to Proposed Solutions (only shown for this section)"},
        {"label": "Mark as drafted", "description": "Note this section is in draft shape"},
        {"label": "Back", "description": "Return to previous section"}
      ]
    }
  ]
}
```

For all other sections, omit "Add another option":

```json
{
  "questions": [
    {
      "question": "What would you like to do with this section?",
      "header": "Action",
      "multiSelect": false,
      "options": [
        {"label": "Edit", "description": "Revise or add to this section"},
        {"label": "Mark as drafted", "description": "Note this section is in draft shape"},
        {"label": "Back", "description": "Return to previous section"}
      ]
    }
  ]
}
```

## If No Section Specified

If `$ARGUMENTS` is empty, show section list and ask which one:

```json
{
  "questions": [
    {
      "question": "Which section would you like to work on?",
      "header": "Section",
      "multiSelect": false,
      "options": [
        {"label": "Context & Problem", "description": "Section 1 — What's going on and why it matters"},
        {"label": "Proposed Solutions", "description": "Section 4 — Multiple options (need ≥2)"},
        {"label": "Trade-offs", "description": "Section 5 — What each option gains and gives up"},
        {"label": "Open Questions", "description": "Section 6 — What we don't know yet"}
      ]
    }
  ]
}
```

## Important

- Stay in RFC mode
- Do NOT write code
- Update session file when changes are made
- Track section status changes
- "Mark as drafted" does not mean the section is final — it can always be reopened
