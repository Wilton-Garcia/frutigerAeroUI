import SwiftUI

/// A Windows-Vista-style glass window: translucent frame, title bar with caption buttons
/// and a bright content pane.
public struct AeroWindow<Content: View>: View {

    private let title: String
    private let systemImage: String?
    private let palette: AeroColorPalette
    private let content: Content

    public init(
        _ title: String,
        systemImage: String? = nil,
        palette: AeroColorPalette = AeroColors.skyBlue,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.systemImage = systemImage
        self.palette = palette
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: AeroSpacing.xs + 2) {
            titleBar
            content
                .padding(AeroSpacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: AeroRadius.small, style: .circular)
                        .fill(Color.white.opacity(0.78))
                        .overlay {
                            RoundedRectangle(cornerRadius: AeroRadius.small, style: .circular)
                                .strokeBorder(palette.border.opacity(0.6), lineWidth: 1)
                        }
                }
        }
        .padding(.horizontal, AeroSpacing.sm - 1)
        .padding(.bottom, AeroSpacing.sm - 1)
        .padding(.top, AeroSpacing.xs)
        .background {
            AeroSurface(
                RoundedRectangle(cornerRadius: AeroRadius.medium, style: .circular),
                palette: palette,
                style: .glass,
                gloss: .soft
            )
        }
    }

    private var titleBar: some View {
        HStack(spacing: AeroSpacing.xs + 2) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(palette.text)
            }

            Text(title)
                .font(.callout.weight(.semibold))
                .foregroundColor(palette.text)
                .shadow(color: .white.opacity(0.9), radius: 3)
                .lineLimit(1)

            Spacer(minLength: AeroSpacing.sm)

            captionButton("minus", palette: AeroColors.skyBlue)
            captionButton("square", palette: AeroColors.skyBlue)
            captionButton("xmark", palette: AeroColors.coral, isWide: true)
        }
        .padding(.top, AeroSpacing.xs)
        .padding(.horizontal, AeroSpacing.xs)
    }

    private func captionButton(_ systemImage: String, palette: AeroColorPalette, isWide: Bool = false) -> some View {
        ZStack {
            AeroSurface(
                RoundedRectangle(cornerRadius: 5, style: .circular),
                palette: palette,
                showsGlow: false
            )
            Image(systemName: systemImage)
                .font(.system(size: 8, weight: .heavy))
                .foregroundColor(.white)
                .shadow(color: palette.border, radius: 1)
        }
        .frame(width: isWide ? 30 : 22, height: 18)
        .accessibilityHidden(true)
    }
}

#Preview {
    AeroWindow("My Computer", systemImage: "desktopcomputer", palette: AeroColors.skyBlue) {
        VStack(alignment: .leading, spacing: AeroSpacing.sm) {
            Text("Welcome to the future")
                .font(.headline)
                .foregroundColor(AeroColors.ink)
            AeroProgressBar(value: 0.6)
        }
    }
    .frame(width: 320)
    .padding(40)
    .background(Color(hex: "#5DB6EE"))
}
