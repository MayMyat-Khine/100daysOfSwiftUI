//
//  Day33.swift
//  com.khine.wesplit
//
//  Created by MayMK on 4/8/26.
//

import SwiftUI

struct Day33 : View {
    @State private var enable : Bool = false
    @State private var dragAmount = CGSize.zero
    var body: some View {
        VStack {
            VStack {
                // This text will NOT animate because of the nil below it
                Text(enable ? "Enabled" : "Unenabled")
                    .animation(nil, value: enable)
                
                // This heart WILL animate
                Image(systemName: enable ? "heart.fill" : "heart")
                  
            }  .animation(.spring(), value: enable)
            Button("Tap"){
                enable.toggle()
            }.frame(width: 200,height: 200)
                .background(enable ? .green : .red)
            
                .animation(nil, value : enable)
             
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: enable ? 60 : 0))
                .animation(.spring(duration: 1, bounce: 0.6), value: enable)
            
            LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing).frame(width: 200,height: 200).clipShape( .rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(DragGesture()
                    .onChanged{dragAmount = $0.translation}
                    .onEnded{ _ in withAnimation(.bouncy){
                        dragAmount = .zero
                    }}
                    )
//                .animation(.bouncy, value: dragAmount)
               
        }
            
    }
}

#Preview {
    CustomAnimationWithViewModifier()
}

struct AnimationText: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    
                    .animation(
                        .linear.delay(Double(num) / 20)
                               ,value: dragAmount)
                   
                   
                    .offset(dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ShowHideViewWithTransition : View {
    @State private var isShowRed : Bool = false
    var body: some View {
        VStack {
                    Button("Tap Me") {
                        withAnimation(.easeInOut){
                            isShowRed.toggle()
                        }
                    }

            if isShowRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    
            }
            
                }
    }
}

struct CornerRotateModeifier : ViewModifier {
    let amount : Double
    let anchor  : UnitPoint
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount),anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot : AnyTransition{
        .modifier(active:CornerRotateModeifier(amount: -90, anchor: .topLeading) , identity: CornerRotateModeifier(amount: 0, anchor: .bottomTrailing))
    }
}

struct CustomAnimationWithViewModifier : View {
    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            if !isShowingRed{
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                    .transition(.scale)
                    
            }
                  

                   if isShowingRed {
                       Rectangle()
                           .fill(.red)
                           .frame(width: 100, height: 100)
                           .transition(.pivot)
                   }
               }
               .onTapGesture {
                   withAnimation(.bouncy(duration: 5)) {
                       isShowingRed.toggle()
                   }
               }
    }
}
