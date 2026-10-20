#!/bin/bash
# Auto-approve WebSearch during active RFC sessions

STATE_FILE="./.rfc-state"

# Only auto-approve if RFC session is active
if [ -f "$STATE_FILE" ]; then
  source "$STATE_FILE"
  if [ "$RFC_ACTIVE" = "1" ]; then
    cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "RFC session - web search for prior art and context research"
  }
}
EOF
    exit 0
  fi
fi

# Don't interfere with other operations
exit 0
