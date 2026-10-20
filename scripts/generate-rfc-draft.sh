#!/bin/bash
# Generate a clean RFC draft document from the working session file

set -e

# Get session file from argument or state file
if [ -n "$1" ]; then
    SESSION_FILE="$1"
elif [ -f "./.rfc-state" ]; then
    SESSION_FILE=$(grep "SESSION_FILE=" "./.rfc-state" | cut -d'=' -f2)
else
    echo "ERROR=No session file specified and no active RFC session"
    exit 1
fi

if [ ! -f "$SESSION_FILE" ]; then
    echo "ERROR=Session file not found: $SESSION_FILE"
    exit 1
fi

# Generate output filename (replace timestamp suffix with -DRAFT)
DRAFT_FILE=$(echo "$SESSION_FILE" | sed 's/-[0-9]\{8\}-[0-9]\{4\}\.md$/-DRAFT.md/')

# If the pattern didn't match, just append -DRAFT before .md
if [ "$DRAFT_FILE" = "$SESSION_FILE" ]; then
    DRAFT_FILE="${SESSION_FILE%.md}-DRAFT.md"
fi

# Process the file:
# 1. Remove "**Section Status:** ..." lines
# 2. Remove standalone placeholder lines "[To be drafted...]"
# 3. Remove italic helper/instruction lines
# 4. Replace placeholder table cells with empty cells
# 5. Clean up multiple consecutive blank lines
cat "$SESSION_FILE" | \
    grep -v '^\*\*Section Status:\*\*' | \
    sed '/^\[To be drafted.*\]$/d' | \
    sed 's/| \[To be drafted[^|]*\] /| - /g' | \
    sed '/^\*[A-Z][^*]*\*$/d' | \
    sed '/^Source brainstorm: /d' | \
    cat -s \
    > "$DRAFT_FILE"

# Completeness checks (warn-and-proceed — never block)
WARN_FEW_OPTIONS=0
WARN_NO_OPEN_QUESTIONS=0
WARN_MISSING_FOUNDATION=0

# Count Option headings under Proposed Solutions
OPTION_COUNT=$(grep -c '^### Option ' "$SESSION_FILE" 2>/dev/null || echo 0)
if [ "$OPTION_COUNT" -lt 2 ]; then
    WARN_FEW_OPTIONS=1
fi

# Count unchecked open questions
OPEN_QUESTION_COUNT=$(grep -c '^- \[ \]' "$SESSION_FILE" 2>/dev/null || echo 0)
if [ "$OPEN_QUESTION_COUNT" -eq 0 ]; then
    WARN_NO_OPEN_QUESTIONS=1
fi

# Check Context and Goals have non-placeholder content
CONTEXT_CONTENT=$(sed -n '/^## 1\. Context/,/^## 2\./p' "$SESSION_FILE" | grep -v '^\[To be drafted' | grep -v '^\*\*Section Status' | grep -v '^## ' | grep -v '^$' | grep -v '^\*[A-Z]' | head -3)
GOALS_CONTENT=$(sed -n '/^## 2\. Goals/,/^## 3\./p' "$SESSION_FILE" | grep -v '^\[' | grep -v '^\*\*Section Status' | grep -v '^## ' | grep -v '^$' | grep -v '^-\s*\[' | head -3)
if [ -z "$CONTEXT_CONTENT" ] || [ -z "$GOALS_CONTENT" ]; then
    WARN_MISSING_FOUNDATION=1
fi

echo "DRAFT_FILE=$DRAFT_FILE"
echo "SOURCE_FILE=$SESSION_FILE"
echo "OPTION_COUNT=$OPTION_COUNT"
echo "OPEN_QUESTION_COUNT=$OPEN_QUESTION_COUNT"
echo "WARN_FEW_OPTIONS=$WARN_FEW_OPTIONS"
echo "WARN_NO_OPEN_QUESTIONS=$WARN_NO_OPEN_QUESTIONS"
echo "WARN_MISSING_FOUNDATION=$WARN_MISSING_FOUNDATION"
