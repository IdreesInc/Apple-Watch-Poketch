//
//  DigitalWatch.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct DigitalWatch: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    @State var digitOne = "1"
    @State var digitTwo = "0"
    @State var digitColon = "colon"
    @State var digitThree = "2"
    @State var digitFour = "1"
    @State var glowing = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let width = CGFloat(32)
    
    @ObservedObject var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
    }
    
    var body: some View {
        ZStack {
            glowing ? theme.backgroundColorGlow : theme.backgroundColor
            HStack (spacing: 0) {
                Image("digit-" + digitOne).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                Image("digit-" + digitTwo).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                Image(digitColon).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width / 2.5).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                Image("digit-" + digitThree).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                Image("digit-" + digitFour).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
            }.onReceive(timer) { _ in
                self.digitColon = self.digitColon == "colon" && !isLuminanceReduced ? "colon-blank" : "colon"
                let date = Date()
                let calendar = Calendar.current
                var hour = String(calendar.component(.hour, from: date))
                var minutes = String(calendar.component(.minute, from: date))
                if hour.count == 1 {
                    hour = "0" + hour
                }
                if (minutes.count == 1) {
                    minutes = "0" + minutes
                }
                digitOne = String(hour.prefix(1))
                digitTwo = String(hour.suffix(1))
                digitThree = String(minutes.prefix(1))
                digitFour = String(minutes.suffix(1))
            }
            VStack {
                Spacer()
                HStack (alignment: .bottom, spacing: 0) {
                    ZStack {
                        Image("mouse-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(glowing ? theme.colorAGlow : theme.colorA)
                        Image("mouse-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                    }
                    Image("line").renderingMode(.template).interpolation(.none).resizable().frame(height: 38).foregroundColor(glowing ? theme.colorAGlow : theme.colorA)
                }
            }
        }.gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ (touch) in
                    glowing = true
                })
                .onEnded({ (touch) in
                    glowing = false
                })
        )
    }
}

struct DigitalWatch_Previews: PreviewProvider {
    static var previews: some View {
        DigitalWatch(theme: Theme()).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
