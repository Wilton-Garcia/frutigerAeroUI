//
//  Color+Hex.swift
//  frutigerAeroUI
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension Color {

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r: UInt64
        let g: UInt64
        let b: UInt64

        switch hex.count {
        case 6:
            r = (int >> 16) & 0xFF
            g = (int >> 8) & 0xFF
            b = int & 0xFF
        default:
            r = 0
            g = 0
            b = 0
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }

    /// Linearly blends this color with `other`. `amount` goes from 0 (this color) to 1 (`other`).
    func mixed(with other: Color, amount: Double) -> Color {
        let t = min(max(amount, 0), 1)
        let a = rgbaComponents
        let b = other.rgbaComponents

        return Color(
            .sRGB,
            red: a.red + (b.red - a.red) * t,
            green: a.green + (b.green - a.green) * t,
            blue: a.blue + (b.blue - a.blue) * t,
            opacity: a.alpha + (b.alpha - a.alpha) * t
        )
    }

    internal var rgbaComponents: (red: Double, green: Double, blue: Double, alpha: Double) {
        #if canImport(UIKit)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
        #elseif canImport(AppKit)
        let color = NSColor(self).usingColorSpace(.sRGB) ?? .black
        return (
            Double(color.redComponent),
            Double(color.greenComponent),
            Double(color.blueComponent),
            Double(color.alphaComponent)
        )
        #else
        return (0, 0, 0, 1)
        #endif
    }
}
