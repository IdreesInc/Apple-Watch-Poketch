//
//  Theme.swift
//  Theme
//
//  Created by Idrees Hassan on 9/6/21.
//

import SwiftUI

struct ColorScheme {
    static var green = Theme(
        color: "green",
        colorA: Color(red: 0.44, green: 0.69, blue: 0.44),
        colorB: Color(red: 0.31, green: 0.51, blue: 0.32),
        colorC: Color(red: 0.22, green: 0.32, blue: 0.19),
        colorD: Color(red: 0.06, green: 0.16, blue: 0.09),
        colorAGlow: Color(red: 0.51, green: 0.89, blue: 0.51),
        colorBGlow: Color(red: 0.38, green: 0.67, blue: 0.51),
        colorCGlow: Color(red: 0.22, green: 0.54, blue: 0.42))
    static var yellow = Theme(
        color: "yellow",
        colorA: Color(red: 0.73, green: 0.70, blue: 0.44),
        colorB: Color(red: 0.51, green: 0.51, blue: 0.26),
        colorC: Color(red: 0.28, green: 0.32, blue: 0.19),
        colorD: Color(red: 0.12, green: 0.13, blue: 0.06),
        colorAGlow: Color(red: 0.92, green: 0.92, blue: 0.51),
        colorBGlow: Color(red: 0.73, green: 0.73, blue: 0.44),
        colorCGlow: Color(red: 0.47, green: 0.47, blue: 0.29))
    static var orange = Theme(
        color: "orange",
        colorA: Color(red: 0.76, green: 0.57, blue: 0.41),
        colorB: Color(red: 0.54, green: 0.38, blue: 0.22),
        colorC: Color(red: 0.32, green: 0.26, blue: 0.16),
        colorD: Color(red: 0.16, green: 0.13, blue: 0.07),
        colorAGlow: Color(red: 0.95, green: 0.80, blue: 0.64),
        colorBGlow: Color(red: 0.83, green: 0.67, blue: 0.51),
        colorCGlow: Color(red: 0.64, green: 0.54, blue: 0.41))
    static var red = Theme(
        color: "red",
        colorA: Color(red: 0.86, green: 0.44, blue: 0.44),
        colorB: Color(red: 0.66, green: 0.28, blue: 0.28),
        colorC: Color(red: 0.38, green: 0.13, blue: 0.13),
        colorD: Color(red: 0.13, green: 0.06, blue: 0.06),
        colorAGlow: Color(red: 0.98, green: 0.67, blue: 0.64),
        colorBGlow: Color(red: 0.83, green: 0.51, blue: 0.51),
        colorCGlow: Color(red: 0.57, green: 0.35, blue: 0.35))
    static var purple = Theme(
        color: "purple",
        colorA: Color(red: 0.64, green: 0.44, blue: 0.70),
        colorB: Color(red: 0.47, green: 0.32, blue: 0.51),
        colorC: Color(red: 0.29, green: 0.19, blue: 0.32),
        colorD: Color(red: 0.13, green: 0.06, blue: 0.13),
        colorAGlow: Color(red: 0.89, green: 0.67, blue: 0.95),
        colorBGlow: Color(red: 0.70, green: 0.51, blue: 0.73),
        colorCGlow: Color(red: 0.54, green: 0.41, blue: 0.57))
    static var indigo = Theme(
        color: "indigo",
        colorA: Color(red: 0.54, green: 0.54, blue: 0.98),
        colorB: Color(red: 0.25, green: 0.32, blue: 0.73),
        colorC: Color(red: 0.22, green: 0.22, blue: 0.41),
        colorD: Color(red: 0.07, green: 0.09, blue: 0.13),
        colorAGlow: Color(red: 0.67, green: 0.70, blue: 0.98),
        colorBGlow: Color(red: 0.51, green: 0.51, blue: 0.86),
        colorCGlow: Color(red: 0.38, green: 0.38, blue: 0.67))
    static var cyan = Theme(
        color: "cyan",
        colorA: Color(red: 0.35, green: 0.73, blue: 0.76),
        colorB: Color(red: 0.13, green: 0.51, blue: 0.54),
        colorC: Color(red: 0.07, green: 0.35, blue: 0.38),
        colorD: Color(red: 0.12, green: 0.09, blue: 0.03),
        colorAGlow: Color(red: 0.66, green: 0.86, blue: 0.89),
        colorBGlow: Color(red: 0.55, green: 0.73, blue: 0.76),
        colorCGlow: Color(red: 0.44, green: 0.60, blue: 0.60))
    static var grey = Theme(
        color: "grey",
        colorA: Color(red: 0.64, green: 0.64, blue: 0.64),
        colorB: Color(red: 0.47, green: 0.47, blue: 0.47),
        colorC: Color(red: 0.32, green: 0.32, blue: 0.32),
        colorD: Color(red: 0.09, green: 0.09, blue: 0.09),
        colorAGlow: Color(red: 0.80, green: 0.80, blue: 0.80),
        colorBGlow: Color(red: 0.67, green: 0.67, blue: 0.67),
        colorCGlow: Color(red: 0.51, green: 0.51, blue: 0.51))
}

class Theme {
    var color: String
    var colorA: Color
    var colorB: Color
    var colorC: Color
    var colorD: Color
    var colorAGlow: Color
    var colorBGlow: Color
    var colorCGlow: Color
    
    init(color: String, colorA: Color, colorB: Color, colorC: Color, colorD: Color, colorAGlow: Color, colorBGlow: Color, colorCGlow: Color) {
        self.color = color
        self.colorA = colorA
        self.colorB = colorB
        self.colorC = colorC
        self.colorD = colorD
        self.colorAGlow = colorAGlow
        self.colorBGlow = colorBGlow
        self.colorCGlow = colorCGlow
    }
}
