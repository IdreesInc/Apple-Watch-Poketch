//
//  Theme.swift
//  Theme
//
//  Created by Idrees Hassan on 9/6/21.
//

import SwiftUI

struct ColorScheme {
    static var green = Theme(
        colorA: Color(red: 0.44, green: 0.69, blue: 0.44),
        colorB: Color(red: 0.31, green: 0.51, blue: 0.32),
        colorC: Color(red: 0.22, green: 0.32, blue: 0.19),
        colorD: Color(red: 0.06, green: 0.16, blue: 0.09),
        colorAGlow: Color(red: 0.51, green: 0.89, blue: 0.51),
        colorBGlow: Color(red: 0.38, green: 0.67, blue: 0.51),
        colorCGlow: Color(red: 0.22, green: 0.54, blue: 0.42))
}

class Theme {
    var colorA: Color
    var colorB: Color
    var colorC: Color
    var colorD: Color
    var colorAGlow: Color
    var colorBGlow: Color
    var colorCGlow: Color
    
    init(colorA: Color, colorB: Color, colorC: Color, colorD: Color, colorAGlow: Color, colorBGlow: Color, colorCGlow: Color) {
        self.colorA = colorA
        self.colorB = colorB
        self.colorC = colorC
        self.colorD = colorD
        self.colorAGlow = colorAGlow
        self.colorBGlow = colorBGlow
        self.colorCGlow = colorCGlow
    }
}
