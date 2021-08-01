//
//  LocalSuggestionViewItem.swift
//  SearchProject
//
//  Created by TI Digital on 01/08/21.
//

import SwiftUI

struct LocalSuggestionViewItem: View {
    var suggestion : String
    var onItemTap : (_ name: String) -> Void = {_ in}
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundColor(Color(UIColor(named: "ColorGray300")!))
                .padding(.trailing, 9.5)
            Text(suggestion)
                .hindRegular16Black()
            Spacer()
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 10, height: 10,alignment: .trailing)
                .foregroundColor(.gray)
                .onTapGesture
                {
                    onDelete()
                }
        }
        .onTapGesture {
            onItemTap(suggestion)
        }
    }
    
}

