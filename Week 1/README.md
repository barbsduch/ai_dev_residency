# Week 1 — Claude Skills for Enterprise-Ready Software

Ten Claude Code skills that make Claude build to enterprise standards every session.

| # | Skill | Focus |
|---|---|---|
| 1 | [ux-design](skills/ux-design/SKILL.md) | States, forms, tables, microcopy |
| 2 | [accessibility](skills/accessibility/SKILL.md) | WCAG 2.2 AA |
| 3 | [security](skills/security/SKILL.md) | OWASP Top 10, auth, secrets |
| 4 | [privacy-compliance](skills/privacy-compliance/SKILL.md) | GDPR/CCPA, SOC 2, audit logs, tenancy |
| 5 | [testing-quality](skills/testing-quality/SKILL.md) | Test pyramid, CI, definition of done |
| 6 | [performance-reliability](skills/performance-reliability/SKILL.md) | Core Web Vitals, SLOs, observability |
| 7 | [api-architecture](skills/api-architecture/SKILL.md) | API contracts, versioning, data model |
| 8 | [ai-features](skills/ai-features/SKILL.md) | LLM evals, RAG, guardrails, cost |
| 9 | [user-research](skills/user-research/SKILL.md) | Interviews, JTBD, synthesis |
| 10 | [marketing-growth](skills/marketing-growth/SKILL.md) | Positioning, landing pages, SEO, funnels |

## How it's wired
- `skills/*` → symlinked into `~/.claude/skills/` (Claude auto-discovers user skills).
- `claude-config/CLAUDE.md` → symlinked to `~/.claude/CLAUDE.md` (loaded at the start of every session; tells Claude when to use each skill).
- `claude-config/session-start.sh` + `settings.json` → a SessionStart hook that reminds Claude of the installed skills on startup.

## Install on another machine
```bash
mkdir -p ~/.claude/skills
for d in "Week 1"/skills/*/; do ln -sfn "$PWD/${d%/}" ~/.claude/skills/; done
ln -sfn "$PWD/Week 1/claude-config/CLAUDE.md" ~/.claude/CLAUDE.md
```

## Test
Start a new Claude Code session and ask: *"Which enterprise skills do you have?"* or *"Build a signup form"* — Claude should load ux-design, accessibility, and security.
