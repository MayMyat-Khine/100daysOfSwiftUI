//
//  Day27.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/25/26.
//


import SwiftUI

struct Day27 : View {
   
@State private var vm = Day27ViewModel()
  
    var body : some View {
        NavigationStack{
            Form{
                Section("When do you want to wake up"){
                    DatePicker("Please enter a time",selection: $vm.wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
               
                
                VStack{
                    Text("Desired amount of sleep").font(.headline)
                    Stepper("\(vm.sleepHours.formatted()) hours",value:  $vm.sleepHours,in : 4...12 , step: 0.25)
                    
                }
             CupsView(vm: $vm)
//                    Stepper("^[\(coffeeAmount) cup](inflect:true) of coffee", value:  $coffeeAmount, in : 1 ... 20)
                .alert(vm.alertTitle, isPresented: $vm.showAlert){
                            Button("OK"){}
                        }message: {
                            Text(vm.alertMessage)
                        }
                
            }
            .navigationTitle("BetterRest")
                .toolbar{
                    Button("Calculate",action: vm.calculateBedTime)
                }
            }
    }
}
#Preview {
    Day27()
}


struct CupsView : View {
  @Binding var vm : Day27ViewModel
    var body : some View {
        VStack{
            Text("Daily coffee intake").font(.headline)
            Picker("^[\(vm.coffeeAmount) cup](inflect:true) of coffee", selection:$vm.coffeeAmount){
                ForEach(1...20, id : \.self){ id in
                    Text(String(describing: id))
                }
            }}
    }
}
