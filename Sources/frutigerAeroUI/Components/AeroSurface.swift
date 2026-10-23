//
//  AeroSurface.swift
//  frutigerAeroUI
//

import SwiftUI

/// The glossy "glass" primitive every Aero component is built on:
/// gradient body, specular highlight, deep outer edge, white inner rim and a soft colored glow.
public struct AeroSurface<S: InsettableShape>: View {

    public enum Style {
        /// Opaque glossy body (buttons, badges, icons).
        case solid
        /// Translucent frosted body (cards, windows, tags).
        case glass
    }

    public enum Gloss {
        /// Hard-edged highlight covering the top half, like a glossy button.
        case split
        /// Highlight that fades out smoothly, better for tall surfaces.
        case soft
    }

    private let shape: S
    private let palette: AeroColorPalette
    private let style: Style
    private let gloss: Gloss
    private let isPressed: Bool
    private let showsGlow: Bool

    public init(
        _ shape: S,
        palette: AeroColorPalette = AeroColors.skyBlue,
        style: Style = .solid,
        gloss: Gloss = .split,
        isPressed: Bool = false,
        showsGlow: Bool = true
    ) {
        self.shape = shape
        self.palette = palette
        self.style = style
        self.gloss = gloss
        self.isPressed = isPressed
        self.showsGlow = showsGlow
    }

    public var body: some View {
        ZStack {
            switch style {
            case .solid:
                shape.fill(palette.fillGradient)
            case .glass:
                shape.fill(palette.glassGradient)
            }

            highlight

            shape.inset(by: 0.75).stroke(palette.border.opacity(0.9), lineWidth: 1.5)
            shape.inset(by: 2).stroke(Color.white.opacity(0.6), lineWidth: 1)
        }
        .brightness(isPressed ? -0.08 : 0)
        .background {
            if showsGlow {
                shape
                    .fill(palette.border.opacity(isPressed ? 0.2 : 0.35))
                    .blur(radius: 6)
                    .offset(y: isPressed ? 1 : 3)
            }
        }
    }

    @ViewBuilder
    private var highlight: some View {
        let top = style == .solid ? 0.6 : 0.65

        switch gloss {
        case .split:
            shape
                .inset(by: 2)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(top), Color.white.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .mask {
                    VStack(spacing: 0) {
                        Rectangle()
                        Color.clear
                    }
                }
        case .soft:
            shape
                .inset(by: 2)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(top * 0.8), Color.white.opacity(0)],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
        }
    }
}

#Preview {
    VStack(spacing: AeroSpacing.lg) {
        AeroSurface(Capsule(style: .circular), palette: AeroColors.skyBlue)
            .frame(width: 160, height: 44)
        AeroSurface(RoundedRectangle(cornerRadius: AeroRadius.large), palette: AeroColors.grass, style: .glass, gloss: .soft)
            .frame(width: 220, height: 120)
        AeroSurface(Circle(), palette: AeroColors.orange)
            .frame(width: 64, height: 64)
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
