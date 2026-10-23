import SwiftUI

/// The classic Frutiger Aero wallpaper: bright sky, sun glare, rolling green hills and floating bubbles.
public struct AeroBackground: View {

    private let showsBubbles: Bool

    public init(showsBubbles: Bool = true) {
        self.showsBubbles = showsBubbles
    }

    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack {
                sky
                sunGlare(in: size)
                clouds(in: size)

                hills(in: size)

                if showsBubbles {
                    bubbles(in: size)
                }
            }
            .frame(width: size.width, height: size.height)
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }

    private var sky: some View {
        LinearGradient(
            stops: [
                .init(color: Color(hex: "#0F6FD0"), location: 0),
                .init(color: Color(hex: "#3FA9F0"), location: 0.38),
                .init(color: Color(hex: "#A5E0FA"), location: 0.62),
                .init(color: Color(hex: "#EAF9FF"), location: 0.74)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private func sunGlare(in size: CGSize) -> some View {
        RadialGradient(
            colors: [Color.white.opacity(0.95), Color.white.opacity(0.35), .clear],
            center: .center,
            startRadius: 0,
            endRadius: size.width * 0.5
        )
        .frame(width: size.width, height: size.width)
        .position(x: size.width * 0.9, y: size.height * 0.04)
    }

    private func clouds(in size: CGSize) -> some View {
        ZStack {
            cloud(width: size.width * 0.5).position(x: size.width * 0.22, y: size.height * 0.2)
            cloud(width: size.width * 0.38).position(x: size.width * 0.72, y: size.height * 0.34)
        }
    }

    private func cloud(width: CGFloat) -> some View {
        Ellipse()
            .fill(Color.white.opacity(0.55))
            .frame(width: width, height: width * 0.2)
            .blur(radius: width * 0.05)
    }

    private func hills(in size: CGSize) -> some View {
        ZStack {
            AeroHill(baseline: 0.74, amplitude: 0.035, phase: 0.2)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#A6E36B"), Color(hex: "#4DB336")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            AeroHill(baseline: 0.82, amplitude: 0.04, phase: 0.75)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#7CD13F"), Color(hex: "#2E8F27")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            AeroHill(baseline: 0.92, amplitude: 0.03, phase: 0.45)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#56B82E"), Color(hex: "#1F7A20")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        .frame(width: size.width, height: size.height)
    }

    private func bubbles(in size: CGSize) -> some View {
        let unit = min(size.width, size.height)
        // x, y (fractions of the canvas), diameter (fraction of the shorter side).
        let layout: [(CGFloat, CGFloat, CGFloat, AeroColorPalette)] = [
            (0.12, 0.62, 0.16, AeroColors.skyBlue),
            (0.86, 0.5, 0.1, AeroColors.aqua),
            (0.7, 0.8, 0.2, AeroColors.grass),
            (0.28, 0.88, 0.09, AeroColors.aqua),
            (0.5, 0.58, 0.07, AeroColors.skyBlue),
            (0.92, 0.9, 0.12, AeroColors.skyBlue)
        ]

        return ZStack {
            ForEach(layout.indices, id: \.self) { index in
                let item = layout[index]
                AeroBubble(size: unit * item.2, palette: item.3)
                    .position(x: size.width * item.0, y: size.height * item.1)
            }
        }
    }
}

private struct AeroHill: Shape {

    let baseline: CGFloat
    let amplitude: CGFloat
    let phase: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let steps = 48

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))

        for step in 0...steps {
            let t = CGFloat(step) / CGFloat(steps)
            let wave = sin((t + phase) * .pi * 2) * 0.6 + sin((t * 1.7 + phase) * .pi * 2) * 0.4
            let y = rect.height * (baseline - amplitude * wave)
            path.addLine(to: CGPoint(x: rect.minX + rect.width * t, y: y))
        }

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    AeroBackground()
        .frame(width: 390, height: 700)
}
