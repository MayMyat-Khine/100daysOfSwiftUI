//
//  ContentView.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var student = "Khine"
    let students = ["Khine","May","Ohmar","Thit"]
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tip = 10
    let tips = [0,10,20,30,40,50,60,70,80,90,100]
    
    @FocusState private var amountIsFocused : Bool
    var totalPerPerson : Double {
        let  peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tip)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let perPerson = grandTotal / peopleCount
        return perPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Check Amount", value: $checkAmount, format : .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) of people")
                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip you want to leave?"){
                    Picker("Tip percentage",selection :$tip){
                        ForEach(0...100, id: \.self){
                            Text($0, format : .percent )
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Total Amount"){
                    Text("\(checkAmount + (checkAmount / 100 * Double(tip)) )").foregroundStyle(tip  == 0 ? .red : .white)
                }
                
                Section("Amount Per Person"){
                    Text("\(totalPerPerson)")
                }
                
            }
           
        }
        .navigationTitle("We Split")
        .toolbar{
            if amountIsFocused {
                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
//        Form{
//            Picker("Select Student",selection:$student){
//                ForEach( students ,id: \.self){
//                    Text($0)
//                }
//            }
//        }
        
    }
}

#Preview {
    ContentView()
}
