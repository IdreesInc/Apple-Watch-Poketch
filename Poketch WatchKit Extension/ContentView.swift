//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        TabView {
//            DigitalWatch()
//        }
//        .tabViewStyle(PageTabViewStyle())
        DigitalWatch().ignoresSafeArea(.all).navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
