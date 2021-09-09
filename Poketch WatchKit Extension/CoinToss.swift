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
    
    let coinWidth = 64.0
    let flipHeight = 80.0
    let initialCoinOffset = 47.0

    init(theme: Theme) {
        self.theme = theme
        self.coinOffset = initialCoinOffset
    }
    
    func flip() {
        let timings = [1.0, 0.7, 0.5, 0.2]
        var delay = 0.0
        for time in timings {
            withAnimation(.easeOut(duration: time / 2).delay(delay)) {
                coinOffset = initialCoinOffset - (flipHeight * (time / timings[0]))
            }
            withAnimation(.easeIn(duration: time / 2).delay(delay + time / 2)) {
                coinOffset = initialCoinOffset
            }
            delay += time
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay - 0.1) {
            setCoin(heads: Bool.random())
        }
    }
    
    func setCoin(heads: Bool) {
        if (heads) {
            coinSide = "fish"
        } else {
            coinSide = "ball"
        }
    }
    
    var body: some View {
        ZStack {
            theme.colorA
            Image("coin-toss-line").renderingMode(.template).interpolation(.none).resizable().frame(height: 16).foregroundColor(theme.colorB).offset(y: 10)
            ZStack {
                Image("coin-" + coinSide + "-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorA).offset(y: coinOffset).frame(width: coinWidth)
                Image("coin-" + coinSide + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorB).offset(y: coinOffset).frame(width: coinWidth)
                Image("coin-" + coinSide + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).foregroundColor(theme.colorC).offset(y: coinOffset).frame(width: coinWidth)
            }
        }.onTapGesture() {
            flip()
        }
    }
}

struct CointToss_Previews: PreviewProvider {
    static var previews: some View {
        CoinToss(theme: Theme()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 44mm")
//        CointToss(theme: Theme()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 44mm")
    }
}
