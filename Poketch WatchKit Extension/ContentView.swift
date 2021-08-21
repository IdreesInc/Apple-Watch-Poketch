//
//  ContentView.swift
//  Etch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameView()
            TimeView()
            SpaceView()
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
