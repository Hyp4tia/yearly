---
colors:
  oled-black: "#000000"
  pure-white: "#FFFFFF"
  electric-blue: "#598CFA"
  sapphire-blue: "#3870E6"
  charcoal-pending: "#383838"
  gray-pending: "#E0E0E0"
typography:
  headline: "System Headline Semibold"
  stats-number: "System Rounded Bold (36-44pt)"
  summary-label: "System Footnote Monospaced Digit"
rounded:
  dots: "Circular (50% radius)"
  cards: "18pt continuous"
spacing:
  horizontal-padding: "28pt"
  top-padding: "40pt"
  bottom-padding: "32pt"
components:
  dot-grid: "Canvas ellipse lattice"
  summary-bar: "Capsule accent progress"
---

# Design: Yearly

## Overview

This document owns verified visual tokens and visual rules for Yearly. Values are extracted directly from the Swift codebase and asset catalog.

## Colors

- **Dark Mode Background:** `#000000` (Pure OLED pitch black).
- **Light Mode Background:** `#FFFFFF` (Pure white).
- **Filled Days (Dark Mode):** `#598CFA` / `rgb(0.35, 0.55, 0.98)` (Vibrant electric blue for high contrast against black).
- **Filled Days (Light Mode):** `#3870E6` / `rgb(0.22, 0.44, 0.90)` (Refined sapphire blue).
- **Pending Days (Dark Mode):** `#383838` / `rgb(0.22, 0.22, 0.22)` (Subtle deep charcoal).
- **Pending Days (Light Mode):** `#E0E0E0` / `rgb(0.88, 0.88, 0.88)` (Soft light gray).
- **Navigation Elements:** Pure white in dark mode; pure black in light mode.

## Typography

- **Year Title:** `headline`, `fontWeight: .semibold`.
- **Days Remaining (Summary):** `footnote`, monospaced digit.
- **Widget Large Counter:** `system(size: 38-44, weight: .bold, design: .rounded)`.
- **Widget Captions:** `caption` / `caption2`, `fontWeight: .semibold`.

## Layout

- **Main View:** Vertical stack with `Canvas` grid occupying flexible maximum space and summary pinned to the bottom.
- **Horizontal Margins:** 28pt padding on leading and trailing edges.
- **Grid Density:** Dynamic column and row resolution via `GridMetrics.resolve(days:availableSize:)` ensuring 365/366 dots fit without scrolling on any device.

## Elevation and Depth

- Flat, borderless presentation optimized for edge-to-edge OLED screens. No drop shadows on dots or grid elements.

## Shapes

- **Dots:** Circular ellipses (`Path(ellipseIn:)`) with diameter resolved to `max(4, cell * 0.58)`.
- **Progress Bar:** Continuous capsule shapes with height 5-6pt.

## Do's and Don'ts

- **Do:** Always keep background pure `#000000` in dark mode.
- **Do:** Maintain high contrast between elapsed and pending dots.
- **Don't:** Introduce translucent gray backgrounds behind the main grid.
- **Don't:** Hardcode a 365-day grid; always query `YearProgress` for leap year support.

## Evidence

| Token or rule | Source path/link and symbol/location | Verification notes |
| --- | --- | --- |
| OLED `#000000` | `Yearly/Views/ContentView.swift:23` | `appBackgroundColor` resolves to `.black` in dark mode |
| Electric Blue | `Yearly/Views/YearGridView.swift:10` | `Color(red: 0.35, green: 0.55, blue: 0.98)` |
| Sapphire Blue | `Yearly/Views/YearGridView.swift:11` | `Color(red: 0.22, green: 0.44, blue: 0.90)` |
| Charcoal Pending | `Yearly/Views/YearGridView.swift:16` | `Color(white: 0.22)` |
| Soft Gray Pending | `Yearly/Views/YearGridView.swift:17` | `Color(white: 0.88)` |
| Dot-to-Cell Ratio | `Yearly/Models/GridMetrics.swift:20` | `dotToCellRatio = 0.58`, `minimumDotDiameter = 4` |
