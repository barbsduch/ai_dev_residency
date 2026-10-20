# Product Design Skills Hub

This repo is a library of Claude Code skills for **product designers, UX researchers, UX writers, and design leads** shipping enterprise-ready software. Skills live in `.claude/skills/` and load automatically in any session started inside this repo.

## How to use the skills

Before starting any task, decide which skills apply and load them with the Skill tool. Say which skills you used in your reply.

| Skill | Load when the task involves |
|---|---|
| `writing-interview-guides` | Research plans, screeners, writing/sorting/testing interview questions, consent, note-taking |
| `synthesizing-research` | Notes or transcripts → themes, insights, personas, JTBD, HMWs, research reports |
| `mapping-user-journeys` | Journey maps, experience maps, service blueprints, user flows, task flows |
| `writing-user-stories` | User stories, acceptance criteria, epics, design briefs, PRDs, handoff notes |
| `running-usability-tests` | Usability test plans, tasks, scripts, SUS/SEQ, heuristic evaluations, design accessibility reviews |
| `applying-design-systems` | Tokens, components, states, UI patterns, Figma libraries, component docs, design QA |
| `writing-ux-copy` | Microcopy, error messages, buttons, empty states, voice and tone, content testing |
| `writing-case-studies` | Portfolio case studies, project retrospectives, portfolio presentations |

## Defaults
- Outputs are for designers: tables, templates, and documents ready to paste into Figma, FigJam, Notion, Jira, or slides. No code unless asked.
- Always apply the enterprise lens: multiple roles (end user, admin, buyer, approver), permissions, scale, WCAG 2.2 AA, privacy.
- Any UI work: also apply `applying-design-systems` and `writing-ux-copy`.
- Follow each skill's checklist, quality check, and output template. Ask for missing context only when it blocks the work; otherwise state assumptions.

## Working on the skills themselves
- One folder per skill: `SKILL.md` (≤ 500 lines) + `reference/*.md` (linked one level deep) + `evals.json` (3 scenarios).
- Frontmatter: `name` (lowercase-hyphens, matches folder) and a third-person `description` saying what it does and when to use it.
- Run `scripts/validate-skills.sh` before committing.
