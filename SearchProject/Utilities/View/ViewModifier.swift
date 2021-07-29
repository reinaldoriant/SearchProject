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
