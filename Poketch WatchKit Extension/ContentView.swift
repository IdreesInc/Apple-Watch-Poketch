//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI
import Dynamic

struct ContentView: View {
    @EnvironmentObject var config: Config
    
    @State var views: [AnyView] = []
    @State var viewIndex = 0
    @State var scrollAmount = 1.0
    @State var touchTime: Date? = Date()
    
    init() {
        // This is a private API and will most likely break in future updates
        let app = Dynamic.PUICApplication.sharedPUICApplication()
        app._setStatusBarTimeHidden(true, animated: false, completion: nil)
    }
    
    var body: some View {
        ZStack {
            if views.count > 0 {
                views[viewIndex]
            }
        }
        .focusable(true)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ touch in
                    if touchTime == nil {
                        touchTime = Date()
                    }
                })
                .onEnded({ touch in
                    if touchTime == nil || abs(touchTime!.timeIntervalSinceNow) < 0.7 {
                        if abs(touch.translation.width) > abs(touch.translation.height) && abs(touch.translation.width) > WKInterfaceDevice.current().screenBounds.width * 0.5 {
                            if touch.startLocation.x < touch.location.x {
                                print("Swipe left")
                                viewIndex -= 1
                            } else {
                                print("Swipe right")
                                viewIndex += 1
                            }
                            if viewIndex > views.count - 1 {
                                viewIndex = 0
                            } else if viewIndex < 0 {
                                viewIndex = views.count - 1
                            }
                            scrollAmount = Double(viewIndex + 1)
                        }
                    }
                    touchTime = nil
                })
        )
        .digitalCrownRotation($scrollAmount, from: 0, through: Double(views.count), by: 1.0, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
        .onChange(of: scrollAmount, perform: { value in
            print(scrollAmount)
            if value < 0.5 {
                viewIndex = views.count - 1
            } else {
                viewIndex = Int(value - 0.5)
            }
        })
        .onAppear() {
            if views.count == 0 {
                views.append(AnyView(Stopwatch().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(DigitalWatch().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Calculator().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Pedometer().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(DowsingMachine().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Counter().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(AnalogWatch().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(MarkingMap().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(CoinToss().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(MoveTester().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(ColorChanger().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Config())
    }
}
