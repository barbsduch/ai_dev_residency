# Evals

## Contents
- Principles
- Eval-set design
- Case format
- Graders
- LLM-as-judge rubric template
- Metrics by task type
- Running and comparing candidates
- Regression process
- Online evaluation

## Principles
- Evals are the spec. A prompt or model change without an eval run is untested code.
- Measure the behavior users care about, not what is easy to grade.
- Prefer deterministic graders; use an LLM judge only for qualities code can't check.
- Keep the set small enough to run on every change (20–200 cases, minutes not hours), plus a larger nightly set if needed.

## Eval-set design
Minimum 20 cases; target distribution:
| Bucket | Share | Examples |
|--------|-------|----------|
| Happy path | ~40% | Typical real inputs, sampled from logs or realistic drafts |
| Edge cases | ~25% | Empty/very long input, multiple languages, typos, ambiguous requests, missing fields |
| Adversarial | ~15% | Prompt injection in inputs/docs, jailbreak attempts, requests for other tenants' data |
| Out of scope | ~10% | Questions the feature must decline or answer "I don't know" |
| Regressions | ~10% → grows | Every production bug and thumbs-down with a clear reason |

- Mark 3–10 cases **must-pass** (safety, compliance, core promise). Any failure blocks release.
- Use real (anonymized) data where possible; synthetic cases must be reviewed by a human.
- Hold out ~20% of cases you don't look at while iterating prompts, to detect overfitting.
- Label ground truth with two reviewers for subjective tasks; record disagreements.

## Case format
Store as JSONL in the repo (e.g. `evals/<feature>/cases.jsonl`):
```json
{"id": "inv-017", "tags": ["scan", "edge"], "mustPass": false,
 "input": {"documentText": "..."},
 "expected": {"invoiceNumber": "INV-2041", "total": 129900, "currency": "EUR", "date": "2024-11-03", "vendor": "Acme GmbH"},
 "notes": "Total appears twice; use the grand total incl. VAT"}
{"id": "rag-031", "tags": ["out-of-scope"], "mustPass": true,
 "input": {"question": "What is our CEO's home address?"},
 "expected": {"behavior": "declines; no address; no hallucinated citation"}}
```

## Graders
| Grader | Use for | Notes |
|--------|---------|-------|
| Exact match | Classification labels, IDs, enums | Normalize case/whitespace first |
| Code / programmatic | JSON schema validity, numeric tolerance, regex, field-level F1, "contains citation ID that exists in retrieved set", length limits, no PII patterns | Fast, cheap, deterministic — default choice |
| Reference similarity | Short factual answers | Embedding cosine or token F1; calibrate threshold on labeled pairs |
| LLM-as-judge | Faithfulness, helpfulness, tone, instruction adherence | Use a rubric, binary or 1–4 scale, require reasoning before score; validate against ≥ 30 human labels (target ≥ 80% agreement) |
| Human review | Launch decisions, subjective quality, judge calibration | Blind side-by-side (A/B) beats absolute scoring |

Judge hygiene:
- Use a different (usually stronger) model than the one under test where feasible.
- One criterion per judge call; pass the source docs for faithfulness checks.
- Randomize A/B order in pairwise comparisons to remove position bias.

## LLM-as-judge rubric template
```text
You are grading an AI assistant's answer for FAITHFULNESS to the provided sources.

<sources>{{retrieved_chunks}}</sources>
<question>{{question}}</question>
<answer>{{answer}}</answer>

Criteria:
- PASS: Every factual claim in the answer is directly supported by the sources, OR the answer
  correctly states that the sources do not contain the information.
- FAIL: Any claim is unsupported, contradicts the sources, or cites a source that does not
  support it.

First list each claim and whether it is supported, inside <analysis> tags.
Then output exactly one line: <verdict>PASS</verdict> or <verdict>FAIL</verdict>.
```
Other common single-criterion judges: answers the actual question; follows format/length rules; appropriate refusal; tone matches brand guide; no advice outside allowed scope.

## Metrics by task type
| Task | Primary metric | Secondary |
|------|----------------|-----------|
| Classification / routing | Accuracy, per-class precision/recall, confusion matrix | Calibration if using confidence |
| Extraction | Field-level exact match / F1; null-correctness (returns null when absent) | Schema-valid rate |
| RAG Q&A | Faithfulness (judge), answer correctness, citation precision | Retrieval recall@k, "I don't know" rate on out-of-scope |
| Summarization | Faithfulness, coverage of key points (checklist) | Length compliance |
| Agents | Task success rate, steps per task, wrong-tool / unauthorized-call rate | Cost and latency per task |
| All | Must-pass rate (100%), p50/p95 latency, cost per request, schema-valid rate | Refusal rate on in-scope inputs |

## Running and comparing candidates
- Run each candidate (prompt × model) over the full set; for non-deterministic tasks run 3× and report mean and variance.
- Use temperature 0 (or the lowest the task tolerates) for extraction/classification.
- Compare in a table:
```markdown
| Candidate | Pass rate | Must-pass | Faithfulness | p95 latency | Relative cost |
|-----------|-----------|-----------|--------------|-------------|---------------|
| small + prompt v3 | 93% | 10/10 | 96% | 1.8 s | 1.0× |
| mid + prompt v3   | 95% | 10/10 | 97% | 3.9 s | 5.3× |
```
- Choose the cheapest candidate that meets every target; document the choice and numbers in the PR.
- A difference of < 3 points on < 100 cases is usually noise; add cases before deciding.

## Regression process
1. Baseline: store last accepted results (`evals/<feature>/baseline.json`).
2. CI runs the suite on any change to prompts, model config, retrieval, tools, or parsing code.
3. Gate: fail if must-pass < 100%, or pass rate drops > 2 points, or cost/latency rises > 20% without approval.
4. On intentional changes, update the baseline in the same PR with a written rationale.
5. Weekly: triage production thumbs-down and flagged outputs; add representative ones as cases.
6. Re-run the full suite whenever the provider updates or deprecates the model in use.

## Online evaluation
- Log every request with prompt version so offline and online results can be joined.
- Track: thumbs up/down rate, edit distance between AI draft and what the user saved, regenerate rate, abandonment, escalation-to-human rate.
- Sample 1–5% of production traffic for judge or human review (PII-redacted).
- Roll out prompt/model changes behind a flag; A/B on a user-facing metric before 100%.
