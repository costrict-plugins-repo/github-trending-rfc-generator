---
description: Finalize the RFC session, generate draft document, and exit RFC mode.
---

# End RFC Session

The user is ready to produce their RFC draft and exit RFC mode.

## Actions

1. **Run completeness check** — warn about missing options or open questions (never block)
2. **Add draft summary** to working session file
3. **Generate clean RFC draft** document
4. **Run end script** to clear state
5. **Display completion summary**
6. **Offer next steps**

## Pre-Exit Check

Before generating the draft, run `PLUGIN_PATH/scripts/generate-rfc-draft.sh` to get the completeness signals, then display:

```
GENERATING RFC DRAFT

Completeness check...

Sections drafted: X/8
Options proposed: N
Open questions raised: N
```

If `WARN_FEW_OPTIONS=1`, surface:
```
⚠️  Only 1 option drafted under Proposed Solutions.
    RFCs without alternatives can feel like decisions in disguise.
    Consider adding Option B before sharing — or proceed as-is.
```

If `WARN_NO_OPEN_QUESTIONS=1`, surface:
```
⚠️  No open questions recorded.
    Most RFCs have at least one unresolved point. If everything is
    settled, that's fine — but worth a double-check.
```

If `WARN_MISSING_FOUNDATION=1`, surface:
```
⚠️  Context & Problem and/or Goals appear empty.
    These anchor the whole RFC. The draft will be generated, but
    reviewers may not have enough context to give useful feedback.
```

Then ask:

```json
{
  "questions": [
    {
      "question": "How would you like to proceed?",
      "header": "Generate draft",
      "multiSelect": false,
      "options": [
        {"label": "Generate draft anyway", "description": "Produce the RFC draft with current content"},
        {"label": "Keep editing", "description": "Go back and fill more sections first"},
        {"label": "Cancel", "description": "Stay in RFC mode"}
      ]
    }
  ]
}
```

## Generating the Draft

If user confirms, generate the draft:

1. **Append Draft Summary** to the session file:

```markdown
---

## Draft Summary

**RFC Draft Date:** [timestamp]

**Sections drafted:** X/8

**Options proposed:** N

**Open questions raised:** N

**Author's leaning:** [From Recommendation section, or "None stated"]

**Comments welcome** — this document is a starting point for discussion, not a decision.
```

2. **Update the Status header** at the top of the session file:

Change: `Status: DRAFT — open for comment`
To: `Status: DRAFT — open for comment as of [date]`

3. **Generate RFC draft** (already run above — use the DRAFT_FILE path from its output):

The draft document:
- Removes all `[To be drafted]` placeholders
- Removes `**Section Status:**` markers
- Removes template helper text
- Keeps all actual content intact

4. **Run end script:**
```bash
PLUGIN_PATH/scripts/end-rfc-session.sh
```

5. **Display completion:**

```
RFC DRAFT GENERATED

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Generated files:

  Working document (full session history):
  [session file path]

  RFC draft (ready to share):
  [draft file path]

Summary:
- Sections drafted: X/8
- Options proposed: N
- Open questions raised: N
- Author's leaning: [leaning or "None stated"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RFC mode ended. Normal Claude behavior resumed.
```

## Next Steps

```json
{
  "questions": [
    {
      "question": "What would you like to do next?",
      "header": "Next",
      "multiSelect": false,
      "options": [
        {"label": "Share for review", "description": "Get the draft file path to share with your team"},
        {"label": "Schedule a review meeting", "description": "Plan a session to walk through the options"},
        {"label": "Iterate further", "description": "Start a new RFC session to explore a specific option deeper"},
        {"label": "Done for now", "description": "Exit and revisit later"}
      ]
    }
  ]
}
```

## Important

- This is the ONLY way to exit RFC mode
- Session file (with full history) is preserved after exit
- State file is deleted (session ends)
- The draft is a starting point — it can always be revised
- Claude returns to normal behavior after this command
