//
//  Pedometer.swift
//  Pedometer
//
//  Created by Idrees Hassan on 10/19/21.
//

import SwiftUI
import HealthKit

struct Pedometer: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    @EnvironmentObject var config: Config

    @GestureState var press = false
    
    @State var healthkitInitialized = false
    @State var steps = 0
    @State var digitOne = "0"
    @State var digitTwo = "0"
    @State var digitThree = "0"
    @State var digitFour = "0"
    @State var digitFive = "0"
    @State var clearButtonPressed = ""
    
    let width = 20.0
    let frameWidth = 20.0 * 5 * 1.3 // Slightly bigger than counter frame
    let buttonWidth = 80.0
    
    var healthStore = HKHealthStore()
    
    func initHealthStuff() {
        if !healthkitInitialized {
            print("Initializing HealthKit stuff")
            authorizeHealthKit()
            startStepsQuery()
            healthkitInitialized = true
        }
    }
    
    func authorizeHealthKit() {
         let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!]
         healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
     }
    
    func startStepsQuery() {
        // Only monitor Apple Watch steps
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // Start with today's steps
        let calendar = NSCalendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        guard let startDate = calendar.date(from: components) else {
            fatalError("Unable to create today's date")
        }
        let timePredicate = HKQuery.predicateForSamples(withStart: startDate, end: nil, options:[])
        
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [devicePredicate, timePredicate])
       
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = { query, samples, deletedObjects, queryAnchor, error in
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            self.processSamples(samples)
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!, predicate: combinedPredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        healthStore.execute(query)
    }
    
    func processSamples(_ samples: [HKQuantitySample]) {
        for sample in samples {
            steps += Int(sample.quantity.doubleValue(for: HKUnit(from: "count")))
        }
        DispatchQueue.main.async {
            updateStepsCount()
        }
    }
    
    func updateStepsCount() {
        let numberString = String(format: "%05d", steps)
        let digits = Array(numberString)
        let count = digits.count
        self.digitOne = String(digits[count - 5])
        self.digitTwo = String(digits[count - 4])
        self.digitThree = String(digits[count - 3])
        self.digitFour = String(digits[count - 2])
        self.digitFive = String(digits[count - 1])
    }
    
    func clearSteps() {
        steps = 0
        updateStepsCount()
    }
    
    var body: some View {
        ZStack {
            config.theme.colorA
            VStack (spacing: 10.0) {
                ZStack {
                    Image("pedometer-frame").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: frameWidth).foregroundColor(config.theme.colorB).offset(y: width / 16.0)
                    HStack (spacing: 0) {
                        ZStack {
                            Image("counter-digit-" + digitOne + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitOne + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitTwo + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitTwo + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitThree + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitThree + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitFour + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitFour + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                        ZStack {
                            Image("counter-digit-" + digitFive + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorB)
                            Image("counter-digit-" + digitFive + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: width).foregroundColor(config.theme.colorD)
                        }
                    }.onAppear(perform: initHealthStuff)
                }
                ZStack {
                    Image("pedometer-button" + clearButtonPressed + "-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorB)
                    Image("pedometer-button" + clearButtonPressed + "-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorC)
                    Image("pedometer-button" + clearButtonPressed + "-d").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: buttonWidth).foregroundColor(config.theme.colorD)
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            clearButtonPressed = "-pressed"
                        })
                        .onEnded({ touch in
                            clearButtonPressed = ""
                            clearSteps()
                        })
                )
            }.offset(y: 0.0)
        }
    }
}

struct Pedometer_Previews: PreviewProvider {
    static var previews: some View {
        Pedometer().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
