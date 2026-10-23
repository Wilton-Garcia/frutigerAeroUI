import SwiftUI

public struct AeroBadge: View {

    private let text: String
    private let palette: AeroColorPalette

    public init(_ text: String, palette: AeroColorPalette = AeroColors.coral) {
        self.text = text
        self.palette = palette
    }

    public var body: some View {
        Text(text)
            .font(.caption2.weight(.bold))
            .foregroundColor(palette.foreground)
            .shadow(
                color: palette.foreground == .white ? palette.border.opacity(0.85) : .clear,
                radius: 1,
                y: 1
            )
            .padding(.horizontal, AeroSpacing.sm + 2)
            .padding(.vertical, AeroSpacing.xs)
            .background {
                AeroSurface(Capsule(style: .circular), palette: palette, showsGlow: false)
            }
    }
}

#Preview {
    HStack(spacing: AeroSpacing.sm) {
        AeroBadge("New", palette: AeroColors.grass)
        AeroBadge("42", palette: AeroColors.coral)
        AeroBadge("Beta", palette: AeroColors.purple)
        AeroBadge("Sale", palette: AeroColors.orange)
        AeroBadge("Hot", palette: AeroColors.sunshine)
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
