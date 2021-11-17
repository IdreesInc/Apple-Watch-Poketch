//
//  Stopwatch.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/15/21.
//

import SwiftUI

struct Stopwatch: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced

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
    @State var datePressed: Date?
    @State var previousTime = [0, 0, 0, 0]
    @State var angryBall = false
    
    let digitWidth = 14.0
    let buttonWidth = 80.0 // Original: 80.0
    let explosionWidth = 52.0 // Original: 52.0
    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    func updateDigits() {
        if datePressed != nil {
            let calendar = Calendar.current
            let diffComponents = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: datePressed!, to: Date())
            var hour = String(diffComponents.hour!)
            var minutes = String(diffComponents.minute!)
            var seconds = String(diffComponents.second!)
            var milliseconds = String(Int(diffComponents.nanosecond!) / 10000000)
            if hour.count == 1 {
                hour = "0" + hour
            }
            if minutes.count == 1 {
                minutes = "0" + minutes
            }
            if seconds.count == 1 {
                seconds = "0" + seconds
            }
            if milliseconds.count == 1 {
                milliseconds = "0" + milliseconds
            }
            if hour.count > 2 {
                digitOne = "9"
                digitTwo = "9"
                digitThree = "9"
                digitFour = "9"
                digitFive = "9"
                digitSix = "9"
                digitSeven = "9"
                digitEight = "9"
            } else {
                digitOne = String(hour.prefix(1))
                digitTwo = String(hour.suffix(1))
                digitThree = String(minutes.prefix(1))
                digitFour = String(minutes.suffix(1))
                digitFive = String(seconds.prefix(1))
                digitSix = String(seconds.suffix(1))
                digitSeven = String(milliseconds.prefix(1))
                digitEight = String(milliseconds.suffix(1))
            }
            if isLuminanceReduced {
                digitFive = "dash"
                digitSix = "dash"
                digitSeven = "dash"
                digitEight = "dash"
            }
        }
    }
    
    func pauseStopwatch() {
        let calendar = Calendar.current
        if datePressed != nil {
            let diffComponents = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: datePressed!, to: Date())
            previousTime[0] = diffComponents.hour!
            previousTime[1] = diffComponents.minute!
            previousTime[2] = diffComponents.second!
            previousTime[3] = diffComponents.nanosecond!
            datePressed = nil
        }
    }
    
    func unpauseStopwatch() {
        var date = Calendar.current.date(byAdding: .hour, value: -previousTime[0], to: Date())
        date = Calendar.current.date(byAdding: .minute, value: -previousTime[1], to: date!)
        date = Calendar.current.date(byAdding: .second, value: -previousTime[2], to: date!)
        date = Calendar.current.date(byAdding: .nanosecond, value: -previousTime[3], to: date!)
        datePressed = date!
    }
    
    func clearStopwatch() {
        datePressed = nil
        active = false
        buttonPressed = false
        previousTime = [0, 0, 0, 0]
        digitOne = "0"
        digitTwo = "0"
        digitThree = "0"
        digitFour = "0"
        digitFive = "0"
        digitSix = "0"
        digitSeven = "0"
        digitEight = "0"
    }
    
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
                            Image("counter-digit-" + digitEight + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitEight + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: digitWidth).foregroundColor(config.theme.colorD)
                        }
                    }
                }
                ZStack {
                    let activeFrame = isLuminanceReduced ? 1 : (frame / 2) % 2 + 1
                    if !buttonPressed && !angryBall {
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
                        } else if pressedFrames < 60 {
                            let pressedAnimationFrame = pressedFrames % 15 / 5 + 2
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                        } else if pressedFrames <= 60 + 9 * 8 {
                            let pressedAnimationFrame = (pressedFrames + 3) % 9 / 3 + 2
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                            Image("stopwatch-pressed-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                        } else if pressedFrames <= 132 + 6 * 8 {
                            let pressedAnimationFrame = pressedFrames % 6 / 3 + 1
                            Image("stopwatch-exploding-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                            Image("stopwatch-exploding-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                            Image("stopwatch-exploding-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                        } else {
                            let pressedAnimationFrame = (pressedFrames + 1) % 14 / 7 + 1
                            Image("stopwatch-blink-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                            Image("stopwatch-blink-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                            Image("stopwatch-blink-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                        }
                    }
                    Image("stopwatch-highlight-\(activeFrame)").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 92.0).foregroundColor(config.theme.colorB).opacity(active && !buttonPressed && !isLuminanceReduced && !angryBall ? 1.0 : 0.0)
                    ZStack {
                        let opacity = pressedFrames >= 60 + 9 * 8  && pressedFrames <  132 + 6 * 8 ? 1.0 : 0.0
//                        let opacity = 1.0
                        let pressedAnimationFrame = pressedFrames % 6 / 2 + 1

                        Image("stopwatch-explosion-\(pressedAnimationFrame)-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorA).offset(x: 20.0, y: 28.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorB).offset(x: 20.0, y: 28.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorC).offset(x: 20.0, y: 28.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorD).offset(x: 20.0, y: 28.0).opacity(opacity)
                        
                        let pressedAnimationFrame = (pressedFrames + 2) % 6 / 2 + 1

                        Image("stopwatch-explosion-\(pressedAnimationFrame)-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorA).offset(x: -28.0, y: -18.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorB).offset(x: -28.0, y: -18.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorC).offset(x: -28.0, y: -18.0).opacity(opacity)
                        Image("stopwatch-explosion-\(pressedAnimationFrame)-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: explosionWidth).foregroundColor(config.theme.colorD).offset(x: -28.0, y: -18.0).opacity(opacity)
                        
                    }
                }
                .offset(y: 15.0)
                .onChange(of: pressedFrames, perform: { value in
                    if value == 60 {
                        angryBall = true
                    } else if value == 180 {
                        clearStopwatch()
                    } else if value == 236 {
                        angryBall = false
                    }
                })
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            buttonPressed = true
                            if active {
                                pauseStopwatch()
                            }
                        })
                        .onEnded({ touch in
                            buttonPressed = false
                            if !angryBall {
                                active = !active
                                if active {
                                    unpauseStopwatch()
                                }
                            }
                        })
                )
            }
        }
        .onReceive(timer) { _ in
            frame += 1
            if buttonPressed || angryBall {
                pressedFrames += 1
            } else {
                pressedFrames = 0
            }
            updateDigits()
        }
    }
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
