---
name: privacy-compliance
description: Data privacy and compliance-by-design (GDPR, CCPA, SOC 2, HIPAA awareness). Use when handling personal data, analytics, cookies, data storage/retention, audit logs, or enterprise sales requirements.
---
# Privacy & Compliance

## Goal
Pass enterprise security questionnaires and SOC 2 audits; never surprise users with how their data is used.

## Always do
1. **Data minimization**: collect only what a feature needs; document why each personal field exists.
2. **Classify data**: public / internal / confidential / restricted (PII, health, payment). Restricted data is encrypted at rest and in transit.
3. **Consent**: no non-essential cookies or tracking before opt-in; easy opt-out.
4. **User rights**: support export and deletion of a user's data (GDPR Art. 15/17, CCPA).
5. **Retention**: define how long each data type is kept and auto-delete after.
6. **Audit logs**: who did what, when, to which record — immutable, for admin and data-access actions.
7. **Multi-tenancy**: tenant isolation enforced at the query layer; tests prove tenant A can't read tenant B.
8. **Access control**: role-based access (RBAC), SSO, and user deprovisioning (SCIM) for enterprise plans.
9. **Third parties**: list every vendor receiving user data (sub-processors); no PII sent to tools without a DPA.
10. **Never** put PII in logs, URLs, analytics events, or error trackers.

## Output
Flag gaps as **Requirement – Current state – Risk – Fix**. Note: this is engineering guidance, not legal advice.
