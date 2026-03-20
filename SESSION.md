## Active Project
Unity Experiment — Autonomous AI Agent

## Current State
Last completed: Full scene bootstrap + CLAUDE.md consciousness prompt
Currently attempting: N/A — setup complete
Next action: Say "go" to begin Epoch 1

## Key Decisions
- Unity project lives at Agent/ subfolder (created via Unity Hub)
- MCP tools accessed via mcp_call.sh helper (direct HTTP to port 8080) because Claude Code's built-in coplay-mcp tools have a bridge issue
- UI uses UI Toolkit (UXML) instead of legacy Canvas — ThoughtPanel.uxml on ObserverUI
- GroundMat pre-created so agent can use it on first boot

## Blockers
- None — ready for first epoch
