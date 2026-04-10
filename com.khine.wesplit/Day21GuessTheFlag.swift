//
//  Day21GuessTheFlag.swift
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
struct Day21GuessTheFlag:View{
  @State  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State  var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var yourPickIndex = 0
    @State private var count = 0
    @State private var reset = false
    @State private var animateAmount = 0.0
    @State private var normalSize = true
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
                     animateAmount = 360
                            
                            silentReset()
                            if(count < 8 ) {
                                count = count + 1
                            
                            flagTapped(number)

                       
                            }else{
                             reset = true
                            }
                           
                            normalSize = false
                           
                        } label: {
                            FlagImage(img: countries[number])
                        }.rotation3DEffect(.degrees(yourPickIndex == number ? animateAmount : 0.0), axis: (x:0 , y: 1, z: 1))
                            .animation(yourPickIndex == number ? .spring : nil, value : animateAmount)
                            .opacity(normalSize ? 1 : yourPickIndex == number ? 1 : 0.25)
                            .scaleEffect(normalSize  ? 1 : yourPickIndex == number ? 1.5 : 0.5)
                            .animation(.spring(duration: 2, bounce : 0.5), value: animateAmount)
                            
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showingScore = true
        }
           
       
    }
    
    func askQuestion() {
        
            countries.shuffle()
      
        correctAnswer = Int.random(in: 0...2)
        reanimate()
    }
    
    func reanimate(){
        withAnimation{
            normalSize = true
        }
    }
    
    func resetAll (){
       askQuestion()
        score = 0
        count = 0
    }
    func silentReset() {
      //  Wait for the animation to finish (e.g., 0.5 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//             Reset to 0 SILENTLY (No Animation)
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                animateAmount = 0
            }
        }
    }
}

#Preview(){
    Day21GuessTheFlag()
}

