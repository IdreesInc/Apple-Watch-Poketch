//
//  Stopwatch.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/15/21.
//

import SwiftUI

struct Stopwatch: View {
    
    @EnvironmentObject var config: Config
    
    @State var digitOne = "0"
    @State var digitTwo = "0"
    @State var digitThree = "0"
    @State var digitFour = "0"
    @State var digitFive = "0"
    @State var digitSix = "0"
    @State var digitSeven = "0"
    @State var digitEight = "0"
    
    @State var buttonPressed = false
    @State var active = false
    @State var frame = 0
    @State var pressedFrames = 0
    
    let digitWidth = 14.0
    let buttonWidth = 80.0 // Original: 80.0
    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack(spacing: 0.0) {
                HStack(spacing: 0.0) {
                    ZStack {
                        Image("counter-digit-" + digitOne + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitOne + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    ZStack {
                        Image("counter-digit-" + digitTwo + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitTwo + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    Image("stopwatch-colon").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    ZStack {
                        Image("counter-digit-" + digitThree + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitThree + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    ZStack {
                        Image("counter-digit-" + digitFour + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitFour + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    Image("stopwatch-colon").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    ZStack {
                        Image("counter-digit-" + digitFive + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitFive + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    ZStack {
                        Image("counter-digit-" + digitSix + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                        Image("counter-digit-" + digitSix + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                    }
                    HStack(spacing: 0.0) {
                        // Extra stack necessary due to stack limitation of 10 children
                        Image("stopwatch-dot").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                        ZStack {
                            Image("counter-digit-" + digitSeven + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitSeven + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitSeven + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitSeven + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                        }
                    }
                }
                ZStack {
                    ZStack {
                        let activeFrame = (frame / 2) % 2 + 1
                        if !buttonPressed {
                            if !active {
                                Image("stopwatch-blank-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                                Image("stopwatch-blank-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                                Image("stopwatch-blank-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                            } else {
                                Image("stopwatch-active-\(activeFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                                Image("stopwatch-active-\(activeFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                                Image("stopwatch-active-\(activeFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                            }
                        } else {
                            if pressedFrames < 15 {
                                Image("stopwatch-pressed-1-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                                Image("stopwatch-pressed-1-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                                Image("stopwatch-pressed-1-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                            } else {
                                let pressedAnimationFrame = pressedFrames % 15 / 5 + 2
                                Image("stopwatch-pressed-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                                Image("stopwatch-pressed-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                                Image("stopwatch-pressed-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                            }
                        }
                        Image("stopwatch-highlight-\(activeFrame)").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 92.0).foregroundColor(config.theme.colorB).opacity(active && !buttonPressed ? 1.0 : 0.0)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ touch in
                                buttonPressed = true
                            })
                            .onEnded({ touch in
                                buttonPressed = false
                                active = !active
                            })
                    )
                }.offset(y: 15.0)
            }
        }
        .onReceive(timer) { _ in
            frame += 1
            if buttonPressed {
                pressedFrames += 1
            } else {
                pressedFrames = 0
            }
        }
    }
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
