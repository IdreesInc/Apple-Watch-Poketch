//
//  TypeSelect.swift
//  TypeSelect
//
//  Created by Idrees Hassan on 10/22/21.
//

import SwiftUI

struct MoveType {
    let name: String
    let weaknesses: [String]
    let resistances: [String]
    let immunities: [String]
}

struct TypeSelect: View {
    
    @EnvironmentObject var config: Config
    @Binding var type: String
    
    @State var leftPressed = ""
    @State var rightPressed = ""
    @State var currentTypeIndex: Int
    @State var allowNone: Bool
    
    let buttonWidth = 24.0 * 7/8
    let frameWidth = 64.0 * 7/8
    let textHeight = 10.0
    // Type order same as Poketch with Fairy type added
    let types = ["none", "normal", "fire", "water", "electric", "grass", "ice", "fighting", "poison", "ground", "flying", "psychic", "bug", "rock", "ghost", "dragon", "dark", "steel", "fairy"]
    
    init(type: Binding<String>, defaultTypeIndex: Int = 1) {
        _type = type
        currentTypeIndex = defaultTypeIndex
        allowNone = defaultTypeIndex == 0
        print(currentTypeIndex)
    }
    
    var body: some View {
        HStack(spacing: 0.0) {
            ZStack {
                Image("move-tester-left" + leftPressed + "-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorA)
                Image("move-tester-left" + leftPressed + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                Image("move-tester-left" + leftPressed + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                Image("move-tester-left" + leftPressed + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
            }.gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ touch in
                        leftPressed = "-pressed"
                    })
                    .onEnded({ touch in
                        leftPressed = ""
                        if currentTypeIndex > (allowNone ? 0 : 1) {
                            currentTypeIndex = currentTypeIndex - 1
                        } else {
                            currentTypeIndex = types.count - 1
                        }
                        type = types[currentTypeIndex]
                    })
            )
            ZStack {
                Image("move-tester-type-frame-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: frameWidth).foregroundColor(config.theme.colorA)
                Image("move-tester-type-frame-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: frameWidth).foregroundColor(config.theme.colorB)
                ZStack {
                    Image("move-tester-" + types[currentTypeIndex] + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: textHeight).foregroundColor(config.theme.colorC)
                    Image("move-tester-" + types[currentTypeIndex] + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: textHeight).foregroundColor(config.theme.colorD)
                }
            }
            ZStack {
                Image("move-tester-right" + rightPressed + "-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorA)
                Image("move-tester-right" + rightPressed + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                Image("move-tester-right" + rightPressed + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                Image("move-tester-right" + rightPressed + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
            }.gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ touch in
                        rightPressed = "-pressed"
                    })
                    .onEnded({ touch in
                        rightPressed = ""
                        if currentTypeIndex == types.count - 1 {
                            currentTypeIndex = allowNone ? 0 : 1
                        } else {
                            currentTypeIndex = currentTypeIndex + 1
                        }
                        type = types[currentTypeIndex]
                    })
            )
        }
    }
}

struct TypeSelect_Previews: PreviewProvider {
        
    static var previews: some View {
        TypeSelect_PreviewWrapper()
    }
    
    struct TypeSelect_PreviewWrapper: View {
        @State(initialValue: "normal") var type: String

        var body: some View {
            TypeSelect(type: $type).environmentObject(Config())
        }
    }
}
