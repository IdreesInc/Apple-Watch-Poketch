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
    
    let width = CGFloat(32)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let COLOR_A = Color(red: 0.31, green: 0.51, blue: 0.32);
    let COLOR_B = Color(red: 0.22, green: 0.32, blue: 0.19);
    
    var body: some View {
        ZStack {
            Color(red: 0.44, green: 0.69, blue: 0.44)
            HStack (spacing: 0) {
                Image("digit-" + digitOne).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(COLOR_B)
                Image("digit-" + digitTwo).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(COLOR_B)
                Image(digitColon).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width / 2.5).foregroundColor(COLOR_B)
                Image("digit-" + digitThree).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(COLOR_B)
                Image("digit-" + digitFour).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(COLOR_B)
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
                        Image("mouse-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(COLOR_A)
                        Image("mouse-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(COLOR_B)
                    }
                    Image("line").interpolation(.none).resizable().frame(height: 38)
                }
            }
        }
    }
}

struct DigitalWatch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DigitalWatch()
                .previewDevice("Apple Watch Series 6 - 40mm")
            DigitalWatch()
                .environment(\.isLuminanceReduced, true)
                .environment(\.redactionReasons, [.privacy])
        }
    }
}
