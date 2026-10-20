# Enterprise Skills Hub

This repo is a library of Claude Code skills for building enterprise-ready software. Skills live in `.claude/skills/` and load automatically in any session started inside this repo.

## How to use the skills

Before starting any task, decide which skills apply and load them with the Skill tool. Say which skills you used in your reply.

| Skill | Load when the task involves |
|---|---|
| `designing-ux` | UI screens, flows, forms, tables, states, microcopy, UX reviews |
| `building-accessible-ui` | Any UI code or design; WCAG, keyboard, screen readers, contrast |
| `securing-applications` | Auth, user input, data access, secrets, APIs, uploads, security reviews |
| `protecting-privacy` | Personal data, analytics, cookies, retention, audit logs, tenancy, SOC 2/GDPR |
| `testing-code` | New features, bug fixes, refactors, CI, code review |
| `optimizing-performance` | Page speed, queries, caching, jobs, monitoring, deploys, SLOs |
| `designing-apis` | Endpoints, schemas, data models, webhooks, service boundaries, ADRs |
| `building-ai-features` | LLM features, prompts, RAG, agents, evals, AI guardrails |
| `conducting-user-research` | Interviews, usability tests, surveys, personas, competitive analysis |
| `marketing-products` | Positioning, landing pages, copy, SEO, funnels, pricing, launches |

## Defaults
- Any code change: apply `securing-applications` and `testing-code` at minimum.
- Any UI change: also apply `designing-ux` and `building-accessible-ui`.
- Follow each skill's workflow checklist and output template. Run tests and report real results.

## Working on the skills themselves
- One folder per skill: `SKILL.md` (≤ 500 lines) + `reference/*.md` (linked one level deep) + `evals.json` (3 scenarios).
- Frontmatter: `name` (lowercase-hyphens, matches folder) and a third-person `description` saying what it does and when to use it.
- Run `scripts/validate-skills.sh` before committing.
