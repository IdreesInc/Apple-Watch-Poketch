//
//  DigitalWatch.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct DigitalWatch: View {
    
    @State var digitOne = "1"
    @State var digitTwo = "0"
    @State var digitColon = "colon"
    @State var digitThree = "2"
    @State var digitFour = "1"
    
    let width = CGFloat(32)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.44, green: 0.69, blue: 0.44)
            HStack (spacing: 0) {
                Image("digit-" + digitOne).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitTwo).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image(digitColon).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width / 2.5)
                Image("digit-" + digitThree).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitFour).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width)
            }.onReceive(timer) { _ in
                self.digitColon = self.digitColon == "colon" ? "colon-blank" : "colon"
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
                    Image("mouse").interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: 38)
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
        }
    }
}
