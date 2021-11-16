//
//  Complication.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/15/21.
//

import SwiftUI
import ClockKit

struct Complication: View {
    
    @Environment(\.complicationRenderingMode) var renderingMode
    
    var body: some View {
        ZStack {
            if renderingMode == .fullColor {
                Image("coin-complication-a").interpolation(.none).resizable()
                Image("coin-complication-b").interpolation(.none).resizable()
                Image("coin-complication-c").interpolation(.none).resizable()
            } else {
                Image("coin-complication-a").interpolation(.none).resizable().opacity(0.7)
                Image("coin-complication-b").interpolation(.none).resizable().opacity(0.55)
                Image("coin-complication-c").interpolation(.none).resizable().opacity(0.35)
            }
            Image("coin-complication-fish").interpolation(.none).resizable().complicationForeground()
        }
    }
}

struct Complication_Previews: PreviewProvider {
    static var previews: some View {
          CLKComplicationTemplateGraphicCircularView(Complication()).previewContext()
        CLKComplicationTemplateGraphicCircularView(Complication()).previewContext(faceColor: .blue)
    }
}
