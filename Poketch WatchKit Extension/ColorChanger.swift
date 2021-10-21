//
//  ColorChanger.swift
//  ColorChanger
//
//  Created by Idrees Hassan on 10/20/21.
//

import SwiftUI

struct ColorChanger: View {
    
    @EnvironmentObject var config: Config
    
    @State var sliderNotch = 0
    
    let lizardWidth = 92.0
    let sliderWidth = 152.0 // Original: 152px
    let sliderButtonWidth = 152.0 / 4.75 // Original: 32px
    let sliderNotchSize = 152.0 / 9.5 // Original: 16px
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack {
                Image("lizard").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: lizardWidth).foregroundColor(config.theme.colorB)
                ZStack {
                    Image("color-changer-slider-frame").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: sliderWidth).foregroundColor(config.theme.colorC)
                    ZStack {
                        Image("color-changer-slider-button-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: sliderButtonWidth).foregroundColor(config.theme.colorA)
                        Image("color-changer-slider-button-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: sliderButtonWidth).foregroundColor(config.theme.colorB)
                        Image("color-changer-slider-button-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: sliderButtonWidth).foregroundColor(config.theme.colorC)
                        Image("color-changer-slider-button-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: sliderButtonWidth).foregroundColor(config.theme.colorD)
                    }.offset(x: Double(sliderNotch - 4) * sliderNotchSize + sliderNotchSize / 2)
                }
            }
        }
    }
}

struct ColorChanger_Previews: PreviewProvider {
    static var previews: some View {
        ColorChanger().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
