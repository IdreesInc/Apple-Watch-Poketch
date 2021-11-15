//
//  CalculatorButton.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/13/21.
//

import SwiftUI

struct CalculatorButton: View {
    
    @EnvironmentObject var config: Config
    
    @State var pressed = false

    var onRelease: () -> Void
    var symbol: String
    var big = false
    
    let smallButtonWidth = 30.0 // Original: 30.0
    let bigButtonWidth = 62.0 // Original: 62.0
    let pressOffset = 4.0 // Original: 4.0
    
    var body: some View {
        ZStack {
            Image((big ? "big" : "small") + "-button" + (pressed ? "-pressed" : "") + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: big ? bigButtonWidth : smallButtonWidth).foregroundColor(config.theme.colorB)
            Image((big ? "big" : "small") + "-button" + (pressed ? "-pressed" : "") + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: big ? bigButtonWidth : smallButtonWidth).foregroundColor(config.theme.colorC)
            Image((big ? "big" : "small") + "-button" + (pressed ? "-pressed" : "") + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: big ? bigButtonWidth : smallButtonWidth).foregroundColor(config.theme.colorD)
            Image((big ? "big" : "small") + "-button-" + symbol).renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: big ? bigButtonWidth : smallButtonWidth).foregroundColor(config.theme.colorD).offset(y: pressed ? pressOffset : 0.0)
        }.gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ touch in
                    pressed = true
                })
                .onEnded({ touch in
                    pressed = false
                    self.onRelease()
                })
        )
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(onRelease: {
            print("Hiya")
        }, symbol: "7", big: false).environmentObject(Config())
    }
}
