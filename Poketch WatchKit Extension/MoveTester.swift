//
//  MoveTester.swift
//  MoveTester
//
//  Created by Idrees Hassan on 10/22/21.
//

import SwiftUI

struct MoveTester: View {
    
    @EnvironmentObject var config: Config
    
    @State var attackType = "normal"
    @State var defensePrimaryType = "normal"
    @State var defenseSecondaryType = "none"
    
    private var strength: Int {
        let defensePrimary = types[defensePrimaryType]
        let defenseSecondary = types[defenseSecondaryType]
        if defensePrimary!.immunities.contains(attackType) ||  defenseSecondary!.immunities.contains(attackType) {
            return 0
        }
        var multiplier = 1.0
        if defensePrimary!.weaknesses.contains(attackType) {
            multiplier *= 2
        }
        if defensePrimary!.resistances.contains(attackType) {
            multiplier /= 2
        }
        if defensePrimaryType != defenseSecondaryType {
            if defenseSecondary!.weaknesses.contains(attackType) {
                multiplier *= 2
            }
            if defenseSecondary!.resistances.contains(attackType) {
                multiplier /= 2
            }
        }
        switch multiplier {
        case 4:
            return 5
        case 2:
            return 4
        case 1:
            return 3
        case 0.5:
            return 2
        case 0.25:
            return 1
        default:
            return 0
        }
    }
    
    private var effectivenessText: String {
        if strength == 0 {
            return "not-effective"
        } else if strength < 3 {
            return "not-very-effective"
        } else if strength == 3 {
            return "regularly-effective"
        } else if strength > 3 {
            return "super-effective"
        } else {
            return "regularly-effective"
        }
    }
    
    let dialogueFrameHeight = 32.0
    let exclamationFrameWidth = 56.0
    let exclamationMarkWidth = 5.0
    let textHeight = 12.0
    let types = [
        "none": MoveType(name: "none", weaknesses: [], resistances: [], immunities: []),
        "normal": MoveType(name: "normal", weaknesses: ["fighting"], resistances: [], immunities: ["ghost"]),
        "fire": MoveType(name: "fire", weaknesses: ["ground", "rock", "water"], resistances: ["bug", "steel", "fire", "grass", "ice", "fairy"], immunities: []),
        "water": MoveType(name: "water", weaknesses: ["grass", "electric"], resistances: ["steel", "fire", "water", "ice"], immunities: []),
        "electric": MoveType(name: "electric", weaknesses: ["ground"], resistances: ["flying", "steel", "electric"], immunities: []),
        "grass": MoveType(name: "grass", weaknesses: ["flying", "poison", "bug", "fire", "ice"], resistances: ["ground", "water", "grass", "electric"], immunities: []),
        "ice": MoveType(name: "ice", weaknesses: ["fighting", "rock", "steel", "fire"], resistances: ["ice"], immunities: []),
        "fighting": MoveType(name: "fighting", weaknesses: ["flying", "psychic", "fairy"], resistances: ["rock", "bug", "dark"], immunities: []),
        "poison": MoveType(name: "poison", weaknesses: ["ground", "psychic"], resistances: ["fighting", "poison", "bug", "grass", "fairy"], immunities: []),
        "ground": MoveType(name: "ground", weaknesses: ["water", "grass", "ice"], resistances: ["poison", "rock"], immunities: ["electric"]),
        "flying": MoveType(name: "flying", weaknesses: ["rock", "electric", "ice"], resistances: ["fighting", "bug", "grass"], immunities: ["ground"]),
        "psychic": MoveType(name: "psychic", weaknesses: ["bug", "ghost", "dark"], resistances: ["fighting", "psychic"], immunities: []),
        "bug": MoveType(name: "bug", weaknesses: ["flying", "rock", "fire"], resistances: ["fighting", "ground", "grass"], immunities: []),
        "rock": MoveType(name: "rock", weaknesses: ["fighting", "ground", "steel", "water", "grass"], resistances: ["normal", "flying", "poison", "fire"], immunities: []),
        "ghost": MoveType(name: "ghost", weaknesses: ["ghost", "dark"], resistances: ["poison", "bug"], immunities: ["normal", "fighting"]),
        "dragon": MoveType(name: "dragon", weaknesses: ["ice", "dragon", "fairy"], resistances: ["fire", "water", "grass", "electric"], immunities: []),
        "dark": MoveType(name: "dark", weaknesses: ["fighting", "bug", "fairy"], resistances: ["ghost", "dark"], immunities: ["psychic"]),
        "steel": MoveType(name: "steel", weaknesses: ["fighting", "ground", "fire"], resistances: ["normal", "flying", "rock", "bug", "steel", "grass", "psychic", "ice", "dragon", "fairy"], immunities: ["poison"]),
        "fairy": MoveType(name: "fairy", weaknesses: ["poison", "steel"], resistances: ["fighting", "bug", "dark"], immunities: ["dragon"])
    ]
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack(spacing: 0.0) {
                HStack(spacing: 0.0) {
                    Spacer()
                    ZStack {
                        Image("move-tester-bubble").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationFrameWidth).foregroundColor(config.theme.colorB)
                        HStack(spacing: 2.0) {
                            Image("move-tester-exclamation-mark").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationMarkWidth).foregroundColor(config.theme.colorC).opacity(strength > 0 ? 1.0 : 0.0)
                            Image("move-tester-exclamation-mark").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationMarkWidth).foregroundColor(config.theme.colorC).opacity(strength > 1 ? 1.0 : 0.0)
                            Image("move-tester-exclamation-mark").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationMarkWidth).foregroundColor(config.theme.colorC).opacity(strength > 2 ? 1.0 : 0.0)
                            Image("move-tester-exclamation-mark").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationMarkWidth).foregroundColor(config.theme.colorC).opacity(strength > 3 ? 1.0 : 0.0)
                            Image("move-tester-exclamation-mark").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: exclamationMarkWidth).foregroundColor(config.theme.colorC).opacity(strength > 4 ? 1.0 : 0.0)
                        }.offset(x: -4.0)
                    }.offset(x: -2.0, y: -12.0)
                    VStack(spacing: 0.0) {
                        Image("move-tester-defense-top").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 48.0 * 0.8).foregroundColor(config.theme.colorB)
                        TypeSelect(type: $defensePrimaryType)
                        TypeSelect(type: $defenseSecondaryType, defaultTypeIndex: 0)
                        ZStack {
                            Image("move-tester-defense-bottom-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 80.0 * 0.8).foregroundColor(config.theme.colorB)
                            Image("move-tester-defense-bottom-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 80.0 * 0.8).foregroundColor(config.theme.colorC)
                        }
                    }
                }.offset(y: 20.0)
                Image("move-tester-arrow").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 26.0 * 1.0).foregroundColor(config.theme.colorB).offset(x: -20.0, y: 22.0)
                HStack() {
                    Image("move-tester-offense-top").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 46.0 * 0.8).foregroundColor(config.theme.colorB)
                    Spacer()
                }
                HStack() {
                    VStack(spacing: 0.0) {
                        TypeSelect(type: $attackType)
                    }
                    Spacer()
                }
                ZStack {
                    HStack(spacing: 0.0) {
                        ZStack {
                            Image("move-tester-dialogue-left-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorA)
                            Image("move-tester-dialogue-left-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("move-tester-dialogue-middle-a").renderingMode(.template).interpolation(.none).resizable().frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorA)
                            Image("move-tester-dialogue-middle-d").renderingMode(.template).interpolation(.none).resizable().frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("move-tester-dialogue-right-a").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorA)
                            Image("move-tester-dialogue-right-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: dialogueFrameHeight).foregroundColor(config.theme.colorD)
                        }
                    }
                    HStack {
                        ZStack {
                            Image("move-tester-" + effectivenessText + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: textHeight).foregroundColor(config.theme.colorC)
                            Image("move-tester-" + effectivenessText + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(height: textHeight).foregroundColor(config.theme.colorD)
                        }.offset(x: 10.0)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MoveTester_Previews: PreviewProvider {
    static var previews: some View {
        MoveTester().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
