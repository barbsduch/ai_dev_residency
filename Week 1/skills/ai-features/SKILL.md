---
name: ai-features
description: Building production AI/LLM features (Claude API, RAG, agents, tool use, evals, guardrails, cost control). Use whenever adding AI to a product or writing prompts for users.
---
# AI Features

## Goal
AI features that are reliable, measurable, safe, and affordable — not demos.

## Always do
1. **Define success first**: what does a good output look like? Write 20+ example inputs with expected outputs (your eval set) before tuning prompts.
2. **Pick the smallest model that passes evals**; use the latest Claude models; cache repeated prompt prefixes (prompt caching).
3. **Structured outputs**: request JSON matching a schema and validate it; retry or fall back on failure.
4. **Ground answers (RAG)**: retrieve from trusted sources, cite them, say "I don't know" when sources are missing.
5. **Guardrails**: treat user input and retrieved content as untrusted (prompt injection); never let model output run code, SQL, or actions without validation and permission checks.
6. **Human in the loop** for high-stakes actions (sending, paying, deleting).
7. **UX**: stream responses, show sources, allow edit/regenerate/feedback (👍/👎), label AI-generated content.
8. **Privacy**: no customer data to providers without agreements; strip PII where possible.
9. **Observe**: log prompts, outputs, latency, token cost, and user feedback; track eval scores per release.
10. **Budget**: set max tokens, timeouts, rate limits, and per-tenant cost caps.

## Output
Every AI feature ships with: eval set, pass-rate, cost per request, and failure fallback.
