# Product Design Skills Hub for Claude Code

Eight in-depth [Claude Code skills](https://code.claude.com/docs/en/skills) for **product designers, UX researchers, UX writers, and design leads** shipping enterprise-ready software. They cover the design workflow from research to shipped UI to telling the story.

Clone the repo, open it in Claude Code, and the skills load automatically.

## The workflow

```
Discover            Define                 Design                     Validate               Tell the story
writing-interview → synthesizing-research → mapping-user-journeys  → running-usability-  → writing-case-studies
  -guides                                  writing-user-stories       tests
                                           applying-design-systems
                                           writing-ux-copy
```

## Skills

| Skill | Helps you |
|---|---|
| [writing-interview-guides](.claude/skills/writing-interview-guides/SKILL.md) | Write, sort, and test interview questions; screeners; consent and notes templates |
| [synthesizing-research](.claude/skills/synthesizing-research/SKILL.md) | Turn notes into themes, evidence-backed insights, personas, JTBD, HMWs, reports |
| [mapping-user-journeys](.claude/skills/mapping-user-journeys/SKILL.md) | Journey maps, service blueprints, user and task flows |
| [writing-user-stories](.claude/skills/writing-user-stories/SKILL.md) | User stories, acceptance criteria, design briefs, handoff notes |
| [running-usability-tests](.claude/skills/running-usability-tests/SKILL.md) | Test plans, tasks, moderator scripts, SUS/SEQ, heuristic and accessibility reviews |
| [applying-design-systems](.claude/skills/applying-design-systems/SKILL.md) | Tokens, components and states, enterprise UI patterns, component docs, design QA |
| [writing-ux-copy](.claude/skills/writing-ux-copy/SKILL.md) | Microcopy, error messages, voice and tone, content testing, string tables |
| [writing-case-studies](.claude/skills/writing-case-studies/SKILL.md) | Portfolio case studies, project retros, portfolio presentations |

## Repo structure

```
CLAUDE.md                      # Loaded every session: which skill to use when
.claude/
  settings.json                # SessionStart hook
  hooks/session-start.sh       # Announces available skills at startup
  skills/<skill-name>/
    SKILL.md                   # Rules, checklist, quality check, output template, example
    reference/*.md             # Templates, question banks, pattern libraries (loaded only when needed)
    evals.json                 # 3 test scenarios with expected behavior
scripts/validate-skills.sh     # Checks every skill against the authoring rules
Week 1/                        # Tech Fleet assignment submission
```

## How it works
1. **Discovery**: Claude Code reads each skill's `name` and `description` from `.claude/skills/` at startup.
2. **Instructions**: `CLAUDE.md` is loaded into every session and tells Claude which skill to use for which task.
3. **Startup hook**: `.claude/settings.json` runs `session-start.sh`, which reminds Claude which skills exist.
4. **Progressive disclosure**: Claude opens a skill's `SKILL.md` only when it's relevant, and its `reference/` files only when needed.

The skills follow Anthropic's [skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).

## Try it
Open a new Claude Code session in this repo and ask:
- *"Write a 45-minute interview guide to understand how IT admins onboard new employees to our tool."*
- *"Turn these interview notes into insights and a persona."*
- *"Write user stories with acceptance criteria for a bulk user-invite feature."*
- *"Rewrite these error messages."*

Each skill's `evals.json` has more scenarios.

## Use the skills in every project (optional)
```bash
mkdir -p ~/.claude/skills && cp -R .claude/skills/* ~/.claude/skills/
```

## Add a skill
1. Create `.claude/skills/<verb-ing-name>/SKILL.md` with `name` and a third-person `description` ("… Use when …").
2. Put long detail in `reference/`, link it from `SKILL.md`, and add `evals.json`.
3. Run `scripts/validate-skills.sh`, then add the skill to `CLAUDE.md` and this README.
