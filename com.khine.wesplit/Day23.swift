//
//  Day23.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/19/26.
//

import SwiftUI


struct HoverEffect : ViewModifier {
    @State private var isTap = false
    func body (content :Content) -> some View {
        content.onTapGesture {
            isTap = !isTap
        }.scaleEffect(x: isTap ? 4 : 1, y : isTap ? 9 : 1 )
    }
}

extension View {
    func scaleTheText ()-> some View{
        modifier(HoverEffect())
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
//            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}
struct Day23 : View {
    let motto1 = Text("Draco dormiens")
       let motto2 = Text("nunquam titillandus")
    var motto3: some View {
        Text("Draco dormiens")
    }
    var body : some View {
        VStack{ // view as properties
            motto1.foregroundStyle(.green)
            motto2
            motto3
                // for multiple views back ,can use Stack, Group and manual adding @ViewBuilder
        }
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title) // environment variable
        VStack {
            Text("Gryffindor")
                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .blur(radius: 5) // environment variable
        Text("Hello World").modifier(HoverEffect()) // Only with ViewModifier
        Text("Hello Yangon").scaleTheText() //  Extension + ViewModifier
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundStyle(.white)
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
            // view composition
        }
        VStack{
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            Image(systemName: "globe")
                          .imageScale(.large)
                          .foregroundStyle(.tint)
                      Text("Hello, world!")
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.red)
        
        Text("outside of vstack with bg color")
        Button("Hello, world!") {
            print(type(of: self.body))
        }
        .background(.red)
        .frame(width: 20, height: 20)
    }
}

#Preview {
    Day23()
}
