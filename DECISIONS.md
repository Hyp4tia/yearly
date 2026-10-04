# Decisions: Yearly

This document records confirmed architectural, design, and implementation decisions.

## DEC-001: Direct UIWindow overrideUserInterfaceStyle Management

- **Context:** SwiftUI's `.preferredColorScheme(nil)` fails to revert the active window's color scheme back to `.unspecified` in iOS once it has been toggled to `.dark` or `.light`, breaking system theme synchronization.
- **Choice:** Use `WindowStyleModifier` (`UIViewRepresentable`) to manage `window.overrideUserInterfaceStyle` directly (`.unspecified` for System, `.dark` for Dark, `.light` for Light) and remove `.preferredColorScheme`.
- **Consequences:** Resolves the SwiftUI stuck-colorScheme bug. Changing system theme in Control Center or Settings reflects immediately in the app without app restarts.
- **Source:** `Yearly/Support/AppearanceMode.swift`, `ContentView.swift`.

## DEC-002: True OLED Pitch Black Background

- **Context:** Standard UIKit dark background (`.systemBackground`) resolves to dark gray (`#1C1C1E`) rather than true black (`#000000`), draining battery on OLED screens and diminishing contrast.
- **Choice:** Explicitly resolve dark background to pure `Color.black` (`#000000`) and light background to pure `Color.white` (`#FFFFFF`).
- **Consequences:** True OLED pixel turn-off, maximum battery savings, and distinct high-contrast minimalist aesthetic.
- **Source:** User specification; `ContentView.swift`, `YearlyWidget.swift`.

## DEC-003: Daily Midnight Widget Refresh Schedule

- **Context:** Year progress metrics (days remaining, percent complete) increment once every 24 hours at the start of a new calendar day.
- **Choice:** Set WidgetKit timeline reload policy to `policy: .after(nextMidnight)`.
- **Consequences:** Minimal battery and background execution budget consumption while guaranteeing up-to-date Home Screen metrics as soon as the day changes.
- **Source:** `YearlyWidget/YearlyWidget.swift`.

## DEC-004: Apple Privacy Manifest Reason CA92.1

- **Context:** Apple requires declaration of required-reason APIs (specifically `UserDefaults`) in `PrivacyInfo.xcprivacy`.
- **Choice:** Include `NSPrivacyAccessedAPICategoryUserDefaults` with reason `CA92.1` ("Access user defaults to read and write information that is only accessible to the app itself").
- **Consequences:** Guarantees compliance with App Store Connect automated ingest checks without rejection.
- **Source:** `Yearly/PrivacyInfo.xcprivacy`, `YearlyWidget/PrivacyInfo.xcprivacy`.
