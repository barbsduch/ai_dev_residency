# Enterprise Skills Hub for Claude Code

Ten [Claude Code skills](https://code.claude.com/docs/en/skills) that make Claude build software to enterprise standards: secure, accessible, tested, fast, compliant, and ready to market.

Clone the repo, open it in Claude Code, and the skills load automatically.

## Skills

| Skill | What it enforces |
|---|---|
| [designing-ux](.claude/skills/designing-ux/SKILL.md) | All UI states, forms, data tables, microcopy, heuristic reviews |
| [building-accessible-ui](.claude/skills/building-accessible-ui/SKILL.md) | WCAG 2.2 AA, keyboard and screen-reader support, ARIA patterns |
| [securing-applications](.claude/skills/securing-applications/SKILL.md) | OWASP Top 10, auth and sessions, secrets, security reviews |
| [protecting-privacy](.claude/skills/protecting-privacy/SKILL.md) | GDPR/CCPA, SOC 2, audit logs, tenant isolation, SSO/SCIM |
| [testing-code](.claude/skills/testing-code/SKILL.md) | Test strategy, regression tests, CI quality gates, definition of done |
| [optimizing-performance](.claude/skills/optimizing-performance/SKILL.md) | Core Web Vitals, databases, caching, observability, SLOs |
| [designing-apis](.claude/skills/designing-apis/SKILL.md) | Contract-first APIs, errors, versioning, webhooks, data models, ADRs |
| [building-ai-features](.claude/skills/building-ai-features/SKILL.md) | LLM evals, RAG, agents, prompt-injection defense, cost control |
| [conducting-user-research](.claude/skills/conducting-user-research/SKILL.md) | Interviews, usability tests, surveys, synthesis, personas |
| [marketing-products](.claude/skills/marketing-products/SKILL.md) | Positioning, landing pages, SEO, funnels, pricing, launches |

## Repo structure

```
CLAUDE.md                      # Loaded every session: which skill to use when
.claude/
  settings.json                # SessionStart hook
  hooks/session-start.sh       # Announces available skills at startup
  skills/<skill-name>/
    SKILL.md                   # Rules, workflow checklist, output template, example
    reference/*.md             # Deep detail, loaded only when needed
    evals.json                 # 3 test scenarios with expected behavior
scripts/validate-skills.sh     # Checks every skill against the authoring rules
Week 1/                        # Tech Fleet assignment submission
```

## How it works
1. **Discovery**: Claude Code reads every skill's `name` and `description` from `.claude/skills/` at startup.
2. **Instructions**: `CLAUDE.md` is loaded into every session and maps tasks to skills.
3. **Startup hook**: `.claude/settings.json` runs `session-start.sh`, which reminds Claude which skills exist.
4. **Progressive disclosure**: Claude loads a `SKILL.md` only when it's relevant, and its `reference/` files only when needed.

Skills follow Anthropic's [skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).

## Use the skills in every project (optional)
```bash
mkdir -p ~/.claude/skills && cp -R .claude/skills/* ~/.claude/skills/
```

## Test
Open a new Claude Code session in this repo and ask *"Build a signup form."* Claude should load `designing-ux`, `building-accessible-ui`, `securing-applications`, and `testing-code`. Each skill's `evals.json` lists more scenarios to try.

## Contribute a skill
1. Create `.claude/skills/<verb-ing-name>/SKILL.md` with `name` and a third-person `description` ("… Use when …").
2. Put long detail in `reference/`, link it from `SKILL.md`, and add `evals.json`.
3. Run `scripts/validate-skills.sh`, then add the skill to `CLAUDE.md` and this README.
