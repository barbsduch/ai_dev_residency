---
name: marketing-products
description: Creates and reviews product marketing and growth work for software products — positioning statements, ICP and messaging hierarchy, landing pages and conversion copy, SEO (technical, on-page, structured data), privacy-compliant analytics and funnel event plans, activation and onboarding, pricing and packaging, A/B tests, and launch plans — without dark patterns. Use when writing or reviewing marketing pages, homepage or pricing copy, onboarding flows, launch announcements, growth experiments, or tracking plans, or when the user mentions positioning, messaging, conversion, CTA, SEO, signups, activation, retention, churn, pricing, go-to-market, or product launch.
---

# Marketing Products

Clear beats clever. Sell the outcome to a specific customer, prove it, measure it, and never trick anyone.

## Choose the workflow

- **Positioning, messaging, landing page, or copy** → follow "Messaging workflow".
- **Funnel, activation, pricing, experiment, or launch** → follow "Growth workflow".
- **Page section template, headline formulas, before/after copy, SEO checklist** → read [reference/copy-and-landing-pages.md](reference/copy-and-landing-pages.md).
- **Metric definitions, tracking plan, experiment and launch templates, pricing checklist, channels** → read [reference/growth-and-launch.md](reference/growth-and-launch.md).

## Non-negotiable rules

1. **Positioning before copy.** Fill the positioning statement (below) first; every headline must trace back to it.
2. **One ICP per page.** Name the role, company size/industry, trigger event, and the job they're hiring the product for. "Everyone" is not a segment.
3. **Use customer language.** Lift phrases from interviews, reviews, support tickets, and sales calls; avoid internal jargon and buzzwords ("seamless", "revolutionary", "all-in-one", "leverage").
4. **Headlines state an outcome** for the ICP (what changes for them), not a feature or category label. Subhead says how.
5. **Every claim has proof** next to it: number, customer logo/quote with name and role, demo, or screenshot. Unverifiable superlatives ("#1", "best") are removed.
6. **One primary CTA per page/section**, verb + outcome ("Start free trial", "Book a demo"), repeated after each proof block.
7. **SEO basics on every public page**: unique `<title>` ≤ 60 chars, meta description ≤ 155, one `<h1>`, descriptive URLs, alt text, Open Graph tags, JSON-LD, LCP < 2.5 s, CLS < 0.1, INP < 200 ms.
8. **Track a defined funnel** (AARRR) with a written event plan; analytics respect consent (no non-essential cookies before opt-in in GDPR regions), no PII in event properties or URLs.
9. **Activation is designed**, not hoped for: define the aha moment as a measurable event and cut steps between signup and it.
10. **Price on a value metric** customers understand and that grows with their value; good/better/best plus an enterprise tier with SSO, audit logs, SLA, and invoicing.
11. **Experiments**: one variable, written hypothesis, pre-calculated sample size, fixed duration (≥ 1–2 full weeks), no peeking-based stopping.
12. **No dark patterns**: no fake urgency/scarcity, hidden fees, pre-checked opt-ins, confirmshaming, roach-motel cancellation, or fake reviews. Cancel is as easy as signup.

## Positioning statement (April Dunford style)

```
For [ICP: role at company type] who [trigger / pain],
[product] is a [market category]
that [key value / outcome, quantified if possible].
Unlike [competitive alternative — incl. spreadsheets / doing nothing],
we [unique differentiating capability → proof].
```
Build it in order: competitive alternatives → unique attributes → value those enable → customers who care most → market category.

## Messaging workflow

Copy this checklist and track progress:

```
Messaging checklist:
- [ ] 1. Gather inputs: customer quotes, alternatives, proof points, objections
- [ ] 2. Write the positioning statement
- [ ] 3. Build the messaging hierarchy (value prop → 3 pillars → proof per pillar)
- [ ] 4. Draft the page using the section template
- [ ] 5. Run the copy checks below; rewrite failures
- [ ] 6. Add SEO meta, OG tags, JSON-LD; check Core Web Vitals
- [ ] 7. Define the conversion event and an experiment for the headline/CTA
```

**Step 5 – Copy checks (verification loop).** For each section: Is the reader clear who it's for within 5 seconds? Is each claim specific and proven? Is there any jargon a prospect wouldn't say? Is reading level ≤ grade 8? Is there exactly one primary CTA? Rewrite any "no", then re-check.

## Growth workflow

```
Growth checklist:
- [ ] 1. Map the funnel and baseline each stage (see growth-and-launch.md)
- [ ] 2. Find the biggest drop-off weighted by revenue impact
- [ ] 3. Form a hypothesis + ICE score; pick one variable
- [ ] 4. Calculate sample size and duration; write the experiment doc
- [ ] 5. Instrument events per the tracking plan; QA them
- [ ] 6. Run to completion; analyze primary + guardrail metrics
- [ ] 7. Ship, iterate, or revert; log the learning
```

## Output template

```markdown
## [Deliverable]: [product / page]

**ICP:** [role, company type, trigger]
**Positioning:** [statement]
**Messaging hierarchy:** Value prop → Pillar 1/2/3 → proof for each

[Deliverable content: page copy by section / plan / experiment doc]

**Measurement:** [primary conversion event, guardrails, target]
**Risks & assumptions:** [unproven claims, missing proof, compliance notes]
```

## Example

**Input:** "Write a homepage hero for our tool that syncs Jira issues to customer support tickets."

**Output:**
- ICP: Support leads at B2B SaaS companies (50–500 staff) who field "is this bug fixed yet?" tickets.
- Before: "The all-in-one seamless integration platform for modern teams."
- After headline: **"Tell customers when their bug is fixed — automatically."**
- Subhead: "Link Zendesk tickets to Jira issues. When engineering ships the fix, every affected customer gets an update."
- Proof: "Cut 'any update?' tickets by 38% — Priya Shah, Head of Support, Acme" + product screenshot.
- CTA: **Start free 14-day trial** (secondary: "See a 2-min demo").
- Measurement: primary = `signup_completed`; activation = `first_ticket_linked` within 24 h.
