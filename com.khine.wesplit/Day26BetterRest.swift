//
//  BetterRestDay26.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/24/26.
//

import SwiftUI

struct Day26BetterRest : View {
    @State private var sleepHours = 8.0
    @State private var wakeUp = Date.now
    let tmr = Date.now.addingTimeInterval(86400) // add to tmr in second
    
  @State private  var showDateFromComponent : Date?
  @State private  var showDateComponentFromDate : DateComponents?
    
    
    var body : some View {
        
        VStack {
            Stepper("\(sleepHours.formatted()) hours", value: $sleepHours,in: 4...15,step: 0.25)
            
            DatePicker("Please pick a date", selection: $wakeUp, in: Date.now...,displayedComponents: .date)
                .labelsHidden()
            
            DatePicker("Pick data",selection:  $wakeUp, in : Date.now...tmr)
            
            Button("Click to show Date"){
                setWithDateComponent()
            }
            Text(showDateFromComponent ?? .now,format: .dateTime.hour().minute())
            Text("This is from Date \(showDateComponentFromDate?.hour): \(showDateComponentFromDate?.minute)")
            Text(Date.now.formatted(.dateTime.day().month().year()))
            Text(Date.now.formatted(date : .long , time:  .shortened))
        }
    }

    func setWithDateComponent(){
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        let date = Calendar.current.date(from: component) ?? .now
        showDateFromComponent = date
        print(date) // Set Custom date with DateComponent and convert it to Date
   print(showDateFromComponent)
        
        let secondComponent = Calendar.current.dateComponents([.hour,.minute], from: Date.now)
        
        let hour = secondComponent.hour ?? 0
        let min = secondComponent.minute ?? 0
      
        showDateComponentFromDate = secondComponent
        print(showDateComponentFromDate)
        print("Hour \(hour) Min \(min)")
    }
    
    
}

#Preview {
    Day26BetterRest()
}
