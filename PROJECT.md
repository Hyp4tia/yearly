# Project: Yearly

This document owns goals, scope, constraints, and success criteria for Yearly. Task records own execution details; `STATUS.md` summarizes them. Confirmed architectural choices and their rationale live in `DECISIONS.md`.

## Purpose and intended outcome

Yearly is a minimalist iOS year-progress tracker that represents every day of the year as a single point of progress. It maps time onto a responsive dot lattice, paired with glanceable Home Screen and Lock Screen widgets, with zero tracking and full offline operation.

## Scope

- **Included:**
  - Native iOS 17+ SwiftUI app with adaptive Canvas dot matrix (`YearGridView.swift`).
  - Home Screen and Lock Screen widgets with automated midnight refresh (`YearlyWidget.swift`).
  - Dark, light, and system appearance modes with pitch OLED black (`#000000`).
  - 100% on-device calculations using native `Calendar` APIs.
  - Apple Privacy Manifest (`PrivacyInfo.xcprivacy`) declaring required-reason APIs.
  - Native in-app and web privacy policy hosted on GitHub Pages (`https://hyp4tia.github.io/yearly/`).
- **Excluded:**
  - Cloud synchronization, user accounts, and remote authentication.
  - Third-party analytics, crash reporting SDKs, or ad frameworks.
  - Push notifications or background network fetch.

## Success criteria

- Clean Xcode compilation with zero build errors or warnings.
- 100% passing automated unit test suite (`YearlyTests`).
- App Store Review Guidelines 2.1, 2.3, 2.5, 4.2, and 5.1 compliance.
- Responsive, high-contrast UI across all device sizes (iPhone and iPad) and all 4 orientations.

## Constraints and stakeholders

- **Platform:** iOS 17.0+ / iPadOS 17.0+.
- **Bundle Identifier:** `com.hyp4tia.Yearly` (App) and `com.hyp4tia.Yearly.YearlyWidget` (Widget).
- **Owner/Team:** Hyp4tia.
- **Privacy:** Strict zero-collection, offline-first.

## Sources and existing material

- Repository: `https://github.com/Hyp4tia/yearly`
- Privacy Policy: `https://hyp4tia.github.io/yearly/` and `PRIVACY_POLICY.md`
- App Implementation: `Yearly/`
- Widget Implementation: `YearlyWidget/`
- Test Suite: `YearlyTests/`
