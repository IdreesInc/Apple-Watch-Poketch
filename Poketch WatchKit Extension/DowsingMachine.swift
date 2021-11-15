//
//  DowsingMachine.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/14/21.
//

import SwiftUI

struct DowsingMachine: View {
    
    @EnvironmentObject var config: Config
    
    @State var pressed = false
    @State var pinging = false
    @State var pingSize = 0.0
    @State var pingLocation = CGPoint()
    @State var pingColor = 0.0
    
    let maxPingSize = 104.0 // Original: 96.0
    let timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            config.theme.colorA
            Image("dowsing-machine-grid").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fill).frame(width: WKInterfaceDevice.current().screenBounds.width, height: WKInterfaceDevice.current().screenBounds.height).foregroundColor(config.theme.colorC)
            Image("dowsing-machine-ping").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: pingSize).foregroundColor(pingColor <= 0 ? .clear : pingColor <= 1 ? config.theme.colorC : config.theme.colorD).offset(x: pingLocation.x, y: pingLocation.y)
                .onReceive(timer) { _ in
                    if pinging {
                        if pingSize == 32 {
                            WKInterfaceDevice.current().play(.success)
                        }
                        if pingSize < maxPingSize {
                            pingSize += 8
                        } else {
                            pingColor -= 0.6
                            if pingColor <= 0 {
                                pinging = false
                            }
                        }
                    }
                }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ touch in
                    if !pressed && abs(touch.translation.width) < 5 {
                        pingSize = 0
                        pingColor = 2
                        pingLocation = CGPoint(x: touch.startLocation.x - WKInterfaceDevice.current().screenBounds.width / 2, y: touch.startLocation.y - WKInterfaceDevice.current().screenBounds.height / 2)
                        pinging = true
                    }
                    pressed = true
                })
                .onEnded({ touch in
                    pressed = false
                })
        )
    }
}

struct DowsingMachine_Previews: PreviewProvider {
    static var previews: some View {
        DowsingMachine().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
