//
//  AeroColors.swift
//  frutigerAeroUI
//
import SwiftUI

@MainActor
public enum AeroColors {

    /// Deep blue used for text on light surfaces.
    public static let ink = Color(hex: "#1B4F7A")

    public static let skyBlue = AeroColorPalette(
        border: Color(hex: "#1D8BE0"),
        background: Color(hex: "#C4EAFF")
    )

    public static let ocean = AeroColorPalette(
        border: Color(hex: "#0B5FC1"),
        background: Color(hex: "#A9D0FF")
    )

    public static let aqua = AeroColorPalette(
        border: Color(hex: "#0FA9C4"),
        background: Color(hex: "#BDF4F7")
    )

    public static let grass = AeroColorPalette(
        border: Color(hex: "#3EA82A"),
        background: Color(hex: "#CBF2A8")
    )

    public static let lime = AeroColorPalette(
        border: Color(hex: "#7DBE14"),
        background: Color(hex: "#E3F7A0")
    )

    public static let sunshine = AeroColorPalette(
        border: Color(hex: "#F2A900"),
        background: Color(hex: "#FFF0A8"),
        foreground: ink
    )

    public static let orange = AeroColorPalette(
        border: Color(hex: "#F26A1B"),
        background: Color(hex: "#FFD3A6")
    )

    public static let coral = AeroColorPalette(
        border: Color(hex: "#E2453C"),
        background: Color(hex: "#FFBDB4")
    )

    public static let pink = AeroColorPalette(
        border: Color(hex: "#E8559B"),
        background: Color(hex: "#FFC9E4")
    )

    public static let purple = AeroColorPalette(
        border: Color(hex: "#7A4DD8"),
        background: Color(hex: "#DCCBFF")
    )

    public static let pearl = AeroColorPalette(
        border: Color(hex: "#8FB3D4"),
        background: Color(hex: "#F4FAFF"),
        foreground: ink
    )

    public static let silver = AeroColorPalette(
        border: Color(hex: "#8E9AA8"),
        background: Color(hex: "#E8EDF2"),
        foreground: ink
    )
}
