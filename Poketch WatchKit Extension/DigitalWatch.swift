//
//  DigitalWatch.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct DigitalWatch: View {
    
    @State var digitOne = "0"
    @State var digitTwo = "2"
    @State var digitColon = "colon"
    @State var digitThree = "1"
    @State var digitFour = "7"
    
    let width = CGFloat(25)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.44, green: 0.69, blue: 0.44)
            HStack {
                Image("digit-" + digitOne).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitTwo).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitColon).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitThree).resizable().aspectRatio(contentMode: .fit).frame(width: width)
                Image("digit-" + digitFour).resizable().aspectRatio(contentMode: .fit).frame(width: width)
            }.onReceive(timer) { _ in
                self.digitColon = self.digitColon == "blank" ? "colon" : "blank"
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
        }
    }
}

struct DigitalWatch_Previews: PreviewProvider {
    static var previews: some View {
        DigitalWatch()
    }
}
