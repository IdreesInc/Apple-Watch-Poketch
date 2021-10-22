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
    @State var sliderLocation = 0.0
    
    let lizardWidth = 92.0
    let sliderWidth = 152.0 // Original: 152px
    let sliderButtonWidth = 152.0 / 4.75 // Original: 32px
    let sliderNotchSize = 152.0 / 9.5 // Original: 16px
    let colors = [ColorScheme.green, ColorScheme.yellow, ColorScheme.orange, ColorScheme.red, ColorScheme.purple, ColorScheme.indigo, ColorScheme.cyan, ColorScheme.grey]
    
    func setNotch(notch: Int) {
        sliderNotch = notch
        config.theme = colors[notch % colors.count]
    }
    
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
                    .onAppear(perform: {
                        for i in 0...colors.count {
                            if colors[i].color == config.theme.color {
                                sliderNotch = i
                                break
                            }
                        }
                    })
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ touch in
                                // To match the original games, distance from notch to touch input is used without accounting for the offset of the touch to the center of the slider button
                                let x = touch.location.x
                                if x < -4.0 * sliderNotchSize + sliderNotchSize * 2 {
                                    setNotch(notch: 0)
                                    return
                                }
                                for i in -3...2 {
                                    if x < Double(i) * sliderNotchSize + sliderNotchSize * 2 {
                                        setNotch(notch: i + 4)
                                        return
                                    }
                                }
                                if x > 2.0 * sliderNotchSize + sliderNotchSize * 2 {
                                    setNotch(notch: 7)
                                }
                            })
                    )
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
