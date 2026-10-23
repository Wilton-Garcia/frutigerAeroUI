import SwiftUI

public struct AeroDivider: View {

    private let palette: AeroColorPalette

    public init(palette: AeroColorPalette = AeroColors.skyBlue) {
        self.palette = palette
    }

    public var body: some View {
        // Etched look: a colored line fading at the edges with a white highlight beneath it.
        VStack(spacing: 0) {
            Rectangle()
                .fill(fade(palette.border.opacity(0.6)))
                .frame(height: 1)
            Rectangle()
                .fill(fade(Color.white.opacity(0.9)))
                .frame(height: 1)
        }
    }

    private func fade(_ color: Color) -> LinearGradient {
        LinearGradient(
            colors: [color.opacity(0), color, color.opacity(0)],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

#Preview {
    VStack(spacing: AeroSpacing.md) {
        Text("Above")
        AeroDivider(palette: AeroColors.skyBlue)
        Text("Middle")
        AeroDivider(palette: AeroColors.grass)
        Text("Below")
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
