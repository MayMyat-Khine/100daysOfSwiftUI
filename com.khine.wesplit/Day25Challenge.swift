//
//  Day25Challenge.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/23/26.
//

import SwiftUI

enum rpsenum : CaseIterable{
    case Rock,
         Paper,
         Scissors
    
    var title : String{
        switch self {
        case .Rock: return "🪨 Rock"
        case .Paper: return "📄 Paper"
        case .Scissors: return "✂️ Scissors"
        }
    }
    
    
    
}
extension rpsenum {
    func result (player : rpsenum, shouldWin : Bool) -> Int {
        let winConditions : [rpsenum: rpsenum] =
        [.Paper : .Scissors,
         .Rock : .Paper,
         .Scissors :.Rock]
        
        let playerWins = winConditions[self] == player
        
        if playerWins == shouldWin {
            return 1
        }else {
            return 0
        }
    }
}

struct Day25Challenge : View {
    
//    let rpsList = rpsenum.allCases
    @State private var appPick = rpsenum.allCases[Int.random(in: 0...2)]
    @State private var shouldWin = Bool.random()
    @State private var youWin = ""
    @State private var isShowing = false
    @State private var youPick : rpsenum?
    @State private var score = 0
   
    var body : some View {
        
        VStack{
            Section("App Choose"){
                VStack{
                    Text("\(appPick)")
                    Text("You must win -  \(shouldWin)")
                }
            }
            Section("Your chooose"){
                HStack{
                    ForEach(rpsenum.allCases, id : \.self){ sign in
                        Text(sign.title).padding(10).frame(width: 100, height: 100).background(youPick == sign ? .green:  .brown).cornerRadius(20)
                            .onTapGesture {
                                youPick = sign
                                isShowing = true
                                check()
                            }
                    }.frame(maxWidth: .infinity)
                }
            }
        }.alert(youWin, isPresented: $isShowing){
            Button("Play Again"){
                update()
            }
            Button("Reset"){reset()}
           
        }message : {
            Text("Your Score is \(score)")
        }
    }
    
    func check(){
        if(youPick != nil){
 let result =  appPick.result(player: youPick!, shouldWin: shouldWin)
            if result == 0{
                youWin =  "You lost"
            }
            else {
                youWin = "You Win"
                score = score + 1
            }
        }
    }
    
    func update(){
        youPick = nil
        shouldWin = Bool.random()
        appPick = rpsenum.allCases[Int.random(in: 0...2)]
    }
    
    
    func reset(){
        score = 0
        update()
    }
}



#Preview {
    Day25Challenge()
}
