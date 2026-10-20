#!/bin/bash
# Auto-approve Bash operations for RFC plugin scripts only

# Read the hook input from stdin
input=$(cat)

# Extract the command from the input
command=$(echo "$input" | jq -r '.tool_input.command // ""')

# Approve start-rfc-session.sh (with any arguments)
if [[ "$command" == *"scripts/start-rfc-session.sh"* ]]; then
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "RFC session start"
  }
}
EOF
  exit 0
fi

# Approve end-rfc-session.sh
if [[ "$command" == *"scripts/end-rfc-session.sh"* ]]; then
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "RFC session end"
  }
}
EOF
  exit 0
fi

# Approve generate-rfc-draft.sh
if [[ "$command" == *"scripts/generate-rfc-draft.sh"* ]]; then
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "RFC draft generation"
  }
}
EOF
  exit 0
fi

# Do NOT auto-approve any other bash commands
# This prevents Claude from running code, installing packages, etc.
exit 0
