import SwiftUI

public struct AeroTextField: View {

    private let placeholder: String
    @Binding private var text: String
    private let systemImage: String?
    private let palette: AeroColorPalette

    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String,
        text: Binding<String>,
        systemImage: String? = nil,
        palette: AeroColorPalette = AeroColors.skyBlue
    ) {
        self.placeholder = placeholder
        self._text = text
        self.systemImage = systemImage
        self.palette = palette
    }

    public var body: some View {
        let shape = Capsule(style: .circular)

        HStack(spacing: AeroSpacing.sm) {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundColor(palette.border)
            }
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .foregroundColor(palette.text)
                .focused($isFocused)
        }
        .padding(.horizontal, AeroSpacing.md)
        .padding(.vertical, AeroSpacing.sm + 2)
        .background {
            ZStack {
                shape.fill(Color.white.opacity(0.9))
                // Inner shade at the top gives the field an inset, glass-pane look.
                shape
                    .strokeBorder(
                        LinearGradient(
                            colors: [palette.border.opacity(0.35), .clear],
                            startPoint: .top,
                            endPoint: .center
                        ),
                        lineWidth: 4
                    )
                    .clipShape(shape)
                shape.strokeBorder(palette.border.opacity(isFocused ? 1 : 0.75), lineWidth: isFocused ? 2 : 1.5)
            }
            .shadow(color: palette.border.opacity(isFocused ? 0.6 : 0), radius: 6)
        }
        .animation(.easeOut(duration: 0.15), value: isFocused)
    }
}

private struct AeroTextFieldPreview: View {
    @State private var name = ""
    @State private var search = ""
    var body: some View {
        VStack(spacing: AeroSpacing.md) {
            AeroTextField("Your name...", text: $name, systemImage: "person.fill", palette: AeroColors.skyBlue)
            AeroTextField("Search...", text: $search, systemImage: "magnifyingglass", palette: AeroColors.grass)
        }
        .padding(40)
        .background(Color(hex: "#9FD8F7"))
    }
}

#Preview {
    AeroTextFieldPreview()
}
