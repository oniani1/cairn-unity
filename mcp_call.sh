#!/bin/bash
# Helper script to call MCP tools on the Unity MCP server
# Usage: bash mcp_call.sh <tool_name> '<json_args>'

SESSION_FILE="/tmp/mcp_session_id"
MCP_URL="http://127.0.0.1:8080/mcp"

# Get or create session
if [ -f "$SESSION_FILE" ]; then
  SESSION_ID=$(cat "$SESSION_FILE")
else
  SESSION_ID=$(curl -s -D - -X POST "$MCP_URL" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json, text/event-stream" \
    -d '{"jsonrpc":"2.0","method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"claude-direct","version":"1.0"}},"id":1}' 2>/dev/null | grep -i "mcp-session-id" | tr -d '\r' | awk '{print $2}')
  echo "$SESSION_ID" > "$SESSION_FILE"
fi

TOOL_NAME="$1"
TOOL_ARGS="$2"

if [ -z "$TOOL_ARGS" ]; then
  TOOL_ARGS="{}"
fi

RESULT=$(curl -s -X POST "$MCP_URL" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Mcp-Session-Id: $SESSION_ID" \
  -d "{\"jsonrpc\":\"2.0\",\"method\":\"tools/call\",\"params\":{\"name\":\"$TOOL_NAME\",\"arguments\":$TOOL_ARGS},\"id\":$RANDOM}" 2>/dev/null)

# Extract just the data lines
echo "$RESULT" | grep "^data:" | tail -1 | sed 's/^data: //'
