//
//  Counter.swift
//  Counter
//
//  Created by Idrees Hassan on 10/18/21.
//

import SwiftUI

struct Counter: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    @EnvironmentObject var config: Config

    @GestureState var press = false
    
    @State var digitOne = "0"
    @State var digitTwo = "0"
    @State var digitThree = "0"
    @State var digitFour = "0"
    @State var counterButtonPressed = ""
    @State var count = 0
    
    let width = 20.0
    let frameWidth = 20.0 * 5
    let buttonWidth = 80.0
    
    func incrementCounter() {
        count += 1
        updateDigits()
    }
    
    func updateDigits() {
        let strCount = String(format: "%04d", count)
        let countArray = Array(strCount)
        if countArray.count == 4 {
            digitOne = String(countArray[0])
            digitTwo = String(countArray[1])
            digitThree = String(countArray[2])
            digitFour = String(countArray[3])
        } else {
            digitOne = "9"
            digitTwo = "9"
            digitThree = "9"
            digitFour = "9"
        }
    }
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack (spacing: 10.0) {
                ZStack {
                    Image("counter-frame").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: frameWidth).foregroundColor(config.theme.colorB).offset(y: width / 16.0)
                    HStack (spacing: 0) {
                        ZStack {
                            Image("counter-digit-" + digitOne + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitOne + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitTwo + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitTwo + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitThree + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitThree + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitFour + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitFour + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                    }
                }
                ZStack {
                    Image("counter-button" + counterButtonPressed + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                    Image("counter-button" + counterButtonPressed + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                    Image("counter-button" + counterButtonPressed + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            counterButtonPressed = "-pressed"
                        })
                        .onEnded({ touch in
                            counterButtonPressed = ""
                            incrementCounter()
                        })
                )
            }.offset(y: 0.0)
        }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
