//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var config: Config
    
    @State var views: [AnyView] = []
    @State var viewIndex = 0
    
    var body: some View {
        ZStack {
            if views.count > 0 {
                views[viewIndex]
            }
        }
        .onAppear() {
            if views.count == 0 {
                views.append(AnyView(Calculator().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(DigitalWatch().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Pedometer().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Counter().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(AnalogWatch().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(CoinToss().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(MoveTester().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(ColorChanger().environmentObject(config).ignoresSafeArea(.all).navigationBarHidden(true)))
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 100)
//                .onChanged({ touch in
//                    print("Touch change")
//                })
                .onEnded({ touch in
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
                })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Config())
    }
}
