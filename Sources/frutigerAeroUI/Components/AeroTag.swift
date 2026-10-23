import SwiftUI

public struct AeroTag: View {

    private let title: String
    private let palette: AeroColorPalette
    private let onRemove: (() -> Void)?

    public init(
        _ title: String,
        palette: AeroColorPalette = AeroColors.aqua,
        onRemove: (() -> Void)? = nil
    ) {
        self.title = title
        self.palette = palette
        self.onRemove = onRemove
    }

    public var body: some View {
        HStack(spacing: AeroSpacing.xs) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundColor(palette.text)

            if let onRemove {
                Button(action: onRemove) {
                    Image(systemName: "xmark")
                        .font(.caption2.weight(.bold))
                        .foregroundColor(palette.border)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Remove \(title)")
            }
        }
        .padding(.horizontal, AeroSpacing.sm + 2)
        .padding(.vertical, AeroSpacing.xs + 1)
        .background {
            AeroSurface(Capsule(style: .circular), palette: palette, style: .glass, showsGlow: false)
        }
    }
}

#Preview {
    HStack(spacing: AeroSpacing.sm) {
        AeroTag("Swift", palette: AeroColors.orange)
        AeroTag("SwiftUI", palette: AeroColors.skyBlue, onRemove: {})
        AeroTag("iOS", palette: AeroColors.grass, onRemove: {})
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
