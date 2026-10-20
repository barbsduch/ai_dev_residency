#!/bin/bash
# Validates every skill in .claude/skills against the authoring rules. Exit 1 on any failure.
cd "$(dirname "$0")/.." || exit 1
fail=0
err() { echo "FAIL [$1] $2"; fail=1; bad=1; }
for d in .claude/skills/*/; do
  n=$(basename "$d"); f="$d/SKILL.md"; bad=0
  [ -f "$f" ] || { err "$n" "missing SKILL.md"; continue; }
  name=$(awk '/^---$/{c++; next} c==1 && /^name:/{sub(/^name: */,""); print}' "$f")
  desc=$(awk '/^---$/{c++; next} c==1 && /^description:/{sub(/^description: */,""); print}' "$f")
  [ "$name" = "$n" ] || err "$n" "name '$name' must match folder"
  [[ "$name" =~ ^[a-z0-9-]{1,64}$ ]] || err "$n" "name must be lowercase-hyphens ≤64 chars"
  [[ "$name" =~ (claude|anthropic) ]] && err "$n" "name uses a reserved word"
  [ -n "$desc" ] || err "$n" "missing description"
  [ ${#desc} -le 1024 ] || err "$n" "description is ${#desc} chars (max 1024)"
  echo "$desc" | grep -qi "use when" || err "$n" "description should say when to use it ('Use when ...')"
  lines=$(wc -l < "$f"); [ "$lines" -le 500 ] || err "$n" "SKILL.md is $lines lines (max 500)"
  for ref in $(grep -oE '\(reference/[^)]+\)' "$f" | tr -d '()'); do
    [ -f "$d/$ref" ] || err "$n" "broken link $ref"
  done
  [ -f "$d/evals.json" ] && python3 -c "import json,sys; e=json.load(open(sys.argv[1])); assert len(e)>=3" "$d/evals.json" 2>/dev/null || err "$n" "evals.json missing, invalid, or < 3 scenarios"
  [ $bad -eq 0 ] && echo "ok   [$n] $lines lines"
done
exit $fail
