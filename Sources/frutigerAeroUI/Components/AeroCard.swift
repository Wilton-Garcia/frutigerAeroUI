import SwiftUI

public struct AeroCard<Content: View>: View {

    private let palette: AeroColorPalette
    private let padding: CGFloat
    private let content: Content

    public init(
        palette: AeroColorPalette = AeroColors.pearl,
        padding: CGFloat = AeroSpacing.md,
        @ViewBuilder content: () -> Content
    ) {
        self.palette = palette
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background {
                AeroSurface(
                    RoundedRectangle(cornerRadius: AeroRadius.large, style: .circular),
                    palette: palette,
                    style: .glass,
                    gloss: .soft
                )
            }
    }
}

#Preview {
    VStack(spacing: AeroSpacing.md) {
        AeroCard(palette: AeroColors.skyBlue) {
            VStack(alignment: .leading, spacing: AeroSpacing.sm) {
                Text("Hello, Aero UI!")
                    .font(.headline)
                    .foregroundColor(AeroColors.skyBlue.text)
                Text("A glass card component.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        AeroCard(palette: AeroColors.grass) {
            Label("Grass card", systemImage: "leaf.fill")
                .foregroundColor(AeroColors.grass.text)
        }
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
