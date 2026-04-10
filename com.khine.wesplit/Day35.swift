//
//  Day35.swift
//  com.khine.wesplit
//
//  Created by MayMK on 4/10/26.
//

import SwiftUI

struct Day35 : View {
    @State private var showDetails = false
    
    var body: some View {
        VStack {
                    // We attach the animation directly to the binding ($)
                    Toggle("Show Details", isOn: $showDetails.animation(.spring()))

                    if showDetails {
                        Text("Here are the secret details!")
                    }
            ForEach(0..<5) {
                Text("Row \($0)")
            }
//            ForEach(0...5) {
//                Text("Roww \($0)")
//            }
                }
        .onAppear{
            test()
        }
    }
}

func test(){
    let name = "Paul"
//    let firstLetter = name[0]
   print(name.count)
}
#Preview {
    SettingView()
}
struct GameData : Identifiable {
    let id = UUID()
    let table : Int
    let questions : [Int]
}
struct SettingView : View {
    @State private var selectedUnit = 2
    @State private var count : Int = 0
    @State private var gameData : GameData?
    @State private var alertTitle : String = ""
    @State private var isAlert = false
    @State private var questions : [Int] = []
    @State private var answers : [Int] = []
    @State private var index = 0
    @State private var currentAnswer = 0
    @State private var alertMsg = ""
    @State private var shouldReset = false
    var body: some View {
            Form{
            Section("Which tables do you want to study (2 through 24)?"){
                Stepper("Multiply Table:       \(selectedUnit) ", value: $selectedUnit, in: 2...24)
            }
            LabeledContent("How many questions") {
                TextField("questions count", value: $count,
                          formatter: NumberFormatter()
                )
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
            }
            Button("Start Game"){
                print("Count for start \(count)")
                if (count == 0) {
                    isAlert = true
                    alertTitle = "Fill the Question count"
               
                 
                }else {
                 
                    questions =  prepareForQuestions(count: count)
                    gameData = GameData( table: selectedUnit, questions: questions)
                }
            }
        }
            .alert(alertTitle, isPresented: $isAlert) {
                Button("OK", role: .cancel) {
                    if shouldReset {
                       reset()
                    }
                }
            }message: {
                Text(alertMsg)
            }
            .sheet(item: $gameData){data in
                sheetSubView(data: data)
            }
    }
    
    // used function returning view instead of Computed Sub-view as i want param here
    func sheetSubView(data : GameData) -> some View {
        Form{
                   Text("Your selected Table is \(selectedUnit)")
                   Text("Your Question count is \(count)")
            if (index < data.questions.count) {   LabeledContent("\(selectedUnit) x \(data.questions[index])") {
                TextField("your ansewer", value:$currentAnswer ,
                          formatter: NumberFormatter()
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            }
                           }
            Button("Next"){
                if (currentAnswer == 0){
                    alertTitle = "Please answer this to go next"
                    isAlert = true
                }else{
                    answers.append(currentAnswer)
                    currentAnswer = 0
                    if(index < count - 1){
                        index += 1
                    }else {
                      let result =  calculateResult(answersList: answers, questionsList: questions, table: selectedUnit)
                       alertMsg = "Your score is \(result)"
                        alertTitle = "Well Done!!!!"
                        isAlert = true
                        shouldReset = true
                    }
                }
            }
               }
    }
    
    func reset (){
        selectedUnit = 2
        count = 1
        questions = []
        answers = []
        index = 0
        currentAnswer  = 0
        gameData = nil
    }
 
    func prepareForQuestions(count : Int) -> [Int] {
        let result = Array(1...50).shuffled().prefix(count)
        print(result)
        return Array(result)
    }
    
    //To check the user Answer with Correct Answer
    func calculateResult (answersList : [Int], questionsList : [Int], table : Int) -> Int {
        var totalMark = 0
        for (index, value) in questionsList.enumerated() {
            if(table * value == answersList[index]){
                totalMark += 1
            }
        }
        return totalMark
    }
}
