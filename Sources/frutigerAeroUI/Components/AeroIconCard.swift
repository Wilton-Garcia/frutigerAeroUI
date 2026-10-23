import SwiftUI

public struct AeroIconCard: View {

    public enum Size {
        case small
        case medium
        case large

        var dimension: CGFloat {
            switch self {
            case .small: 60
            case .medium: 80
            case .large: 100
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .small: 24
            case .medium: 34
            case .large: 46
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small: AeroRadius.medium
            case .medium: AeroRadius.large
            case .large: AeroRadius.extraLarge
            }
        }
    }

    public enum Shape {
        /// Rounded square app icon.
        case square
        /// Round glass orb, like the Vista start button.
        case orb
    }

    private let systemImage: String
    private let palette: AeroColorPalette
    private let size: Size
    private let shape: Shape

    public init(
        systemImage: String,
        palette: AeroColorPalette = AeroColors.skyBlue,
        size: Size = .medium,
        shape: Shape = .square
    ) {
        self.systemImage = systemImage
        self.palette = palette
        self.size = size
        self.shape = shape
    }

    public var body: some View {
        ZStack {
            switch shape {
            case .square:
                AeroSurface(
                    RoundedRectangle(cornerRadius: size.cornerRadius, style: .circular),
                    palette: palette
                )
            case .orb:
                AeroSurface(Circle(), palette: palette)
            }

            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: size.iconSize, height: size.iconSize)
                .foregroundColor(palette.foreground)
                .shadow(
                    color: palette.foreground == .white ? palette.border.opacity(0.9) : .clear,
                    radius: 1.5,
                    y: 1
                )
        }
        .frame(width: size.dimension, height: size.dimension)
    }
}

#Preview {
    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4), spacing: AeroSpacing.md) {
        AeroIconCard(systemImage: "calendar", palette: AeroColors.skyBlue)
        AeroIconCard(systemImage: "message.fill", palette: AeroColors.grass)
        AeroIconCard(systemImage: "music.note", palette: AeroColors.orange, shape: .orb)
        AeroIconCard(systemImage: "envelope.fill", palette: AeroColors.sunshine)
        AeroIconCard(systemImage: "location.fill", palette: AeroColors.aqua, shape: .orb)
        AeroIconCard(systemImage: "folder.fill", palette: AeroColors.ocean)
        AeroIconCard(systemImage: "star.fill", palette: AeroColors.pink)
        AeroIconCard(systemImage: "heart.fill", palette: AeroColors.coral, shape: .orb)
    }
    .padding(40)
    .background(Color(hex: "#9FD8F7"))
}
