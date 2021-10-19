//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var theme = Theme()
    
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
                views.append(AnyView(DigitalWatch(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(CoinToss(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)))
                views.append(AnyView(Counter(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)))
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
        ContentView()
    }
}
