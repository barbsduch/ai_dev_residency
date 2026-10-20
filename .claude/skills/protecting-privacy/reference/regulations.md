# What engineers must implement per regulation

Engineering guidance, not legal advice. Confirm scope and obligations with counsel.

## Contents
- Scope quick test
- GDPR (EU/UK)
- CCPA / CPRA (California)
- SOC 2
- HIPAA (US health data)
- ISO/IEC 27001
- Cross-regulation control map

## Scope quick test
| Regulation | Applies when |
|------------|--------------|
| GDPR / UK GDPR | You process personal data of people in the EU/UK, or are established there |
| CCPA / CPRA | For-profit, CA residents' data, and >$25M revenue, or buy/sell/share 100k+ consumers, or ≥50% revenue from selling/sharing |
| SOC 2 | Customers ask for an attestation report (typical for B2B SaaS) |
| HIPAA | You are a covered entity or a business associate handling PHI (signs a BAA) |
| ISO 27001 | Customers or markets require certification of your ISMS |

## GDPR (EU/UK)
- **Lawful basis per purpose (Art. 6):** store it with the processing record. Consent must be freely given, specific, granular, and withdrawable as easily as given; store `{user_id, purpose, granted, version, timestamp, source}`.
- **Special categories (Art. 9):** health, biometrics, religion, ethnicity, sexual orientation, politics, union membership → explicit consent or another Art. 9 condition; treat as Restricted.
- **Data subject rights**, respond within 1 month (extendable by 2):
  - Art. 15 access: everything held, purposes, recipients, retention.
  - Art. 16 rectification: user can edit their data.
  - Art. 17 erasure: delete or irreversibly anonymize across primary DB, replicas, search, caches, files, sub-processors; backups expire per rotation (document the window).
  - Art. 18 restriction: flag to freeze processing.
  - Art. 20 portability: machine-readable export (JSON/CSV) of data the user provided.
  - Art. 21 objection: opt-out of direct marketing immediately.
- **Privacy by design/default (Art. 25):** minimization, pseudonymization, most-private settings by default.
- **Records of processing (Art. 30):** maintain a data map (system, fields, purpose, basis, retention, recipients, region).
- **Security (Art. 32):** encryption, access control, tested restores.
- **Breach notification (Art. 33/34):** notify the supervisory authority within 72 hours of awareness → requires audit logs and alerting that make detection possible.
- **DPIA (Art. 35):** for high-risk processing (large-scale special data, profiling, monitoring).
- **International transfers (Ch. V):** SCCs or adequacy; offer EU data residency for enterprise.
- **ePrivacy / cookies:** non-essential cookies and similar storage require prior opt-in.

## CCPA / CPRA (California)
- **Notice at collection:** categories collected and purposes, linked where data is collected.
- **Right to know / access, delete, correct:** respond within 45 days (extendable by 45); verify identity proportionate to sensitivity.
- **Opt-out of sale/sharing:** "Do Not Sell or Share My Personal Information" link; treat `Sec-GPC: 1` as a valid opt-out; cross-context behavioral ads = sharing.
- **Sensitive PI:** "Limit the Use of My Sensitive Personal Information" when used beyond permitted purposes.
- **No dark patterns:** symmetric choices; consent obtained via dark patterns is invalid.
- **Contracts:** service-provider agreements restrict vendors' use of the data.
- **Minors:** opt-in required to sell/share data of consumers under 16.

## SOC 2
Trust Services Criteria: **Security** (required, Common Criteria CC1–CC9), plus optional **Availability, Processing Integrity, Confidentiality, Privacy**. Type I = design at a point in time; Type II = operating effectiveness over a period (typically 3–12 months), so controls must leave evidence.

Engineers implement and keep evidence for:
- Access control: SSO + MFA for all production and admin access; quarterly access reviews; prompt offboarding.
- Change management: PRs with required review, CI checks, no direct pushes to main, deploy logs.
- Logging and monitoring: centralized logs, alerting, retained ≥ 1 year (common auditor expectation).
- Vulnerability management: dependency scanning, patch SLAs (e.g. Critical 7 days, High 30 days), annual pentest.
- Encryption in transit and at rest; key management.
- Backups with restore tests; documented RPO/RTO.
- Incident response plan exercised; vendor risk reviews for sub-processors.

## HIPAA (US health data)
- **PHI** = health info + any of 18 identifiers (name, dates, email, IP, device IDs, etc.). Treat as Restricted.
- **BAA** required with every vendor that touches PHI (cloud, email, logging, analytics, LLM APIs). No BAA → no PHI to that vendor.
- **Security Rule technical safeguards:** unique user IDs, emergency access procedure, automatic logoff, encryption at rest and in transit, audit controls on PHI access, integrity controls, person/entity authentication.
- **Minimum necessary:** role-based access to only the PHI needed.
- **Audit logs** of PHI access retained 6 years (documentation retention requirement).
- **Breach notification:** individuals without unreasonable delay, ≤ 60 days; HHS (and media if 500+ in a state).
- Never put PHI in push notification text, email subjects, URLs, or analytics.

## ISO/IEC 27001
Certification of an Information Security Management System (ISMS) with Annex A controls. Engineering contributions:
- Asset inventory and data classification (A.5.9, A.5.12).
- Access control and privileged access (A.5.15, A.8.2).
- Secure development lifecycle, secure coding, security testing (A.8.25–A.8.29).
- Logging and monitoring (A.8.15, A.8.16); clock synchronization (A.8.17).
- Backup (A.8.13), change management (A.8.32), separation of environments (A.8.31).
- Data masking and leakage prevention (A.8.11, A.8.12). ISO 27701 extends to privacy.

## Cross-regulation control map
| Control | GDPR | CCPA | SOC 2 | HIPAA | ISO 27001 |
|---------|------|------|-------|-------|-----------|
| Data map / inventory | Art. 30 | Notice | CC3 | Risk analysis | A.5.9 |
| Consent / opt-out | Art. 6–7 | Opt-out, GPC | Privacy | Authorization | 27701 |
| Access + deletion (DSAR) | Art. 15–20 | Know/Delete | Privacy | Access right | 27701 |
| RBAC + MFA | Art. 32 | Reasonable security | CC6 | Access control | A.5.15 |
| Audit logs | Art. 33 detection | — | CC7 | Audit controls | A.8.15 |
| Encryption | Art. 32 | Reasonable security | CC6 | Encryption | A.8.24 |
| Vendor contracts | Art. 28 DPA | Service provider | CC9 | BAA | A.5.19 |
| Breach response | 72 h | Breach law | CC7 | ≤ 60 days | A.5.24 |
