//
//  CoinToss.swift
//  CoinToss
//
//  Created by Idrees Hassan on 9/8/21.
//

import SwiftUI

struct CoinToss: View {
    
    @ObservedObject var theme: Theme
    
    @State var coinSide = "fish"
    @State var coinOffset: Double
    @State var flipping = false
    @State var coinAnimationFrame = 0
    @State var outcome: Bool = false
    
    let coinWidth = 68.0
    let flipHeight = 90.0
    let initialCoinOffset = 59.0
    let timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    init(theme: Theme) {
        self.theme = theme
        self.coinOffset = initialCoinOffset
    }
    
    func flip() {
        let timings = [1.0, 0.7, 0.5, 0.25]
        var delay = 0.0
        flipping = true
        outcome = Bool.random()
        coinAnimationFrame = 32
        var index = 0.0
        for time in timings {
            withAnimation(.easeOut(duration: time / 2).delay(delay)) {
                coinOffset = initialCoinOffset - (flipHeight * (1 / pow(2, index)))
            }
            withAnimation(.easeIn(duration: time / 2).delay(delay + time / 2)) {
                coinOffset = initialCoinOffset
            }
            index = index + 1
            delay += time
        }
    }
    
    func setCoin(heads: Bool) {
        if heads {
            coinSide = "fish"
        } else {
            coinSide = "ball"
        }
    }
    
    var body: some View {
        ZStack {
            theme.colorA
            Image("coin-toss-line").renderingMode(.template).interpolation(.none).resizable().frame(height: 16).foregroundColor(theme.colorB).offset(y: 20)
            ZStack {
                Image("coin-" + coinSide + "-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorA).offset(y: coinOffset).frame(width: coinWidth)
                Image("coin-" + coinSide + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorB).offset(y: coinOffset).frame(width: coinWidth)
                Image("coin-" + coinSide + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorC).offset(y: coinOffset).frame(width: coinWidth)
            }.onReceive(timer) { _ in
                if (flipping) {
                    coinAnimationFrame = coinAnimationFrame - 1
                    if coinAnimationFrame % 4 == (outcome ? 0 : 2) {
                        coinSide = "fish"
                    } else if coinAnimationFrame % 4 == 1 {
                        coinSide = "flip"
                    } else if coinAnimationFrame % 4 == (outcome ? 2 : 0) {
                        coinSide = "ball"
                    } else if coinAnimationFrame % 4 == 3 {
                        coinSide = "flip"
                    }
                    if coinAnimationFrame == 0 {
                        flipping = false
                    }
                }
            }
        }.onTapGesture() {
            flip()
            flipping = true
        }
    }
}

struct CoinToss_Previews: PreviewProvider {
    static var previews: some View {
        CoinToss(theme: Theme()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
