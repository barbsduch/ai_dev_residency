# Foundations and tokens

## Contents
- Token tiers and naming
- Color
- Typography
- Spacing and layout grid
- Elevation, radius, borders
- Motion
- Density modes
- Responsive breakpoints
- Theming (light, dark, high contrast, brand)
- Figma organization: libraries, variables, auto layout, component properties
- Token JSON example
- Common mistakes

## Token tiers and naming
| Tier | Purpose | Example | Who uses it |
|---|---|---|---|
| Primitive (global) | Raw palette and scales | `blue-600`, `space-4`, `radius-2` | Token maintainers only |
| Semantic (alias) | Meaning in the UI | `color.text.primary`, `color.action.primary.bg`, `color.feedback.danger.text`, `space.inset.md` | Designers on screens; components |
| Component | One component's decisions | `button.primary.bg.hover`, `table.row.height.compact` | Component authors |

Naming pattern: `category.concept.property.variant.state` (e.g., `color.action.primary.bg.hover`). Rules: purpose not appearance (`danger`, not `red`); same order everywhere; states as the last segment (`hover`, `pressed`, `disabled`, `focus`); no product or team names in shared tokens.

## Color
Semantic roles to define:
- **Text:** primary, secondary, disabled, inverse, link, on-action.
- **Background/surface:** canvas, surface, surface-raised, surface-sunken, overlay, selected, hover.
- **Border:** default (decorative), input (≥ 3:1 - it identifies a control), strong, focus.
- **Action:** primary, secondary, tertiary/ghost, danger - each with bg, text, border, and hover/pressed/disabled.
- **Feedback:** info, success, warning, danger - each with subtle bg, strong bg, text, icon, border.
- **Data visualization:** categorical (6-8 distinguishable hues), sequential, diverging; tested for color-vision deficiency, with patterns or labels as backup.

Contrast rules (WCAG 2.2 AA): text 4.5:1 (large ≥ 24 px or ≥ 18.66 px bold: 3:1); input borders, icons, focus rings, chart marks 3:1 against adjacent colors. Build primitives as 10-12-step ramps (50-950) with known contrast against white and the darkest neutral so pairs can be chosen by rule (e.g., step 600+ on white passes 4.5:1).

## Typography
| Token | Size / line height | Use |
|---|---|---|
| `type.display` | 32/40 | Rare: marketing-like hero, onboarding |
| `type.heading.lg` | 24/32 | Page title (H1) |
| `type.heading.md` | 20/28 | Section (H2) |
| `type.heading.sm` | 16/24 semibold | Card, panel, dialog title |
| `type.body.md` | 14/20 or 16/24 | Default body; 14 for dense apps |
| `type.body.sm` | 12/16 | Metadata, table secondary text, helper text |
| `type.code` | 13/20 mono | IDs, API keys, code |

Rules: ≤ 6-7 sizes; line height 1.4-1.6 for body; tabular (monospaced) figures in tables and numbers; weights 400/600 (avoid 300 for small text); minimum 12 px; text resizes to 200% without loss.

## Spacing and layout grid
- Scale (4 pt base, 8 pt rhythm): 0, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64.
- Semantic spacing: `space.inset.sm/md/lg` (padding inside components), `space.stack.*` (vertical gaps), `space.inline.*` (horizontal gaps), `space.layout.*` (section gaps).
- Grid: 12 columns desktop, 8 tablet, 4 mobile; gutters 16-24; content max width for reading ~720 px; data-heavy pages may be full width.
- Proximity rule: space inside a group < space between groups.

## Elevation, radius, borders
| Level | Use | Token |
|---|---|---|
| 0 | Page, table rows | `elevation.0` (none, border instead) |
| 1 | Cards, raised panels | `elevation.1` subtle shadow |
| 2 | Dropdowns, popovers, sticky headers | `elevation.2` |
| 3 | Dialogs, drawers | `elevation.3` + scrim |
| 4 | Toasts | `elevation.4` |

Radius scale: `radius.none 0`, `radius.sm 2-4` (inputs, chips), `radius.md 6-8` (cards, buttons), `radius.lg 12-16` (dialogs), `radius.full` (avatars, pills). Dark themes express elevation with lighter surfaces, not only shadows.

## Motion
- Durations: `motion.duration.fast 100 ms` (hover, toggles), `.base 200 ms` (dropdowns, expand), `.slow 300 ms` (dialogs, drawers). Rarely > 400 ms.
- Easing: ease-out for entering, ease-in for exiting, standard ease-in-out for movement.
- Motion explains change (where something came from or went); never decorative loops in work apps.
- Reduced motion: replace movement with fade or instant change; no flashing > 3 per second; auto-moving content > 5 s can be paused.

## Density modes
| Token | Comfortable | Compact |
|---|---|---|
| `table.row.height` | 48 px | 32-36 px |
| `input.height` | 40 px | 32 px |
| `space.inset.md` | 16 px | 12 px |
| `type.body` | 14/20 | 13/18 or 14/20 |

Compact is opt-in per user or per view (power users, operations); comfortable is default. Targets stay ≥ 24 × 24 px in compact. Implement density as a variable mode, not separate components.

## Responsive breakpoints
Example set: `sm < 640`, `md 640-1023`, `lg 1024-1439`, `xl ≥ 1440`. For each component specify: what reflows, what collapses (side nav → drawer, filters → sheet), what is prioritized (table priority columns; others into a row detail), and what never hides (primary action, critical status). Content must work at 320 px width (WCAG 1.4.10); data tables may scroll horizontally with a sticky first column.

## Theming (light, dark, high contrast, brand)
- Themes swap only semantic token values; components never change.
- Every semantic pair is validated for contrast in every theme.
- Dark theme: avoid pure black canvas (use ~#121212-#1A1A1A), desaturate brand colors, raise surfaces by lightness.
- White-label/brand themes for enterprise customers: allow brand color only on `color.action.primary.*` and logo; enforce contrast checks before a customer theme is applied.

## Figma organization: libraries, variables, auto layout, component properties
- **Libraries:** Foundations (variables, styles, icons) → Core components → Patterns/templates → Product-specific libraries. Products consume; only the system team publishes Core.
- **Variables:** collections for Primitives (hidden from publishing), Semantic (modes: Light, Dark, High contrast), Density (modes: Comfortable, Compact), and Breakpoints if used. Scope variables (color variables for fills only, spacing for gap/padding).
- **Auto layout** everywhere: hug for content, fill for containers, gaps and padding bound to spacing variables; min/max width set on inputs and buttons; test with long and translated text.
- **Component properties:** variants for mutually exclusive options (`hierarchy=primary|secondary|tertiary|danger`, `size=sm|md|lg`, `state=default|hover|focus|pressed|disabled|loading`); boolean properties for optional parts (`hasIcon`); text properties for labels; instance swap for icons. Names match code props.
- **Hygiene:** components on pages per category; `_` or `.` prefix for private base components; description and doc link in each component; cover page with status and owner; changelog page.

## Token JSON example
```json
{
  "color": {
    "blue": { "600": { "$value": "#1F5FD1", "$type": "color" } },
    "action": { "primary": { "bg": { "$value": "{color.blue.600}" }, "bg-hover": { "$value": "{color.blue.700}" } } }
  },
  "button": { "primary": { "bg": { "$value": "{color.action.primary.bg}" } } }
}
```
Use the W3C Design Tokens format (`$value`, `$type`, aliases in braces) so tokens sync between Figma variables and code.

## Common mistakes
- Semantic names that describe appearance (`color.blue-button`), which break on rebrand or dark mode.
- Components bound to primitives, so themes can't swap them.
- Too many near-duplicate tokens (`gray-text-2`, `gray-text-alt`); merge or deprecate.
- Density implemented as separate "compact" components that drift.
- Contrast checked in light theme only.
