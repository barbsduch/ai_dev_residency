# Heuristic evaluation and design accessibility review

## Contents
- Heuristic evaluation procedure
- Nielsen's 10 heuristics with enterprise examples
- Severity rubric for expert reviews
- Cognitive walkthrough
- Designer accessibility review of mockups
- Accessibility annotation checklist for handoff
- Report format
- Common mistakes

## Heuristic evaluation procedure
1. Brief 3-5 evaluators: persona, role/permission level, 2-4 primary tasks, scope (screens and states).
2. Each evaluator works alone: pass 1 walks the tasks; pass 2 inspects every screen and state against the heuristics.
3. Log: screen, element, heuristic, issue, why it matters for this persona, severity (independent).
4. Merge into one list; average severities; discuss differences ≥ 2.
5. One evaluator finds about 35% of issues; five find about 75%. Heuristic review complements, never replaces, testing with users.

## Nielsen's 10 heuristics with enterprise examples
| # | Heuristic | Enterprise violation | Better |
|---|---|---|---|
| H1 | Visibility of system status | Bulk import of 10,000 records shows a spinner with no progress; user re-uploads and creates duplicates | Determinate progress, "You can leave this page - we'll notify you", completion summary with error count |
| H2 | Match between system and the real world | Field labeled `acct_stat_cd`, statuses "P1/P2" | "Account status: Active / Past due"; use the customer's domain terms and locale formats |
| H3 | User control and freedom | Removing a user from a workspace has no undo | Undo toast for 10 s; soft delete with restore for 30 days |
| H4 | Consistency and standards | Three different date pickers and "Delete", "Remove", "Discard" meaning the same thing | One design-system component per job; one term per concept |
| H5 | Error prevention | Free-text field for a cost center code that must match a list | Searchable select; validate on blur; disable impossible combinations with explanation |
| H6 | Recognition rather than recall | User must remember a ticket ID from another screen to link it | Autocomplete with recent items; show selected filters as chips |
| H7 | Flexibility and efficiency of use | Approving 50 requests requires 50 detail-page visits | Multi-select + bulk approve, keyboard shortcuts, saved views, compact density |
| H8 | Aesthetic and minimalist design | Dashboard with 14 equal-weight cards and decorative charts | 3-5 KPIs that answer the persona's question, details on drill-down |
| H9 | Help users recognize, diagnose, and recover from errors | "Error 403" when an analyst opens an admin page | "Only workspace admins can change billing. Ask Jane Smith (admin) or request access." |
| H10 | Help and documentation | Help is a link to a 60-page PDF | Contextual "Learn more" at the field, inline examples, consistent help location |

Enterprise extras worth checking under H1-H9: role-based states (what a viewer vs. admin sees), audit visibility ("Changed by Ana, 2 h ago"), scale (1,000+ rows, long names, 40-character translations), multi-tenant context ("Which workspace am I in?").

## Severity rubric for expert reviews
| Score | Label | Use when |
|---|---|---|
| 0 | Not a problem | Evaluators disagree on reflection |
| 1 | Cosmetic | Polish; no effect on task |
| 2 | Minor | Slows or confuses occasionally; easy recovery |
| 3 | Major | Likely task failure, frequent errors, or a WCAG AA failure on a secondary path |
| 4 | Catastrophic | Blocks a primary task, risks data loss or wrong irreversible action, compliance exposure, WCAG A/AA failure on a primary path |

Expert-review severities are predictions; label them "predicted" and confirm 3s and 4s with users where possible.

## Cognitive walkthrough
Best for first-time and infrequent tasks (setup, SSO configuration, quarterly reports). For each step of the correct action sequence, answer yes/no with a reason:
1. Will the user try to achieve the right effect? (Do they know this step is needed?)
2. Will the user notice that the correct action is available? (Is it visible, not hidden in a menu?)
3. Will the user associate the correct action with the effect they want? (Does the label match their goal words?)
4. If the correct action is performed, will the user see that progress is being made? (Feedback, state change?)

Any "no" is a finding; write the failure story ("An IT admin wouldn't know SCIM must be enabled before SSO because...").

## Designer accessibility review of mockups
Reviewable in Figma before any code. Cite the WCAG 2.2 success criterion for every failure.

**Color and contrast**
- [ ] Body text ≥ 4.5:1 against its background (1.4.3); large text (≥ 24 px regular or ≥ 18.66 px bold) ≥ 3:1.
- [ ] UI component boundaries (inputs, checkboxes, toggles), icons that carry meaning, chart lines, and focus indicators ≥ 3:1 against adjacent colors (1.4.11).
- [ ] Placeholder, disabled-looking-but-active, and helper text meet 4.5:1 if users must read them.
- [ ] Color is never the only signal (1.4.1): errors have icon + text; status chips have text labels; chart series have patterns, markers, or direct labels; links in body text are underlined.
- [ ] Check both themes (light, dark) and states (hover, selected, error) - each state color must still pass.

**Focus and keyboard (annotated)**
- [ ] Focus order annotated and matches visual/reading order (2.4.3); dialogs and drawers trap focus and return it on close.
- [ ] Focus indicator designed for every interactive component, visible (2.4.7) and not hidden by sticky headers, footers, or toasts (2.4.11). Recommended: 2 px solid outline with ≥ 3:1 contrast and 2 px offset.
- [ ] Every mouse interaction has a keyboard equivalent; drag-to-reorder has a non-drag alternative such as move up/down buttons (2.5.7).

**Targets and layout**
- [ ] Targets ≥ 24 × 24 CSS px or spaced so a 24 px circle doesn't overlap a neighbor (2.5.8); aim for 44 × 44 on touch-first screens.
- [ ] Layout reflows at 320 px width (1.4.10) and survives 200% text resize (1.4.4) without truncating essential content; data tables may scroll horizontally.

**Labels, content, and structure**
- [ ] Every input has a visible, persistent label (not placeholder-only) and required fields are marked in text (3.3.2).
- [ ] Icon-only buttons have an annotated accessible name; tooltips are not the only label.
- [ ] Heading levels annotated (one H1, no skipped levels); landmarks noted (header, nav, main).
- [ ] Error messages are text, next to the field, and say how to fix (3.3.1, 3.3.3); form doesn't ask for info already entered (3.3.7).
- [ ] Login doesn't require memorizing or transcribing codes without a paste/password-manager-friendly alternative (3.3.8).
- [ ] Help appears in a consistent location across pages (3.2.6).
- [ ] Images and charts have alt text or a data-table alternative annotated.

**States**
- [ ] Hover, focus, active, disabled, selected, error, loading, and read-only designed and distinguishable without color alone.
- [ ] Loading and toast messages annotated as announced (status) or urgent (alert); toasts stay ≥ 5 s or until dismissed and don't hold the only copy of important info.
- [ ] Motion: no flashing > 3 times per second; animations have a reduced-motion alternative; auto-advancing carousels can be paused.

## Accessibility annotation checklist for handoff
Annotate on a dedicated layer or page: focus order numbers, accessible names for icon buttons, heading levels, landmarks, live-region announcements, keyboard behavior for custom widgets (arrows, Esc, Enter), alt text, and error-message wiring. Pair with the `building-accessible-ui` skill for engineering requirements.

## Report format
```markdown
## Expert review: [flow] - [heuristic evaluation + accessibility]
Persona and tasks: [...] · Evaluators: [n] · Predicted severities
| # | Severity | Heuristic / WCAG | Screen > element | Issue | Impact on persona | Recommendation |
|---|---|---|---|---|---|---|
| 1 | 4 | 1.4.11 Non-text contrast | Login > input border | #D0D5DD on white = 1.5:1 | Low-vision users can't find fields | Border token color.border.input at ≥ 3:1 (#8A94A6) |
Strengths: [...] · Validate with users: [list of predicted 3s and 4s]
```

## Common mistakes
- Logging the same issue under three heuristics, inflating the count.
- Reviewing only the happy path; skipping empty, error, loading, and no-permission states.
- Checking contrast on the default state only, not hover, disabled-looking, or dark theme.
- Calling a mockup "accessible" without focus order and accessible-name annotations.
- Presenting expert-review severities as user-validated facts.
