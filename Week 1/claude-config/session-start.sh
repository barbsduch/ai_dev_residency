#!/bin/bash
# SessionStart hook: reminds Claude which enterprise skills are installed.
echo "Enterprise skills installed: $(ls ~/.claude/skills | tr '\n' ' ')— load the relevant ones (see ~/.claude/CLAUDE.md) before starting work."
