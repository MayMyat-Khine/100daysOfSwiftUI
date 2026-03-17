//
//  guessflag.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/16/26.
//

import SwiftUI

struct Day20 : View{
    @State private var showingAlert = false
    var body : some View{
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//
//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//        }
//        .ignoresSafeArea()
        VStack(alignment: .leading){
            VStack {
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered)
                Button("Button 3",role:.destructive) { }
                    .buttonStyle(.borderedProminent)
                Button("Button 4") { }
                    .buttonStyle(.bordered).tint(.orange)
                Button("Button 3") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                Button {
                    print("Button was tapped")
                } label: {
                    Text("Tap me!")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red)
                }
                Button {
                    print("Edit button was tapped")
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red)
                }
                Button("Pencil",systemImage: "pencil"){
                    print("Pencil is clicked")
                }
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "pencil")
                }
                
                Button("Show an alert"){
                    showingAlert = true
                    print("Show and Alert is clicked")
                }.alert("This is warning", isPresented : $showingAlert ){
                    Button("Cancel",role:.cancel){}
                    Button("Delete",role:.destructive){}
                } message:{
                    Text("Please decide carfully")
                }
            }
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            Text("Your content")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.white)
                .background(.red.gradient)
            LinearGradient(stops: [
                .init(color: .white, location: 0.25),
                .init(color: .black, location: 0.85),
            ], startPoint: .top, endPoint: .bottom)
            RadialGradient(colors: [.blue, .green], center: .top, startRadius: 100,endRadius: 150)
//            Text("MMK")
//            Text("MMKkkkkkkk")
//            ZStack{
//                Color.yellow
//                Text("Make Malaxianguo")
//                    .background(.red)
//            }.ignoresSafeArea()
//            .background(.green)
        }
//        .frame(maxWidth: .infinity, alignment: .leading).background(.red)
    }
}

#Preview {
    Day20()
}
