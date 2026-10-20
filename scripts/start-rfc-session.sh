#!/bin/bash
# Start an RFC session - creates state file and session markdown file

# Get topic from argument or use default
TOPIC="${1:-untitled}"
TOPIC_SLUG=$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')
TIMESTAMP=$(date +"%Y%m%d-%H%M")
SESSION_FILE="./rfc-${TOPIC_SLUG}-${TIMESTAMP}.md"

# Check for source brainstorm file (optional second argument)
SOURCE_BRAINSTORM="${2:-}"

# Create state file in current directory
STATE_FILE="./.rfc-state"

# Define all RFC sections (8 total)
ALL_SECTIONS="context_problem,goals,non_goals,proposed_solutions,tradeoffs,open_questions,prior_art,recommendation"

# Write state
cat > "$STATE_FILE" << EOF
RFC_ACTIVE=1
SESSION_FILE=$SESSION_FILE
SOURCE_BRAINSTORM=$SOURCE_BRAINSTORM
TOPIC=$TOPIC
STARTED=$TIMESTAMP
CURRENT_SECTION=context_problem
COMPLETED_SECTIONS=
TOTAL_SECTIONS=8
OPTION_COUNT=0
ALL_SECTIONS=$ALL_SECTIONS
EOF

# Create session markdown file with template
cat > "$SESSION_FILE" << EOF
# RFC: $TOPIC
Status: DRAFT — open for comment
Created: $(date +"%Y-%m-%d %H:%M")
Source brainstorm: ${SOURCE_BRAINSTORM:-None}

> This document is a Request for Comments. Nothing here is a final decision.
> Sections may be incomplete, options may be contradictory, and open questions
> are an asset, not a defect.

---

## 1. Context & Problem

*What's the situation, and what's the underlying tension we're trying to address?*

*Who is affected, and why is this worth writing an RFC for?*

[To be drafted — describe the current state, who is affected, and what makes this problem worth exploring.]

**Section Status:** NOT STARTED

---

## 2. Goals

*What outcomes would we consider success? Stay outcome-focused, not solution-focused.*

- [Goal 1 — what does success look like?]
- [Goal 2]

**Section Status:** NOT STARTED

---

## 3. Non-Goals

*What is explicitly out of scope, and why? Naming non-goals prevents scope drift.*

- [Non-goal 1 — and why it's excluded or deferred]

**Section Status:** NOT STARTED

---

## 4. Proposed Solutions

*At least two options must be drafted. RFCs without alternatives are not RFCs.*

### Option A: [name]

**Sketch:** [How this approach works at a high level]

**Assumptions:** [What this option assumes to be true]

**What we'd need to build:** [Rough shape — not a spec]

### Option B: [name]

**Sketch:** [How this approach works at a high level]

**Assumptions:** [What this option assumes to be true]

**What we'd need to build:** [Rough shape — not a spec]

<!-- Add Option C, Option D, ... as more emerge during discussion. -->

**Section Status:** NOT STARTED

---

## 5. Trade-offs

*For each option, what do we gain and what do we give up?*

| Dimension | Option A | Option B |
|---|---|---|
| Complexity | | |
| Time to ship | | |
| Reversibility | | |
| Operational cost | | |
| User impact | | |
| Risk | | |

**Section Status:** NOT STARTED

---

## 6. Open Questions

*Things we don't know yet. Naming these explicitly is the point of an RFC.*

- [ ] [Question 1 — what do we need to find out?]
- [ ] [Question 2]

**Section Status:** NOT STARTED

---

## 7. Prior Art & Related Work

*What have others tried? What's already in the codebase or industry that informs this?*

[To be drafted. If you've looked and found nothing relevant, write "None known" — don't leave a placeholder.]

**Section Status:** NOT STARTED

---

## 8. Recommendation (Optional, Non-Binding)

*If the author has a leaning, capture it here — but it's a starting point for discussion, not a decision.*
*This section may be left empty.*

**Leaning:** [Option X, or "no recommendation yet"]

**Why:** [Brief rationale for the leaning]

**What would change my mind:** [The conditions under which this leaning would flip]

**Section Status:** NOT STARTED

---

## Appendix: Comments & Revisions

*Reviewers — leave inline notes here as the RFC evolves.*

EOF

echo "SESSION_FILE=$SESSION_FILE"
echo "STATE_FILE=$STATE_FILE"
