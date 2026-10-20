# Enterprise pattern library

## Contents
- How to read each pattern
- Data tables
- Filters and search
- Bulk actions
- Forms and validation
- Wizards (multi-step flows)
- Navigation and information architecture
- Dashboards
- Settings
- Permissions and no-access states
- Notifications: toasts, banners, inline alerts
- Empty states
- Confirmation and destructive actions
- Onboarding

## How to read each pattern
Each pattern lists **Use when**, **Rules**, **States**, and **Common mistakes**. If a pattern doesn't fit, document why before creating a variant.

## Data tables
**Use when** users compare, scan, sort, or act on many records with shared attributes. Use cards or a list for < ~5 attributes or visual items.
**Rules:** left-align text, right-align numbers with tabular figures; sticky header and first column; default sort stated and meaningful (e.g., most recent); column chooser and resizable columns for 8+ columns; truncate with ellipsis + full value on hover/focus; row click opens detail, and inline actions sit in a trailing "More" menu; pagination (25/50/100) or virtualized scroll for 1,000+ rows - show total count; sort, filters, and page in the URL; comfortable and compact density.
**States:** loading (skeleton rows), first-use empty, no results, error, partial (column data unavailable), row-level error, read-only rows, selected rows, stale data ("Updated 5 min ago").
**Common mistakes:** hover-only actions (invisible to keyboard and touch); horizontal scroll without a sticky key column; centering numbers; losing selection when paging without telling the user.

## Filters and search
**Use when** a collection is larger than one screen. Search for known items; filters for narrowing by attributes.
**Rules:** 3-5 most-used filters visible, rest under "More filters"; applied filters shown as removable chips with "Clear all"; show result count; apply instantly for quick filters, with an Apply button for complex panels; saved views for repeated filter sets; search scope stated in placeholder-plus-label ("Search invoices by number or customer").
**States:** no results (echo query and filters, offer "Clear filters"), loading results (keep old results dimmed), filter options loading, invalid filter value.
**Common mistakes:** filters that reset on navigation; hidden active filters; facet counts that don't match the results.

## Bulk actions
**Use when** users repeat the same action on many records.
**Rules:** checkbox column with header "select all on page" and a banner "Select all 1,240 invoices"; bulk action bar replaces the toolbar and shows the count ("12 selected"); action labels include count ("Archive 12 invoices"); long-running bulk jobs run in background with progress and a summary ("1,198 updated, 42 failed - Download errors"); undo where possible.
**States:** none selected (bar hidden), some selected, all on page, all matching, processing, partial failure.
**Common mistakes:** applying to all matching records when the user meant the page; no partial-failure report; destructive bulk action as the first button.

## Forms and validation
**Use when** collecting or editing data.
**Rules:** single column; visible persistent labels above fields (no placeholder-only); mark required or optional (mark the minority); group related fields with headings; field width hints expected length; validate on blur and on submit, not on every keystroke; error message below the field with icon + text saying how to fix; on submit with errors, show an error summary at top linking to each field and move focus to it; preserve input on error; primary action bottom-left (aligned with fields) with verb + noun label; autosave or unsaved-changes warning for long forms; don't disable submit to signal errors.
**States:** default, focus, filled, error, warning, disabled, read-only, saving, saved, server error.
**Common mistakes:** "Invalid input"; clearing the form on error; asking for information already known (WCAG 3.3.7).

## Wizards (multi-step flows)
**Use when** a task has 3-7 dependent steps, is infrequent, or needs guidance (setup, SSO, imports).
**Rules:** step indicator with names and current step; Back never loses data; save as draft; validate per step; final Review step with edit links; a clear completion page with next steps. Use a single long form instead when users are experts and steps aren't dependent.
**States:** step incomplete, step with errors, skipped optional step, saving draft, completion, failure at final submit (data retained).
**Common mistakes:** > 7 steps; locked step indicator that can't navigate back; no draft for long setups.

## Navigation and information architecture
**Rules:** top-level nav ≤ 7 items grouped by user goal; side nav for apps with many sections, top nav for ≤ 5; workspace/tenant switcher always visible with the current name; breadcrumbs for hierarchies > 2 levels; global search or command palette for 20+ destinations; current location highlighted (not color alone); labels validated with tree testing.
**States:** collapsed/expanded, active item, items hidden or locked by role, badge counts.
**Common mistakes:** nav mirroring the org chart; same label leading to different places; hiding admin areas without a hint for users who need access.

## Dashboards
**Use when** a persona monitors status and decides what to do next.
**Rules:** answer 3-5 named questions for one persona; KPI cards with value, comparison (vs. last period), and trend; every metric links to its detail; date range and data freshness shown; charts from the data-viz palette with labels, not color-only legends; customizable layout only if research shows varied needs.
**States:** loading per card, no data yet, partial (one source failed), stale, no permission for a card.
**Common mistakes:** vanity metrics; 12+ equal-weight cards; numbers without context.

## Settings
**Rules:** split personal vs. workspace/org/admin settings; group by task with a left sub-nav; explain consequences inline; choose save model per page - autosave with "Saved" confirmation for toggles, or explicit Save with unsaved-changes guard for forms; show who changed what and when for admin settings (audit).
**States:** default, changed/unsaved, saving, saved, error, inherited from org (read-only with source "Set by your admin"), locked by plan.
**Common mistakes:** mixing autosave and Save on the same page; settings with no explanation of effect.

## Permissions and no-access states
**Rules:** decide per element: **hide** (user will never need it), **read-only** (can see, can't edit - show value as text), **disabled with reason** (temporarily unavailable), or **no-access page** (navigated to restricted area). No-access page: what this area is, that access is restricted, who can grant it (admin name or "Request access"), and a way back. Never show a 404 for a permission problem in-product, unless revealing existence is itself a security risk.
**States:** viewer, editor, admin, pending access request, plan-locked (upgrade path shown to admins, "Ask your admin" to others).
**Common mistakes:** disabled buttons with no explanation; error only after the user fills a whole form.

## Notifications: toasts, banners, inline alerts
| Type | Use for | Rules |
|---|---|---|
| Toast | Confirmation of a user action ("Invoice sent. Undo") | Bottom or top corner, ≥ 5 s or until dismissed, one action max, announced politely, never the only record of an error |
| Inline alert | Message about a specific section or form | In context, persistent until resolved |
| Banner | System or account-wide status (maintenance, trial ending, degraded service) | Top of page, dismissible unless critical, one at a time |
| Notification center | Async events for later (approval requested, export ready) | Unread count, mark as read, links to object, user preferences |

**Common mistakes:** errors in auto-dismissing toasts; stacking several banners; toasts covering the focused element.

## Empty states
| Type | Content |
|---|---|
| First use | What this area is for + primary action ("Create your first workflow") + optional template, import, or docs link |
| No results | Echo query/filters + "Clear filters" |
| Cleared/done | Positive confirmation ("All caught up") |
| No permission | See permissions pattern |
| Error | What failed + Retry + reference ID |
**Common mistakes:** header-only empty tables; the same message for first use and no results; illustrations with no action.

## Confirmation and destructive actions
**Rules:** prefer undo over confirmation for reversible actions. Confirm only irreversible or high-impact actions; dialog title names the action and object ("Delete 'Q3 report'?"), body states consequences ("This removes it for all 40 members and can't be undone"), buttons are specific ("Delete report" in danger style, "Cancel"); default focus on the safe option; type-to-confirm only for very high impact (delete workspace, revoke all keys).
**Common mistakes:** "Are you sure? OK/Cancel"; confirmation fatigue on every action; danger style on non-destructive buttons.

## Onboarding
**Rules:** role-specific first run (admin setup checklist vs. end-user first task); setup checklist with progress and skippable optional steps; contextual tips at the moment of need, max one at a time, dismissible and never blocking; sample data or templates to show value early; measure activation (first key action), not tour completion.
**States:** not started, in progress, completed, dismissed (recoverable from help menu), invited user vs. account creator.
**Common mistakes:** 8-step product tours on first login; tips that cover the element they describe; onboarding that ignores SSO/SCIM-provisioned users.
