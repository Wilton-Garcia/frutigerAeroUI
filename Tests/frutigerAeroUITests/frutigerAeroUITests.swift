import Testing
import SwiftUI
@testable import frutigerAeroUI

@Test func tokensAreOrdered() {
    #expect(AeroSpacing.xs < AeroSpacing.sm)
    #expect(AeroSpacing.sm < AeroSpacing.md)
    #expect(AeroSpacing.md < AeroSpacing.lg)
    #expect(AeroSpacing.lg < AeroSpacing.xl)

    #expect(AeroRadius.small < AeroRadius.medium)
    #expect(AeroRadius.medium < AeroRadius.large)
    #expect(AeroRadius.large < AeroRadius.extraLarge)
}

@Test func hexParsing() {
    let c = Color(hex: "#FF8000").rgbaComponents
    #expect(abs(c.red - 1) < 0.01)
    #expect(abs(c.green - 0.502) < 0.01)
    #expect(abs(c.blue - 0) < 0.01)

    let invalid = Color(hex: "nope").rgbaComponents
    #expect(invalid.red == 0 && invalid.green == 0 && invalid.blue == 0)
}

@Test func colorMixing() {
    let mid = Color(hex: "#000000").mixed(with: Color(hex: "#FFFFFF"), amount: 0.5).rgbaComponents
    #expect(abs(mid.red - 0.5) < 0.01)

    let clamped = Color(hex: "#000000").mixed(with: Color(hex: "#FFFFFF"), amount: 5).rgbaComponents
    #expect(abs(clamped.red - 1) < 0.01)
}

@MainActor
@Test func derivedPaletteTonesSitBetweenBorderAndBackground() {
    let palette = AeroColorPalette(border: Color(hex: "#000000"), background: Color(hex: "#FFFFFF"))
    let accent = palette.accent.rgbaComponents
    #expect(accent.red > 0 && accent.red < 1)
}

@MainActor
@Test func customAccentIsRespected() {
    let palette = AeroColorPalette(
        border: Color(hex: "#000000"),
        background: Color(hex: "#FFFFFF"),
        accent: Color(hex: "#FF0000")
    )
    #expect(abs(palette.accent.rgbaComponents.red - 1) < 0.01)
    #expect(palette.accent.rgbaComponents.green < 0.01)
}

@MainActor
@Test func progressBarClampsValue() {
    // Construction must not crash for out-of-range values.
    _ = AeroProgressBar(value: -1)
    _ = AeroProgressBar(value: 2)
}
