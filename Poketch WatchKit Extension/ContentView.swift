//
//  ContentView.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 8/20/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var theme = Theme()
    
    var body: some View {
        DigitalWatch(theme: theme).ignoresSafeArea(.all).navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
