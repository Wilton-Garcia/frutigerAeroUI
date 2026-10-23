import SwiftUI

/// A decorative soap bubble: transparent body, tinted rim and specular highlights.
public struct AeroBubble: View {

    private let size: CGFloat
    private let palette: AeroColorPalette

    public init(size: CGFloat = 60, palette: AeroColorPalette = AeroColors.skyBlue) {
        self.size = size
        self.palette = palette
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.04),
                            palette.accent.opacity(0.18),
                            palette.accent.opacity(0.5)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: size / 2
                    )
                )

            Circle()
                .strokeBorder(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), palette.accent.opacity(0.3), Color.white.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: max(1, size * 0.03)
                )

            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.9), Color.white.opacity(0.05)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.42, height: size * 0.22)
                .rotationEffect(.degrees(-35))
                .offset(x: -size * 0.17, y: -size * 0.26)

            Ellipse()
                .fill(Color.white.opacity(0.35))
                .frame(width: size * 0.22, height: size * 0.1)
                .rotationEffect(.degrees(-35))
                .offset(x: size * 0.2, y: size * 0.28)
        }
        .frame(width: size, height: size)
        .shadow(color: palette.border.opacity(0.25), radius: size * 0.08, y: size * 0.04)
        .accessibilityHidden(true)
    }
}

#Preview {
    HStack(spacing: AeroSpacing.md) {
        AeroBubble(size: 40)
        AeroBubble(size: 80, palette: AeroColors.grass)
        AeroBubble(size: 120, palette: AeroColors.aqua)
    }
    .padding(40)
    .background(Color(hex: "#5DB6EE"))
}
