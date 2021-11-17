//
//  Calculator.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/13/21.
//

import SwiftUI

struct Calculator: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced

    @EnvironmentObject var config: Config
    
    @State var previousValue = Decimal(0.0)
    @State var currentValue = "0"
    @State var decimalMode = false
    @State var selectedFunction = "empty"
    @State var functionLocked = false
    @State var overflow = false
    @State var lastFunction = ""
    @State var lastValue = ""
    
    let spacing = 2.0 // Original: 2.0
    let maxDigits = 9
    
    func addDigit(digit: Int) {
        overflow = false
        lastFunction = ""
        lastValue = ""
        if !selectedFunction.isEmpty && !functionLocked {
            functionLocked = true
            currentValue = "0"
        }
        if decimalMode {
            if !currentValue.contains(".") {
                currentValue += "."
            }
        }
        currentValue = currentValue + String(digit)
        if currentValue.hasPrefix("0") && !currentValue.hasPrefix("0.") {
            currentValue = String(currentValue.suffix(currentValue.count - 1))
        }
    }
    
    func getDigit(digit: Int) -> String {
        if overflow {
            return "question-mark"
        }
        var string = "\(currentValue)"
        if string.hasSuffix(".0") {
            string = String(string.prefix(string.count - 2))
        }
        while string.count < maxDigits {
            string =  "-" + string
        }
        if digit > string.count {
            return "empty"
        }
        let result = String(string.prefix(digit).suffix(1)) // Swift substring is a nightmare so I'm taking the easy way out
        if result == "-" {
            return "empty"
        } else if result == "." {
            return "decimal"
        }
        return result
    }
    
    func calculate() {
        if overflow {
            return
        }
        if !lastFunction.isEmpty && selectedFunction == "empty" {
            selectedFunction = lastFunction
            previousValue = Decimal(string: currentValue)!
            currentValue = lastValue
        }
        print("current: " + currentValue)
        print("previous: " + NSDecimalNumber(decimal: previousValue).stringValue)
        print("function: " + selectedFunction)
        lastValue = currentValue
        var convertedValue = Decimal(string: currentValue)!
        if selectedFunction == "add" {
            convertedValue = previousValue + convertedValue
        } else if selectedFunction == "subtract" {
            convertedValue = previousValue - convertedValue
        } else if selectedFunction == "multiply" {
            convertedValue = previousValue * convertedValue
        } else if selectedFunction == "divide" {
            convertedValue = previousValue / convertedValue
        }
        if !convertedValue.isFinite || convertedValue >= pow(10, maxDigits) {
            clear()
            overflow = true
            print("Overflow!")
        }
        currentValue = NSDecimalNumber(decimal: convertedValue).stringValue
        print("result: " + currentValue)
        lastFunction = selectedFunction
        selectedFunction = "empty"
        functionLocked = false
        decimalMode = false
    }
    
    func clear() {
        decimalMode = false
        currentValue = "0"
        previousValue = 0.0
        selectedFunction = "empty"
        lastFunction = ""
        lastValue = ""
        functionLocked = false
        overflow = false
    }
    
    func selectFunction(function: String) {
        if overflow {
            return
        }
        if functionLocked {
            calculate()
        }
        selectedFunction = function
        previousValue = Decimal(string: currentValue)!
    }
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack(spacing: spacing) {
                HStack(spacing: 0.0) {
                    ZStack {
                        Image("output-function-" + selectedFunction + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 22.0).foregroundColor(config.theme.colorB)
                        Image("output-function-" + selectedFunction + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 22.0).foregroundColor(config.theme.colorD)
                    }
                    ForEach(1...maxDigits, id: \.self) { i in
                        ZStack {
                            Image("output-digit-" + getDigit(digit: i) + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 14.0).foregroundColor(config.theme.colorB)
                            Image("output-digit-" + getDigit(digit: i) + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 14.0).foregroundColor(config.theme.colorD)
                        }
                    }
                    Image("output-endcap-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: 6.0).foregroundColor(config.theme.colorD)
                }
                HStack(spacing: spacing) {
                    CalculatorButton(onRelease: {
                        addDigit(digit: 7)
                    }, symbol: "7", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 8)
                    }, symbol: "8", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 9)
                    }, symbol: "9", big: false)
                    CalculatorButton(onRelease: {
                        clear()
                    }, symbol: "clear", big: true)
                }
                HStack(spacing: spacing) {
                    CalculatorButton(onRelease: {
                        addDigit(digit: 4)
                    }, symbol: "4", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 5)
                    }, symbol: "5", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 6)
                    }, symbol: "6", big: false)
                    CalculatorButton(onRelease: {
                        selectFunction(function: "add")
                    }, symbol: "add", big: false)
                    CalculatorButton(onRelease: {
                        selectFunction(function: "subtract")
                    }, symbol: "subtract", big: false)
                }
                HStack(spacing: spacing) {
                    CalculatorButton(onRelease: {
                        addDigit(digit: 1)
                    }, symbol: "1", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 2)
                    }, symbol: "2", big: false)
                    CalculatorButton(onRelease: {
                        addDigit(digit: 3)
                    }, symbol: "3", big: false)
                    CalculatorButton(onRelease: {
                        selectFunction(function: "multiply")
                    }, symbol: "multiply", big: false)
                    CalculatorButton(onRelease: {
                        selectFunction(function: "divide")
                    }, symbol: "divide", big: false)
                }
                HStack(spacing: spacing) {
                    CalculatorButton(onRelease: {
                        addDigit(digit: 0)
                    }, symbol: "0", big: true)
                    CalculatorButton(onRelease: {
                        decimalMode = true
                    }, symbol: "dot", big: false)
                    CalculatorButton(onRelease: {
                        calculate()
                    }, symbol: "equals", big: true)
                }
            }
        }
    }
}

struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
