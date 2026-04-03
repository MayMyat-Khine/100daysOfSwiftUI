//
//  Day32Animation.swift
//  com.khine.wesplit
//
//  Created by MayMK on 4/3/26.
//

import SwiftUI


struct Day32Animation : View {
    @State private var animateAmount : Double = 1.0
    @State private var animationAmount : Double = 1.0
    var body: some View {
        print(animationAmount)
       return VStack {
            Button("Tap Me") {
                //            animateAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animateAmount)
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animateAmount)
                    .opacity(2 - animateAmount)
                    .animation(
                        .easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: animateAmount
                    )
                
            )
            //        .blur(radius: (animateAmount - 1) * 3)
            //        .animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animateAmount)
            .onAppear{
//                animateAmount = 2
            }
            ////////////////////////////////
            
            VStack {
                       Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

                       Spacer()

                       Button("Tap Me") {
                           animationAmount += 1
                       }
                       .padding(40)
                       .background(.red)
                       .foregroundStyle(.white)
                       .clipShape(.circle)
                       .scaleEffect(animationAmount)
                   }
        }
    }
}

#Preview {
    AnimationExplicit()
}

struct AnimationExplicit: View {
    @State private var animateAmount : Double = 0.0
    var body: some View {
        Button("Tap Me") {
           
            withAnimation(.spring(duration: 10 ,bounce: 0.5)){
                animateAmount += 180
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animateAmount), axis: (x: -1, y: -1, z: 0))
    }
}
