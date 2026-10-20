---
description: Analyze the RFC for gaps, missing options, weak trade-offs, and tone issues.
---

# RFC Review

The user wants a review of their RFC draft to surface gaps and issues.

## Actions

1. **Read the entire session file**
2. **Analyze each section** against the RFC checklist
3. **Check overall RFC health** (option count, open question count, tone)
4. **Present findings**

## Review Checklist

### Context & Problem
- [ ] Problem framed without presupposing the solution?
- [ ] Affected parties named explicitly (people, teams, systems)?
- [ ] Underlying tension or difficulty articulated?
- [ ] Scope clear enough to know what the RFC is and isn't addressing?

### Goals
- [ ] Outcome-focused (not solution-focused)?
- [ ] Measurable enough that we'd know if we hit them?
- [ ] Not redundant with the proposed solutions?

### Non-Goals
- [ ] Anything tempting we should call out as deferred?
- [ ] Each non-goal has a brief rationale (why excluded, not just what)?

### Proposed Solutions
- [ ] At least two meaningfully different options present?
- [ ] Each option has: Sketch, Assumptions, What we'd need to build?
- [ ] Options are *genuinely different* (not just variations of the same idea)?
- [ ] No option is clearly a strawman designed to lose?
- [ ] New options could be added — is the framing open enough?

### Trade-offs
- [ ] Each option has at least one concrete downside named?
- [ ] Reversibility considered for each option?
- [ ] Trade-off table covers dimensions that matter for this decision?
- [ ] No option looks uniformly better than all others — if so, the trade-offs may be understated?

### Open Questions
- [ ] At least one question recorded?
- [ ] Are any "decided" claims hiding unanswered questions underneath?
- [ ] Questions are specific enough that someone could own answering them?

### Prior Art & Related Work
- [ ] Codebase checked for existing approaches?
- [ ] Industry/community prior art considered?
- [ ] If "None known" — is that based on actual investigation, or just a placeholder?

### Recommendation (if present)
- [ ] Framed as a leaning, not a decision ("we should" vs "I lean toward")?
- [ ] "What would change my mind" filled in?
- [ ] Recommendation is one of the named options (not a fourth thing that wasn't analyzed)?

### Overall Tone
- [ ] No "must", "shall", "required to" language (RFC proposes, doesn't decree)?
- [ ] No single option presented as obviously correct without trade-off analysis?
- [ ] Ambiguity named rather than papered over?
- [ ] Reader invited to disagree or add options?

## Display Format

```
RFC REVIEW

Analyzing your RFC for gaps and weak spots...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GAPS (missing required content):

  [Section]: [What's missing]
  → Suggestion: [How to address]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WEAK SPOTS (could use more depth):

  [Section]: [What's underdeveloped]
  → Suggestion: [How to strengthen]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TONE FLAGS (reads like a decision, not a proposal):

  "[Quoted sentence]"
  → Consider rewording as: "[Softer alternative]"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SUMMARY:
- Gaps: X
- Weak spots: X
- Tone flags: X
- Options proposed: N (strong RFC has ≥2)
- Open questions: N (strong RFC has ≥1)
- Ready to share: [YES / ALMOST — address gaps first]
```

## After Review

Use AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "How would you like to address these findings?",
      "header": "Next",
      "multiSelect": false,
      "options": [
        {"label": "Fix gaps", "description": "Work through missing content one by one"},
        {"label": "Add another option", "description": "Strengthen Proposed Solutions with a new alternative"},
        {"label": "Surface open questions", "description": "Move hidden assumptions into Open Questions"},
        {"label": "Generate draft anyway", "description": "Proceed with current state — gaps noted"}
      ]
    }
  ]
}
```

## Important

- Be constructive — gaps are normal in draft RFCs
- Tone flags are the most important finding: a RFC that sounds like a PRD will stifle discussion
- Do NOT write code
- Stay in RFC mode
