//
//  Day27ViewModel.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/26/26.
//

import CoreML
import SwiftUI

@Observable
class Day27ViewModel {
    static var defaultWakeUp : Date {
         var component = DateComponents()
         component.hour = 7
         component.minute = 0
         return Calendar.current.date(from: component) ?? .now
         
     }
     
       var wakeUp = defaultWakeUp
       var sleepHours = 8.0
       var coffeeAmount = 1
     
       var alertTitle = ""
       var alertMessage = ""
       var showAlert = false
    
    
    func calculateBedTime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let componnet = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = ( componnet.hour ?? 0) * 60 * 60
            let min = ( componnet.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double (hour + min), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal sleep time ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            
            alertTitle = "Something went wrong"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
    showAlert = true
    }
}
