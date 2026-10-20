#!/bin/bash
# SessionStart hook: tells Claude which project skills are available at the start of every session.
dir="${CLAUDE_PROJECT_DIR:-.}/.claude/skills"
skills=$(ls "$dir" 2>/dev/null | paste -sd, - | sed 's/,/, /g')
echo "Product design skills available in this repo: ${skills}. Check CLAUDE.md and load the relevant skills before starting any task."
