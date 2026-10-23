import SwiftUI

public struct AeroToggle: View {

    private let title: String
    @Binding private var isOn: Bool
    private let palette: AeroColorPalette

    public init(
        _ title: String,
        isOn: Binding<Bool>,
        palette: AeroColorPalette = AeroColors.grass
    ) {
        self.title = title
        self._isOn = isOn
        self.palette = palette
    }

    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
                .font(.callout.weight(.semibold))
                .foregroundColor(palette.text)
        }
        .toggleStyle(AeroSwitchStyle(palette: palette))
        .padding(.horizontal, AeroSpacing.md)
        .padding(.vertical, AeroSpacing.sm)
        .background {
            AeroSurface(
                RoundedRectangle(cornerRadius: AeroRadius.medium, style: .circular),
                palette: palette,
                style: .glass,
                gloss: .soft,
                showsGlow: false
            )
        }
    }
}

private struct AeroSwitchStyle: ToggleStyle {

    let palette: AeroColorPalette

    private let width: CGFloat = 54
    private let height: CGFloat = 30

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button {
                configuration.isOn.toggle()
            } label: {
                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                    AeroSurface(
                        Capsule(style: .circular),
                        palette: configuration.isOn ? palette : AeroColors.silver,
                        showsGlow: false
                    )
                    .frame(width: width, height: height)

                    knob
                        .padding(3)
                }
                .frame(width: width, height: height)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(configuration.isOn ? "On" : "Off")
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: configuration.isOn)
    }

    private var knob: some View {
        let size = height - 6

        return ZStack {
            Circle().fill(
                LinearGradient(
                    colors: [.white, Color(hex: "#D8E6F2")],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            Circle().strokeBorder(palette.border.opacity(0.6), lineWidth: 1)
            Ellipse()
                .fill(Color.white.opacity(0.9))
                .frame(width: size * 0.6, height: size * 0.3)
                .offset(y: -size * 0.22)
        }
        .frame(width: size, height: size)
        .shadow(color: .black.opacity(0.25), radius: 2, y: 1)
    }
}

private struct AeroTogglePreview: View {
    @State private var a = true
    @State private var b = false
    var body: some View {
        VStack(spacing: AeroSpacing.md) {
            AeroToggle("Wi-Fi", isOn: $a, palette: AeroColors.grass)
            AeroToggle("Bluetooth", isOn: $b, palette: AeroColors.skyBlue)
        }
        .padding(40)
        .background(Color(hex: "#9FD8F7"))
    }
}

#Preview {
    AeroTogglePreview()
}
