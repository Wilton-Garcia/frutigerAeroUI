import SwiftUI

public struct AeroUIShowcase: View {

    @State private var textValue = ""
    @State private var searchValue = ""
    @State private var toggleA = true
    @State private var toggleB = false
    @State private var tags: [String] = ["Swift", "SwiftUI", "iOS"]

    public init() {}

    public var body: some View {
        ZStack {
            AeroBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: AeroSpacing.lg) {

                    header

                    buttonSection
                    cardSection
                    textFieldSection
                    iconCardSection
                    badgeAndTagSection
                    toggleSection
                    progressSection
                    windowSection

                }
                .padding(AeroSpacing.md)
                .frame(maxWidth: 640)
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: AeroSpacing.xs) {
            Text("Frutiger Aero UI")
                .font(.system(.largeTitle, design: .rounded).weight(.heavy))
                .foregroundColor(.white)
                .shadow(color: Color(hex: "#0B4F9E"), radius: 0, y: 2)
                .shadow(color: Color(hex: "#0B4F9E").opacity(0.5), radius: 8, y: 4)
            Text("Component Showcase")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .shadow(color: Color(hex: "#0B4F9E").opacity(0.8), radius: 2, y: 1)
        }
    }

    // MARK: - Buttons

    private var buttonSection: some View {
        AeroWindow("Buttons", systemImage: "hand.tap.fill", palette: AeroColors.skyBlue) {
            VStack(alignment: .leading, spacing: AeroSpacing.md) {
                HStack(spacing: AeroSpacing.sm) {
                    AeroButton("Small", palette: AeroColors.skyBlue, size: .small) {}
                    AeroButton("Medium", palette: AeroColors.grass) {}
                    AeroButton("Large", palette: AeroColors.orange, size: .large) {}
                }

                HStack(spacing: AeroSpacing.sm) {
                    AeroButton("Glass", palette: AeroColors.aqua, style: .outlined) {}
                    AeroButton("Icon", systemImage: "heart.fill", palette: AeroColors.pink) {}
                    AeroButton("Star", systemImage: "star.fill", palette: AeroColors.sunshine) {}
                }
            }
        }
    }

    // MARK: - Cards

    private var cardSection: some View {
        AeroWindow("Cards", systemImage: "rectangle.fill.on.rectangle.fill", palette: AeroColors.grass) {
            VStack(alignment: .leading, spacing: AeroSpacing.md) {
                HStack(spacing: AeroSpacing.sm) {
                    AeroCard(palette: AeroColors.skyBlue) {
                        VStack(alignment: .leading, spacing: AeroSpacing.xs) {
                            Text("Sky")
                                .font(.headline)
                                .foregroundColor(AeroColors.skyBlue.text)
                            Text("A glass card")
                                .font(.caption)
                                .foregroundColor(AeroColors.ink.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    AeroCard(palette: AeroColors.grass) {
                        VStack(alignment: .leading, spacing: AeroSpacing.xs) {
                            Text("Grass")
                                .font(.headline)
                                .foregroundColor(AeroColors.grass.text)
                            Text("Fresh card")
                                .font(.caption)
                                .foregroundColor(AeroColors.ink.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                AeroCard(palette: AeroColors.aqua) {
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(AeroColors.aqua.border)
                        Text("Full-width aqua card with icon")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(AeroColors.aqua.text)
                        Spacer()
                    }
                }
            }
        }
    }

    // MARK: - Text Fields

    private var textFieldSection: some View {
        AeroWindow("Text Fields", systemImage: "character.cursor.ibeam", palette: AeroColors.aqua) {
            VStack(spacing: AeroSpacing.sm) {
                AeroTextField("Your name...", text: $textValue, systemImage: "person.fill", palette: AeroColors.skyBlue)
                AeroTextField("Search...", text: $searchValue, systemImage: "magnifyingglass", palette: AeroColors.grass)
                AeroTextField("Notes...", text: $textValue, palette: AeroColors.aqua)
            }
        }
    }

    // MARK: - Icon Cards

    private var iconCardSection: some View {
        AeroWindow("Icon Cards", systemImage: "square.grid.2x2.fill", palette: AeroColors.ocean) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 60, maximum: 80), spacing: AeroSpacing.sm)], spacing: AeroSpacing.sm) {
                AeroIconCard(systemImage: "calendar", palette: AeroColors.skyBlue, size: .small)
                AeroIconCard(systemImage: "message.fill", palette: AeroColors.grass, size: .small)
                AeroIconCard(systemImage: "music.note", palette: AeroColors.orange, size: .small, shape: .orb)
                AeroIconCard(systemImage: "envelope.fill", palette: AeroColors.sunshine, size: .small)
                AeroIconCard(systemImage: "location.fill", palette: AeroColors.aqua, size: .small, shape: .orb)
                AeroIconCard(systemImage: "folder.fill", palette: AeroColors.ocean, size: .small)
                AeroIconCard(systemImage: "star.fill", palette: AeroColors.pink, size: .small, shape: .orb)
                AeroIconCard(systemImage: "heart.fill", palette: AeroColors.coral, size: .small)
                AeroIconCard(systemImage: "cloud.fill", palette: AeroColors.purple, size: .small, shape: .orb)
                AeroIconCard(systemImage: "leaf.fill", palette: AeroColors.lime, size: .small)
            }
        }
    }

    // MARK: - Badges & Tags

    private var badgeAndTagSection: some View {
        AeroWindow("Badges & Tags", systemImage: "tag.fill", palette: AeroColors.purple) {
            VStack(alignment: .leading, spacing: AeroSpacing.md) {
                HStack(spacing: AeroSpacing.sm) {
                    AeroBadge("New", palette: AeroColors.grass)
                    AeroBadge("42", palette: AeroColors.coral)
                    AeroBadge("Beta", palette: AeroColors.purple)
                    AeroBadge("Sale", palette: AeroColors.orange)
                    AeroBadge("Hot", palette: AeroColors.sunshine)
                }

                AeroDivider(palette: AeroColors.purple)

                HStack(spacing: AeroSpacing.sm) {
                    ForEach(tags, id: \.self) { tag in
                        AeroTag(tag, palette: paletteFor(tag), onRemove: {
                            tags.removeAll { $0 == tag }
                        })
                    }
                    if tags.isEmpty {
                        Text("All tags removed!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(spacing: AeroSpacing.sm) {
                    AeroTag("No remove", palette: AeroColors.aqua)
                    AeroTag("Read only", palette: AeroColors.pearl)
                }
            }
        }
    }

    // MARK: - Toggles

    private var toggleSection: some View {
        AeroWindow("Toggles", systemImage: "switch.2", palette: AeroColors.lime) {
            VStack(spacing: AeroSpacing.sm) {
                AeroToggle("Wi-Fi", isOn: $toggleA, palette: AeroColors.grass)
                AeroToggle("Bluetooth", isOn: $toggleB, palette: AeroColors.skyBlue)
            }
        }
    }

    // MARK: - Progress Bars

    private var progressSection: some View {
        AeroWindow("Progress Bars", systemImage: "chart.bar.fill", palette: AeroColors.orange) {
            VStack(spacing: AeroSpacing.sm + 2) {
                AeroProgressBar(value: 0.25, palette: AeroColors.skyBlue)
                AeroProgressBar(value: 0.5, palette: AeroColors.grass)
                AeroProgressBar(value: 0.75, palette: AeroColors.orange)
                AeroProgressBar(value: 1.0, palette: AeroColors.aqua)
            }
        }
    }

    // MARK: - Window & Bubbles

    private var windowSection: some View {
        AeroWindow("Windows & Bubbles", systemImage: "macwindow", palette: AeroColors.pearl) {
            HStack(spacing: AeroSpacing.md) {
                AeroBubble(size: 40, palette: AeroColors.skyBlue)
                AeroBubble(size: 64, palette: AeroColors.grass)
                AeroBubble(size: 90, palette: AeroColors.aqua)
                Spacer()
            }
            .padding(.vertical, AeroSpacing.xs)
        }
    }

    // MARK: - Helpers

    private func paletteFor(_ tag: String) -> AeroColorPalette {
        switch tag {
        case "Swift": return AeroColors.orange
        case "SwiftUI": return AeroColors.skyBlue
        default: return AeroColors.grass
        }
    }
}

#Preview {
    AeroUIShowcase()
}
