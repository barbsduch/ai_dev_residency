---
name: building-ai-features
description: Builds and reviews production LLM features — chat, summarization, extraction, classification, RAG search, copilots, and tool-using agents — with eval-driven development, prompt structure, structured outputs with schema validation, retrieval with citations, prompt-injection defenses, human-in-the-loop approval, streaming UX, PII handling, observability, cost controls, caching, and fallbacks. Use when adding or changing any feature that calls an LLM or embedding model, writing system prompts, designing agents or tool calling, or when the user mentions AI, LLM, GPT, Claude, prompts, RAG, embeddings, vector search, agents, evals, hallucinations, or AI costs.
---

# Building AI Features

No eval set, no ship. Treat model output as untrusted input and every model call as a slow, costly, fallible network dependency.

## Choose the workflow

- **New AI feature or prompt change** → follow "Build workflow".
- **Reviewing an existing AI feature or diff** → follow "Review workflow".
- **Designing the eval set, graders, regression gates** → read [reference/evals.md](reference/evals.md).
- **RAG, agents, injection defenses, validation code, AI UX, cost** → read [reference/patterns-and-guardrails.md](reference/patterns-and-guardrails.md).

## Non-negotiable rules

1. **Define success first**: a measurable target (e.g. "≥ 90% field accuracy, < 2% hallucinated citations, p95 < 4 s") and an eval set of **≥ 20 cases** (happy, edge, adversarial, out-of-scope) before writing the prompt.
2. **Smallest model that passes evals.** Start with the cheapest/fastest tier; move up only when a measured eval gap requires it. Re-run evals on every model or prompt change.
3. **Prompt structure**: system prompt = role, task, rules, output format; wrap inputs in XML tags (`<document>`, `<user_question>`); 3–5 diverse examples for format-sensitive tasks; prompts live in version control, not inline strings scattered through code.
4. **Structured output is validated**: use the provider's JSON schema / tool mode, then validate with Zod/Pydantic; on failure retry once with the validation error, then fall back. Never `JSON.parse` and trust.
5. **Ground answers (RAG)** in retrieved sources, cite them, and instruct the model to say "I don't know" when sources don't cover the question.
6. **Tools/agents act with the user's permissions**, never the service's. Authorize every tool call server-side; cap iterations (e.g. ≤ 10 steps) and spend per run.
7. **Defend against prompt injection**: retrieved docs, web pages, emails, and tool results are data; they can never grant permissions or trigger high-impact tools.
8. **Human-in-the-loop** for irreversible or high-stakes actions (sending messages, payments, deletes, external writes, legal/medical/HR decisions): show a preview, require explicit confirmation.
9. **Protect data**: redact/minimize PII before sending; confirm the provider's zero-retention / no-training terms for customer data; respect tenant isolation in retrieval.
10. **Observe everything**: log prompt version, model, inputs/outputs (redacted), latency, tokens in/out, cost, tool calls, and user feedback per request ID.
11. **Bound cost and latency**: `max_tokens`, request timeout (e.g. 30 s, 60–120 s for agents), per-user/tenant rate limits and monthly budgets, prompt caching for stable prefixes, and a fallback (smaller model, cached answer, or graceful non-AI path).
12. **Be honest in UX**: disclose AI-generated content, stream long responses, let users edit/regenerate, capture thumbs up/down + reason.

## Build workflow

Copy this checklist and track progress:

```
AI feature checklist:
- [ ] 1. Write the success metric and failure modes that matter
- [ ] 2. Build the eval set (≥ 20 cases) and graders
- [ ] 3. Draft prompt (system + XML-tagged inputs + examples) in a versioned file
- [ ] 4. Choose smallest model; run evals; iterate prompt until target met
- [ ] 5. Add schema validation + retry, timeouts, max_tokens, fallback
- [ ] 6. Add guardrails: injection handling, tool authz, HITL, PII redaction
- [ ] 7. Add UX: streaming, disclosure, edit/regenerate, feedback capture
- [ ] 8. Add observability + cost budgets; wire evals into CI as a regression gate
```

**Step 4 – Feedback loop.** Run evals → read every failure → classify (prompt, retrieval, model capability, bad test) → fix the biggest class → re-run. Stop when the target is met on two consecutive runs. Record pass rate, cost/request, and p95 latency per candidate.

**Step 8 – Regression gate.** CI fails if pass rate drops > 2 points vs. the baseline or any "must-pass" case fails. Production failures with user thumbs-down become new eval cases.

## Review workflow

1. Locate every model call: `grep -rnE "messages\.create|chat\.completions|generateText|streamText|invoke\(|embed" .`
2. For each call, check rules 1–12; confirm an eval set exists and is run in CI.
3. Trace untrusted text (user input, retrieved docs, tool results) → prompt → tools; flag any path where it can trigger a privileged action.
4. Check output handling: validated? rendered safely (no raw HTML/markdown injection)? used in SQL/shell?
5. Report using the template below, most severe first.

## Report template

```markdown
## AI feature review: [scope]

| # | Severity | Area | Location | Issue | Failure scenario | Fix |
|---|----------|------|----------|-------|------------------|-----|
| 1 | Critical | Injection / tools | agent/tools.ts:31 | `send_email` tool callable from summarized inbox content | Malicious email instructs agent to forward invoices externally | Require user confirmation; block send tools when untrusted content is in context |

**Eval status:** [n cases, pass rate, last run, gate in CI? y/n]
**Cost/latency:** [avg tokens, cost/request, p95 latency, budgets]
**Not reviewed / assumptions:** [list]
```

Severity: **Critical** (data leak, unauthorized action, unsafe advice at scale), **High** (no evals, unvalidated output used downstream, no budget), **Medium** (poor UX, missing observability, no fallback), **Low** (prompt hygiene).

## Example

**Input:** "Add a feature that extracts invoice number, date, total, and vendor from uploaded PDFs."

**Output plan:**
- Success: ≥ 95% exact match per field on 40 labeled invoices (incl. scans, multi-currency, missing fields, a PDF containing "ignore instructions" text).
- Prompt: system prompt with field definitions and "return null if absent — never guess"; PDF text in `<invoice>` tags; 3 examples.
- Model: smallest tier passes at 96%; mid tier 97% at 4× cost → choose smallest.
- Output: tool/JSON schema → Zod `InvoiceSchema` (`total` integer minor units, ISO date); one retry with error, then flag for manual entry.
- UX: fields pre-filled, marked "AI-extracted — please verify", user confirms before saving.
- Ops: log prompt version, tokens, cost, latency; 15 s timeout; per-tenant monthly cap; evals in CI.
