//
//  Day24.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/21/26.
//

import SwiftUI

struct LargeFontWithColor : ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle.bold()).foregroundStyle(.blue)
    }
}

extension View {
    func prominentTitle () -> some View {
        modifier(LargeFontWithColor())
    }
}

struct Day24 : View {
    var body : some View {
        Text("Hello World").prominentTitle()
    }
}


#Preview {
    Day24()
}
