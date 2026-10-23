import SwiftUI

public struct AeroProgressBar: View {

    private let value: Double
    private let palette: AeroColorPalette
    private let height: CGFloat

    /// - Parameter value: Progress from 0.0 to 1.0
    public init(
        value: Double,
        palette: AeroColorPalette = AeroColors.grass,
        height: CGFloat = 18
    ) {
        self.value = min(max(value, 0), 1)
        self.palette = palette
        self.height = height
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule(style: .circular)
                    .fill(Color.white.opacity(0.65))
                    .overlay {
                        Capsule(style: .circular)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [palette.border.opacity(0.45), .clear],
                                    startPoint: .top,
                                    endPoint: .center
                                ),
                                lineWidth: 3
                            )
                    }
                    .overlay {
                        Capsule(style: .circular).strokeBorder(palette.border.opacity(0.8), lineWidth: 1.5)
                    }

                if value > 0 {
                    AeroSurface(Capsule(style: .circular), palette: palette, showsGlow: false)
                        .frame(width: max(height, geometry.size.width * value))
                }
            }
        }
        .frame(height: height)
        .accessibilityElement()
        .accessibilityValue("\(Int(value * 100)) percent")
    }
}

#Preview {
    VStack(spacing: AeroSpacing.md) {
        AeroProgressBar(value: 0.25, palette: AeroColors.skyBlue)
        AeroProgressBar(value: 0.5, palette: AeroColors.grass)
        AeroProgressBar(value: 0.75, palette: AeroColors.orange, height: 12)
        AeroProgressBar(value: 1.0, palette: AeroColors.aqua)
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
