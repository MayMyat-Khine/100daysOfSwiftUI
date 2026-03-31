//
//  Day29WordScramble.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/31/26.
//

import SwiftUI

struct Day29WordScramble: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    var body: some View {
        VStack {
            List(0..<5){
                Text("This is \($0)")
            }
            List(people, id : \.self){
                Text("The name is \($0)")
            }
            List {
                Section("Section 1") {
                    Text("Static row 1")
                    Text("Static row 2")
                }
                
                Section("Section 2") {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }
                
                Section("Section 3") {
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }.listStyle(.grouped)
        }
        
    }
}


#Preview {
    Day29WordScramble()
}
