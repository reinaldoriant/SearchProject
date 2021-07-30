//
//  ViewModifier.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
    }
}

struct BoxSearchText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 222, alignment: .leading)
        
    }
}

struct BoxButton : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(UIColor(named: "ColorBlueKompas")!))
                .cornerRadius(4)
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeIn(duration: 0.2), value: configuration.isPressed)
    }
}
