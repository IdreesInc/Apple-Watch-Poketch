//
//  Theme.swift
//  Theme
//
//  Created by Idrees Hassan on 9/6/21.
//

import SwiftUI

class Theme: ObservableObject {
    @Published var colorA = Color(red: 0.44, green: 0.69, blue: 0.44)
    @Published var colorB = Color(red: 0.31, green: 0.51, blue: 0.32)
    @Published var colorC = Color(red: 0.22, green: 0.32, blue: 0.19)
    @Published var colorD = Color(red: 0.06, green: 0.16, blue: 0.09)
    @Published var colorAGlow = Color(red: 0.51, green: 0.89, blue: 0.51)
    @Published var colorBGlow = Color(red: 0.38, green: 0.67, blue: 0.51)
    @Published var colorCGlow = Color(red: 0.22, green: 0.54, blue: 0.42)
}
