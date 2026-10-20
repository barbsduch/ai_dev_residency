# Copy and landing pages

## Contents
- Messaging hierarchy template
- Landing page section template
- Headline formulas
- Before/after copy examples
- CTA rules
- Proof and social proof
- Writing rules
- Enterprise buyer content
- SEO checklist
- Meta, Open Graph, and JSON-LD snippet

## Messaging hierarchy template
```markdown
Value proposition (one sentence): [outcome] for [ICP] by [how]
| Pillar | Customer pain (their words) | Our capability | Proof |
|--------|-----------------------------|----------------|-------|
| 1. Speed | "We spend Mondays reconciling spreadsheets" | Auto-sync every 5 min | "Saved 6 h/week" — named customer |
| 2. Control | ... | ... | ... |
| 3. Trust | ... | SOC 2 Type II, SSO | Trust page, logos |
Objections → answers: [price, switching cost, security, "we already use X"]
```

## Landing page section template
| # | Section | Purpose | Contents |
|---|---------|---------|----------|
| 1 | Hero | Who it's for + outcome in 5 s | H1 outcome headline, subhead (how), primary CTA, secondary CTA, product visual (real UI, not abstract art) |
| 2 | Social proof bar | Instant credibility | 5–8 recognizable customer logos or a metric ("Used by 2,000 finance teams") |
| 3 | Problem | Show you understand them | 2–3 pains in customer language; cost of the status quo |
| 4 | Solution / how it works | Reduce perceived effort | 3 steps with screenshots |
| 5 | Benefits (pillars) | Map to messaging hierarchy | 3 blocks: benefit headline, 1–2 sentence explanation, proof each |
| 6 | Testimonial / case study | Specific proof | Quote with name, role, company, photo, and a number |
| 7 | Integrations / security | Remove blockers | Integration logos; SOC 2, GDPR, SSO, data residency |
| 8 | Pricing teaser or plans | Qualify | "Free plan available" or link to pricing |
| 9 | FAQ | Handle objections | 5–8 real objections from sales/support |
| 10 | Final CTA | Convert | Restate outcome + primary CTA |

- Above the fold must answer: what is it, who is it for, why should I care, what do I do next.
- Navigation on paid-traffic landing pages: minimal or none (one goal per page).
- Mobile first: CTA visible without scrolling on a 375 px viewport.

## Headline formulas
- **Outcome + timeframe**: "Close your books in 2 days, not 10."
- **Outcome without pain**: "Ship releases without the weekend firefight."
- **Job + for whom**: "Expense reporting your finance team won't have to chase."
- **Replace the alternative**: "Stop reconciling spreadsheets. Start trusting your numbers."
- **Specific number**: "Answer 40% of support tickets before they're created."
- **Question (use sparingly)**: "Still copying data between Jira and Zendesk?"
Test: would a competitor's logo fit under your headline unchanged? If yes, it's not differentiated.

## Before/after copy examples
| Before | Problem | After |
|--------|---------|-------|
| "The next-generation AI-powered platform for modern teams" | Category + buzzwords, no ICP or outcome | "Draft customer replies in seconds, in your brand voice" |
| "Seamless integrations" | Vague | "Connects to Salesforce, HubSpot, and Slack in 2 clicks" |
| "Enterprise-grade security" | Unproven | "SOC 2 Type II audited. SSO/SAML and SCIM on every plan above Starter." |
| "Increase productivity" | Unmeasured | "Teams cut weekly reporting from 6 hours to 30 minutes" |
| "Submit" | Says nothing | "Get my free audit" |
| "Sign up for our newsletter" | Asks, gives nothing | "Get one practical pricing teardown every month" |
| "We're the best solution on the market" | Unverifiable superlative | "Rated 4.8/5 by 1,200 reviewers on G2" (only if true and current) |

## CTA rules
- Verb + outcome, first person often wins: "Start my free trial".
- One primary style per page; secondary CTA visually lighter.
- State friction reducers under it: "No credit card required · Cancel anytime" (only if true).
- PLG: "Start free"; sales-led/enterprise: "Book a demo" / "Talk to sales". Offer both when ACV spans tiers.
- Button contrast ≥ 4.5:1; target ≥ 44×44 px.

## Proof and social proof
Strongest → weakest: quantified case study with named customer → video testimonial → named quote with role/photo → logos → review ratings → anonymous quote.
- Get written permission for every logo and quote.
- Numbers need source and context ("38% fewer tickets in 90 days, Acme, 2024 internal data").

## Writing rules
- Second person ("you"), active voice, present tense.
- Sentences ≤ 20 words; paragraphs ≤ 3 lines; grade 6–8 reading level (Hemingway, Flesch-Kincaid).
- Specific > general: numbers, names, timeframes.
- Features → benefits with "so that": "Auto-sync every 5 min **so that** forecasts are never stale."
- Remove: "very", "really", "solution", "leverage", "best-in-class", "seamless", "robust", "cutting-edge".
- Read it aloud; if you wouldn't say it to a customer, rewrite.

## Enterprise buyer content
- Security/trust page: certifications (SOC 2, ISO 27001), DPA, subprocessor list, data residency, SSO/SCIM, uptime/SLA, pen-test summary on request.
- Role-specific pages: economic buyer (ROI, TCO), technical evaluator (architecture, APIs, docs), end user (workflow, UX).
- ROI calculator inputs must be editable and assumptions shown.

## SEO checklist
**Technical**
- [ ] HTTPS; canonical URL on every page; one indexable version (www or apex).
- [ ] `robots.txt` doesn't block important paths; XML sitemap submitted (Search Console, Bing Webmaster).
- [ ] Server-rendered or statically generated marketing pages (content in initial HTML).
- [ ] Core Web Vitals pass: LCP < 2.5 s, INP < 200 ms, CLS < 0.1 (75th percentile, field data).
- [ ] Images: modern formats (AVIF/WebP), explicit width/height, lazy-load below the fold.
- [ ] No broken links/redirect chains; 301 for moved pages; custom 404.
- [ ] `hreflang` for localized pages.

**On-page**
- [ ] One primary keyword/intent per page; mapped to avoid cannibalization.
- [ ] `<title>` ≤ 60 chars, keyword near front, brand at end.
- [ ] Meta description ≤ 155 chars, benefit + CTA.
- [ ] Single `<h1>`; logical `<h2>`/`<h3>` hierarchy.
- [ ] Short, descriptive URL slugs (`/pricing`, `/integrations/salesforce`).
- [ ] Descriptive alt text; internal links with descriptive anchor text.
- [ ] Content answers search intent better than current top results (comparison, how-to, template).

**Content plan**
- Bottom-funnel first: "[competitor] alternative", "[product] vs [competitor]", "[category] for [industry]", integration pages, templates.
- Then mid/top funnel: how-to guides around the job-to-be-done.

## Meta, Open Graph, and JSON-LD snippet
```html
<title>Jira–Zendesk Sync for Support Teams | Linkly</title>
<meta name="description" content="Link support tickets to Jira issues and update customers automatically when bugs are fixed. Start a free 14-day trial.">
<link rel="canonical" href="https://www.linkly.example/">
<meta property="og:type" content="website">
<meta property="og:title" content="Tell customers when their bug is fixed — automatically">
<meta property="og:description" content="Link Zendesk tickets to Jira issues. Updates go out when engineering ships.">
<meta property="og:image" content="https://www.linkly.example/og/home.png"> <!-- 1200×630 -->
<meta property="og:url" content="https://www.linkly.example/">
<meta name="twitter:card" content="summary_large_image">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "Linkly",
  "applicationCategory": "BusinessApplication",
  "operatingSystem": "Web",
  "offers": { "@type": "Offer", "price": "0", "priceCurrency": "USD", "description": "Free 14-day trial" },
  "publisher": { "@type": "Organization", "name": "Linkly", "url": "https://www.linkly.example", "logo": "https://www.linkly.example/logo.png" }
}
</script>
```
- Add `FAQPage` JSON-LD only for FAQs visible on the page; `aggregateRating` only with real, on-page reviews.
- Validate with Google's Rich Results Test and the Schema.org validator.
