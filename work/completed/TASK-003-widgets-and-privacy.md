# Task: Home/Lock Screen Widgets & Web Privacy Policy

- **ID:** TASK-003
- **Status:** Completed
- **Owner:** Hyp4tia / Antigravity
- **Area:** Widget & Legal

## Intended outcome

Create a WidgetKit extension displaying year progress metrics, schedule daily midnight reloads, and publish a responsive Privacy Policy on GitHub Pages.

## Completion criteria

- Widget supports Small, Medium, Rectangular, and Inline accessory families.
- Widget reloads automatically at 12:00:00 AM daily.
- Widget matches OLED black / light mode preferences via App Group storage.
- Privacy Policy deployed and returning HTTP 200 on GitHub Pages (`https://hyp4tia.github.io/yearly/`).
- Native `PrivacyPolicyView.swift` accessible from in-app `AboutView`.

## Current progress

- `YearlyWidget` embedded into Xcode project.
- GitHub Pages live and verified at `https://hyp4tia.github.io/yearly/`.
- Native `AboutView` and `PrivacyPolicyView` created.

## Next action

None (completed).

## Blockers

None.

## Sources and decisions

- Links to `DECISIONS.md#DEC-003`.
- Public Site: `https://hyp4tia.github.io/yearly/`.

## Deliverables

- `YearlyWidget/YearlyWidget.swift`
- `Yearly/Views/AboutView.swift`
- `Yearly/Views/PrivacyPolicyView.swift`
- `index.html`

## Completion evidence

- `curl -sI https://hyp4tia.github.io/yearly/` returned HTTP 200 OK.
- Xcode build with embedded `YearlyWidgetExtension.appex` succeeded.
