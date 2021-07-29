//
//  ViewExtension.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

extension View{
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    
}
