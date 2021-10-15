//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var theme = Theme()
    
    @State var viewIndex = 0
        
    var views: [AnyView] = []
    
    init() {
        views.append(AnyView(DigitalWatch(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)))
        views.append(AnyView(CoinToss(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)))
    }
    
    var body: some View {
        ZStack {
            views[viewIndex]
        }.simultaneousGesture(
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
