//
//  Day21.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/17/26.
//

import SwiftUI

struct FlagImage : View {
    var img : String
    var body : some View{
        Image(img).clipShape(.capsule).shadow(color: .red,radius: 5,)
    }
}
struct Day21:View{
  @State  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State  var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var yourPickIndex = 0
    @State private var count = 0
    @State private var reset = false
    var body:some View{
        ZStack {
            /*LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom)*/
            RadialGradient(stops: [.init(color:Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color:  Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                      .font(.largeTitle.weight(.bold))
                      .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    ForEach(0..<3) { number in
                        Button {
                            if(count < 8 ) {
                                count = count + 1
                                flagTapped(number)
                            }else{
                             reset = true
                            }
                           
                        } label: {
                            FlagImage(img: countries[number])
                        }
                    }
                }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }.alert(scoreTitle , isPresented:  $showingScore){
            Button("Continue",action: askQuestion)
        }message: {
           
            Text("Your score is \(score) " + (scoreTitle == "Wrong" ? "Wrong!! This is flag of \(countries[yourPickIndex])": ""))
               
           
        }.alert("You played 8 matcher. Want to reset?", isPresented: $reset){
            Button("Reset",action :resetAll)
            Button("Cancel", role: .destructive){}
        }
        
    }
    
    func flagTapped(_ number:Int){
        yourPickIndex = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        }else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetAll (){
       askQuestion()
        score = 0
        count = 0
    }
}

#Preview(){
    Day21()
}
