# Correct the app icon and About header

- **ID:** TASK-005
- **Status:** completed
- **Owner:** Codex
- **Area:** App icon and About screen

## Intended outcome

Use a full-bleed Yearly progress icon without an inset rounded-square card, and show that icon above “Yearly” in the About screen.

## Completion criteria

- [x] The iOS app icon has no nested rounded-square card.
- [x] The About screen uses the same icon above “Yearly” through a regular image asset.
- [x] Build and all 18 tests pass; light and dark app appearances are checked.
- [x] Changes are committed and pushed.

## Current progress

The current 1024×1024 AppIcon.png contains a white rounded-square card and shadow inside the image. AboutView already requests `Image("AppIcon")`, which is the compiled app icon set and is not available as a normal image asset at runtime. The attached screenshot shows no icon above the title.

## Next action

None.

## Blockers

None confirmed.

## Task-specific user instructions

The user reported that the app icon currently looks like “a box within a box” and asked for the icon above “Yearly” on the About page. The user also requested verification, a commit, and a push.

## Sources and decisions

- User screenshot: `/Users/zeyadhussein/Downloads/Screenshot 2026-10-05 at 1.39.17 AM.png`
- Project rules: `AGENTS.md`
- Current artwork: `Yearly/Assets.xcassets/AppIcon.appiconset/AppIcon.png`
- Current About layout: `Yearly/Views/AboutView.swift`

## Deliverables

- [x] Finished: updated app icon artwork and About screen in `Yearly/Assets.xcassets` and `Yearly/Views/AboutView.swift`.

## Completion evidence

- `xcodebuild -project Yearly.xcodeproj -scheme Yearly -destination "generic/platform=iOS Simulator" -derivedDataPath /tmp/yearly-derived-data build` — succeeded.
- `xcodebuild -project Yearly.xcodeproj -scheme Yearly -destination "platform=iOS Simulator,id=97529C72-58B9-4299-A50A-95EC2EC1A606" -derivedDataPath /tmp/yearly-derived-data test` — succeeded; 18 tests passed, 0 failures.
- Inspected the flattened icon artwork and captured the app in both light appearance and OLED black dark appearance in the iPhone 18 Pro simulator.
- AboutView now loads the icon from the regular `YearlyIcon` image set, since the compiled `AppIcon` set was not available through `Image("AppIcon")`.
