import SwiftUI

public struct AeroButton: View {

    public enum Style {
        /// Opaque glossy button.
        case filled
        /// Translucent glass button.
        case outlined
    }

    public enum Size {
        case small
        case medium
        case large
    }

    private let title: String
    private let systemImage: String?
    private let palette: AeroColorPalette
    private let style: Style
    private let size: Size
    private let action: () -> Void

    public init(
        _ title: String,
        systemImage: String? = nil,
        palette: AeroColorPalette = AeroColors.skyBlue,
        style: Style = .filled,
        size: Size = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.palette = palette
        self.style = style
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: AeroSpacing.xs) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
        }
        .buttonStyle(AeroButtonStyle(palette: palette, style: style, size: size))
    }
}

private struct AeroButtonStyle: ButtonStyle {

    let palette: AeroColorPalette
    let style: AeroButton.Style
    let size: AeroButton.Size

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: AeroSpacing.md - 2
        case .medium: AeroSpacing.lg - 2
        case .large: AeroSpacing.xl
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .small: AeroSpacing.xs + 1
        case .medium: AeroSpacing.sm
        case .large: AeroSpacing.md - 2
        }
    }

    private var font: Font {
        switch size {
        case .small: .caption.weight(.semibold)
        case .medium: .callout.weight(.semibold)
        case .large: .body.weight(.bold)
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        let isFilled = style == .filled

        configuration.label
            .font(font)
            .foregroundColor(isFilled ? palette.foreground : palette.text)
            .shadow(
                color: isFilled && palette.foreground == .white ? palette.border.opacity(0.85) : .clear,
                radius: 1,
                y: 1
            )
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background {
                AeroSurface(
                    Capsule(style: .circular),
                    palette: palette,
                    style: isFilled ? .solid : .glass,
                    isPressed: configuration.isPressed
                )
            }
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: AeroSpacing.md) {
        AeroButton("Click me!", palette: AeroColors.skyBlue) {}
        AeroButton("With icon", systemImage: "star.fill", palette: AeroColors.grass, size: .large) {}
        AeroButton("Glass", palette: AeroColors.aqua, style: .outlined, size: .small) {}
        AeroButton("Sunshine", palette: AeroColors.sunshine) {}
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
