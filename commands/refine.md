---
description: Iterate on the current RFC section with more depth, additional options, or softer framing.
---

# Refine Current Section

The user wants to iterate on the current section to improve it.

## Actions

1. **Read `.rfc-state`** to get current section
2. **Read session file** to get current content
3. **Present current content**
4. **Ask what to improve**

## Display Format

```
REFINING: [Section Name]

Current content:
───────────────────────────────
[Current section content from file]
───────────────────────────────
```

## Refinement Options

Use AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "What would you like to refine?",
      "header": "Refine",
      "multiSelect": false,
      "options": [
        {"label": "Add an alternative option", "description": "Append a new Option C/D to Proposed Solutions and extend the Trade-offs table"},
        {"label": "Soften over-confident language", "description": "Flag sentences that read as decisions and reword them as proposals"},
        {"label": "Surface a hidden assumption", "description": "Move implicit claims into Open Questions where they can be examined"},
        {"label": "Add depth", "description": "Expand a thin section with more context, stakeholders, or analysis"}
      ]
    }
  ]
}
```

## Refinement Process

**Add an alternative option:**
- Ask: "What's the name or rough idea for this option?"
- Help sketch the Sketch, Assumptions, and What we'd build
- Append the new option under Proposed Solutions in the session file
- Add a new column to the Trade-offs table for the new option
- Update session file with approved content

**Soften over-confident language:**
- Scan the current section for "must", "shall", "will", "is required to", "the system needs to"
- For each instance, propose a softer rewording: "one approach is...", "this could...", "we might..."
- Ask: "Does this reframing feel accurate, or does it lose something important?"
- Update file with approved rewording

**Surface a hidden assumption:**
- Ask: "What's an assumption baked into this section that we haven't made explicit?"
- Help formulate it as an open question: "- [ ] [assumption restated as a question]"
- Add to the Open Questions section
- Optionally note which section the assumption came from

**Add depth:**
- Ask targeted questions about what's thin or unclear
- Propose additions that explore the problem space rather than narrow it
- Update file with approved content

## Important

- Always show proposed changes before writing to file
- Get explicit acknowledgment before updating
- Keep iterating until user is satisfied
- Do NOT write code
- Stay in RFC mode
- "Soften over-confident language" is the most RFC-specific refinement — use it proactively if the current section sounds like a decision
