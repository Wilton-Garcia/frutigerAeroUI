//
//  AeroColorPalette.swift
//  frutigerAeroUI
//

import SwiftUI

/// A glossy color set. Only `border` (deep edge) and `background` (light glass tint)
/// are required; the other tones are derived from them unless provided.
@MainActor
public struct AeroColorPalette {

    /// Deep, saturated edge color.
    public let border: Color
    /// Light glass tint.
    public let background: Color
    /// Mid tone used for the body of glossy surfaces.
    public let accent: Color
    /// Color of text and glyphs placed on top of a solid glossy surface.
    public let foreground: Color

    public init(
        border: Color,
        background: Color,
        accent: Color? = nil,
        foreground: Color = .white
    ) {
        self.border = border
        self.background = background
        self.accent = accent ?? background.mixed(with: border, amount: 0.7)
        self.foreground = foreground
    }

    /// Readable dark tone for text placed on glass or white surfaces.
    public var text: Color {
        border.mixed(with: Color(hex: "#0B2A4A"), amount: 0.45)
    }

    /// The vertical gradient used by solid glossy surfaces.
    public var fillGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: accent.mixed(with: .white, amount: 0.2), location: 0),
                .init(color: accent, location: 0.5),
                .init(color: border.mixed(with: accent, amount: 0.25), location: 0.52),
                .init(color: accent.mixed(with: background, amount: 0.55), location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// The vertical gradient used by translucent glass surfaces.
    public var glassGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.85),
                background.opacity(0.75),
                background.mixed(with: accent, amount: 0.35).opacity(0.85)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
