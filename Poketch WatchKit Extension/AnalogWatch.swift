//
//  AnalogWatch.swift
//  AnalogWatch
//
//  Created by Idrees Hassan on 10/20/21.
//

import SwiftUI

struct IncrementAngle: Identifiable {
    let x: Double
    let y: Double
    var id: String { "increment-" + String(x) + String(y) }
}

struct AnalogWatch: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    @ObservedObject var theme: Theme
    
    @GestureState var press = false
    
    @State var glowing = false
    @State var lastTime = 0
    @State var hourRotation = 270.0
    @State var minuteRotation = 0.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let hourWidth = 64.0
    let minuteWidth = 64.0 * 1.75
    let incrementWidth = 8.0
    let incrementSpacing = 8.0
    let fiveMinuteAngles: [IncrementAngle]
    let fifteenMinuteAngles: [IncrementAngle]
    
    init(theme: Theme) {
        self.theme = theme
        let sqrt3 = (3.0).squareRoot()
        fiveMinuteAngles = [
            IncrementAngle(x: sqrt3/2, y: 1/2),
            IncrementAngle(x: 1/2, y: sqrt3/2),
            IncrementAngle(x: -1/2, y: sqrt3/2),
            IncrementAngle(x: -sqrt3/2, y: 1/2),
            IncrementAngle(x: -sqrt3/2, y: -1/2),
            IncrementAngle(x: -1/2, y: -sqrt3/2),
            IncrementAngle(x: 1/2, y: -sqrt3/2),
            IncrementAngle(x: sqrt3/2, y: -1/2)
        ]
        fifteenMinuteAngles = [
            IncrementAngle(x: 0.0, y: -1.0),
            IncrementAngle(x: 1.0, y: 0.0),
            IncrementAngle(x: 0.0, y: 1.0),
            IncrementAngle(x: -1.0, y: 0.0)
        ]
    }
    
    func updateClock() {
        let calendar = NSCalendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        let midnight = calendar.date(from: components)!
        let difference = calendar.dateComponents([.minute], from: midnight, to: now)
        hourRotation = Double(difference.minute! % 720) / 720 * 360 - 90
        let minutes = Double(calendar.component(.minute, from: now))
        minuteRotation = minutes / 60 * 360 - 90
    }
    
    var body: some View {
        ZStack {
            glowing ? theme.colorAGlow : theme.colorA
            ZStack {
                Image("minute-hand").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: minuteWidth).rotationEffect(.degrees(minuteRotation)).foregroundColor(glowing ? theme.colorCGlow : theme.colorC)
                Image("hour-hand").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: hourWidth).rotationEffect(.degrees(hourRotation)).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                ForEach(fiveMinuteAngles) { angle in
                    Image("five-minute-increment").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: incrementWidth).offset(x: angle.x * (minuteWidth / 2 + incrementSpacing), y: angle.y * (minuteWidth / 2 + incrementSpacing)).foregroundColor(glowing ? theme.colorBGlow : theme.colorB)
                }
                ForEach(fifteenMinuteAngles) { angle in
                    Image("fifteen-minute-increment").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: incrementWidth).offset(x: angle.x * (minuteWidth / 2 + incrementSpacing), y: angle.y * (minuteWidth / 2 + incrementSpacing)).foregroundColor(glowing ? theme.colorCGlow : theme.colorC)
                }
            }.onReceive(timer) { _ in
                if glowing && Int(Date().timeIntervalSince1970) - lastTime > 3 {
                    glowing = false
                }
                updateClock()
            }.onAppear(perform: updateClock)
        }.gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ touch in
                    glowing = true
                    lastTime = Int(Date().timeIntervalSince1970)
                })
                .onEnded({ touch in
                    glowing = false
                })
        )
    }
}

struct AnalogWatch_Previews: PreviewProvider {
    static var previews: some View {
        AnalogWatch(theme: Theme()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
