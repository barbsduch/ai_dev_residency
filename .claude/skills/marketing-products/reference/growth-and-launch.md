# Growth and launch

## Contents
- Funnel metrics (AARRR)
- North Star and benchmarks
- Event tracking plan template
- Privacy-compliant analytics
- Activation and onboarding
- Experiment template and sample size
- Prioritization (ICE)
- Pricing and packaging
- Pricing page checklist
- Launch plan template
- Channel playbook
- Dark patterns to avoid

## Funnel metrics (AARRR)
| Stage | Metric | Definition |
|-------|--------|------------|
| Acquisition | Visitor → signup rate | `signup_completed` users / unique visitors, by channel |
| Acquisition | CAC | Sales + marketing spend ÷ new paying customers (same period) |
| Activation | Activation rate | Signups reaching the aha event within N days ÷ signups |
| Activation | Time-to-value (TTV) | Median time from `signup_completed` to aha event |
| Retention | Wk-N / Mo-N retention | Cohort users active (core action) in week/month N ÷ cohort size |
| Retention | Logo churn / NRR | Customers lost ÷ customers at start; (start MRR + expansion − contraction − churn) ÷ start MRR |
| Referral | Viral coefficient (K) | Invites sent per user × invite conversion rate |
| Revenue | Trial → paid / Free → paid | Converted accounts ÷ trial or free accounts in cohort |
| Revenue | ARPA, LTV | MRR ÷ accounts; ARPA × gross margin ÷ monthly churn |
| Revenue | LTV:CAC, payback | Target LTV:CAC ≥ 3; CAC payback ≤ 12–18 months (B2B SaaS) |

Always segment by acquisition channel, plan, company size, and signup cohort.

## North Star and benchmarks
- North Star metric = the core value delivered, counted per period (e.g. "tickets auto-updated per week"), not revenue or signups.
- Use benchmarks only as orientation; your own historical baseline is the comparison that matters.
- Report activation and retention as cohort curves, not blended averages.

## Event tracking plan template
Naming: `object_action` in snake_case, past tense (`project_created`). Properties snake_case. Same name across web, mobile, backend.
| Event | Trigger (exact) | Properties | Source | Funnel stage |
|-------|-----------------|------------|--------|--------------|
| `page_viewed` | Marketing page load (after consent) | `path`, `referrer`, `utm_source`, `utm_medium`, `utm_campaign` | Web | Acquisition |
| `signup_started` | Signup form first focus | `method` (email/google/sso) | Web | Acquisition |
| `signup_completed` | Account created server-side | `method`, `plan`, `account_id` | Backend | Acquisition |
| `onboarding_step_completed` | Each checklist step done | `step_name`, `step_index` | Web | Activation |
| `first_ticket_linked` *(aha)* | First successful link | `integration`, `seconds_since_signup` | Backend | Activation |
| `teammate_invited` | Invite sent | `invite_count`, `role` | Backend | Referral |
| `trial_started` / `subscription_started` | Billing provider webhook | `plan`, `interval`, `mrr` | Backend | Revenue |
| `subscription_cancelled` | Cancellation confirmed | `plan`, `reason` (picklist) | Backend | Retention |

Rules: track revenue and key conversions server-side; identify with internal `user_id`/`account_id` (never email); QA every event in a debug view before launch; keep the plan in the repo and update it in the same PR as the code.

## Privacy-compliant analytics
- Consent banner in EU/UK: equal-weight "Accept" and "Reject"; no non-essential cookies/pixels before consent; honor Global Privacy Control.
- Prefer cookieless/first-party analytics for basic traffic; load ad pixels only after marketing consent.
- No PII (email, name, phone, free text) in event properties, URLs, or UTM params.
- Set data retention (e.g. 14–26 months); list analytics vendors in the privacy policy and subprocessor list.
- Respect unsubscribe immediately; double opt-in for newsletters in strict jurisdictions; marketing email requires consent or legitimate interest per region (CAN-SPAM, GDPR/PECR, CASL).

## Activation and onboarding
- **Find the aha moment**: compare retained vs. churned cohorts; pick the early action most correlated with Week-4 retention (e.g. "linked 3 tickets in first 7 days"). Validate with interviews.
- **Cut time-to-value**: remove every signup field not needed now (email + password/SSO only); defer billing; use templates/sample data; offer import.
- **Onboarding checklist**: 3–5 steps ending at the aha event; progress indicator; each step one click to start.
- **Empty states** teach and offer a one-click action, never a blank screen.
- **Lifecycle email**: welcome (immediate) → nudge to aha (day 1, 3) → value recap (day 7) → trial-ending (3 days and 1 day before). Triggered by behavior, stopped once the goal is met.
- **Enterprise onboarding**: SSO/SCIM setup guide, admin console tour, CSV/API import, named CSM above a set ACV.

## Experiment template and sample size
```markdown
# EXP-NNN: [Name]
Hypothesis: Because [evidence], we believe [change] for [segment] will increase [primary metric]
by [minimum detectable effect], because [reason].
Variable changed (one): [e.g. hero headline]
Primary metric: [e.g. visitor → signup_completed]
Guardrails: [activation rate, refund rate, page load time, unsubscribe rate]
Baseline rate: [x%]   MDE (relative): [y%]   Power: 80%   Significance: 5% (two-sided)
Sample size per variant: [n]   Traffic/day: [t]   Duration: [max(n×variants/t, 14 days)]
Segments to check (pre-registered): [device, new vs returning, channel]
Decision rule: Ship if primary is significant and no guardrail degrades > [z%].
Result: [ ]   Learning: [ ]
```
Sample size per variant ≈ `16 × p(1−p) / (p × MDE_rel)²`. Example: baseline 4%, detect +20% relative (to 4.8%) → 16 × 0.0384 / 0.008² ≈ 9,600 visitors per variant.
- Don't stop early on a "significant" peek; run full weeks to cover weekday cycles.
- If traffic is too low for the MDE, test bigger changes, use qualitative methods (5-second tests, user interviews), or test further up the funnel.
- Check sample ratio mismatch (expected 50/50 split off by > 1% → investigate before reading results).

## Prioritization (ICE)
Score each idea 1–10 on **Impact** (on the metric), **Confidence** (evidence strength), **Ease** (effort); rank by average. Revisit scores after each experiment.

## Pricing and packaging
- **Value metric**: the unit that scales with customer value and is easy to predict — seats (collaboration tools), usage (API calls, messages, GB), or outcomes (contacts, transactions). Avoid metrics that punish adoption.
- **Good / Better / Best**: 3 self-serve tiers + Enterprise. Each tier targets a distinct segment; anchor with the middle tier highlighted as "Most popular".
- **Gate by segment need, not by crippling core value**: advanced admin, automation, and compliance features move up tiers; the core job works on every tier.
- **Enterprise tier**: SSO/SAML, SCIM, audit logs, role-based permissions, data residency, SLA (e.g. 99.9%), DPA, security review support, invoicing/PO, annual contracts, dedicated support — "Contact sales".
- **Free plan vs trial**: free plan when the product spreads virally or has low marginal cost; time-boxed trial (14 days typical) when value is clear quickly; reverse trial (full features then downgrade) to show premium value.
- Annual discount typically ~15–20% (state it as "2 months free").
- Validate with willingness-to-pay research (Van Westendorp, conjoint) before big changes; grandfather existing customers or give ≥ 30 days notice of price increases.

## Pricing page checklist
- [ ] 3–4 plans side by side; recommended plan highlighted.
- [ ] Price, billing interval, and value metric unambiguous ("€15 per user / month, billed annually").
- [ ] Monthly/annual toggle shows savings; taxes/fees disclosed.
- [ ] Each plan: who it's for (one line), top 5 differentiators, one CTA.
- [ ] Full feature comparison table below the fold.
- [ ] Usage overage rules and limits stated plainly.
- [ ] FAQ: billing, cancellation, refunds, data export, security, discounts (nonprofit, education).
- [ ] Enterprise column: "Contact sales" + list of enterprise capabilities.
- [ ] Social proof near CTAs; trust badges (SOC 2, GDPR).
- [ ] No hidden fees, no pre-selected add-ons, cancellation path stated.

## Launch plan template
```markdown
# Launch: [Feature/Product]   Tier: [1 major / 2 notable / 3 minor]   Owner: [ ]
Goal & metric: [e.g. 500 activated accounts in 30 days]
ICP + message: [positioning line, 3 pillars]
Assets: [landing page, demo video, screenshots/GIFs, docs, changelog, blog post, email, social posts, sales one-pager, FAQ for support]

T-4 weeks: positioning signed off; beta customers recruited; quotes/case study secured
T-2 weeks: assets drafted; tracking plan instrumented and QA'd; sales/support enablement
T-1 week:  press/analyst/partner briefings (Tier 1); schedule emails & posts; feature flag ready
Launch day: flag on → publish page/blog/changelog → email → social → communities (Product Hunt, HN, relevant subreddits/Slack groups, per their rules) → monitor
T+1 week:  metrics review vs goal; collect feedback; fix top friction
T+30 days: retrospective; decide next iteration
Rollback plan: [flag off criteria and owner]
```
Tier guide: Tier 1 = new product/major capability (all channels, press); Tier 2 = significant feature (blog, email, in-app, social); Tier 3 = improvement (changelog, in-app tooltip).

## Channel playbook
| Channel | Best for | Key tactic | Primary metric |
|---------|----------|------------|----------------|
| SEO / content | Durable demand capture | Bottom-funnel pages first (alternatives, comparisons, integrations, templates) | Organic signups |
| Paid search | High-intent capture | Exact-match competitor/category terms → dedicated landing pages | CAC, signup rate |
| Paid social (LinkedIn) | B2B targeting by role/company | Lead magnets, retargeting, account lists | Cost per qualified lead |
| Lifecycle email | Activation, expansion | Behavior-triggered sequences | Activation, upgrade rate |
| In-product | Expansion, referral | Contextual upgrade prompts at limits, invite prompts after aha | Upgrade/invite rate |
| Partnerships / marketplaces | Distribution via ecosystems | Listing + co-marketing with integration partners | Installs → activated |
| Community / dev rel | Developer and practitioner trust | Docs, examples, open-source, events | Signups from community |
| Outbound sales | Enterprise ACV | ICP account lists + relevant trigger events | Meetings → pipeline |
Start with 1–2 channels that fit the ICP and ACV; prove repeatable CAC before adding more.

## Dark patterns to avoid
| Pattern | Do instead |
|---------|-----------|
| Fake countdown/scarcity | Real deadlines only, stated with dates |
| Pre-checked marketing opt-ins | Unchecked, separate consent |
| Confirmshaming ("No, I like losing money") | Neutral decline ("No thanks") |
| Hidden costs revealed at checkout | All-in price shown upfront |
| Hard-to-cancel (phone-only, buried) | Self-serve cancel in ≤ 3 clicks; offer pause/downgrade once, not repeatedly |
| Auto-renew without notice | Remind before annual renewals and trial conversion |
| Fake/incentivized reviews without disclosure | Real, disclosed reviews only |
Regulators (FTC, EU consumer protection, UK CMA) actively enforce these; they also destroy trust and retention.
