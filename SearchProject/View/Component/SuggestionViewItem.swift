//
//  AutocompleteViewItem.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

struct SuggestionViewItem: View {
    let suggestion : String
    var onTapItem : (_ name: String) -> Void = {_ in}
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor(named: "ColorGray300")!))
                .padding(.trailing,8)
            Text(suggestion)
                .hindRegular16Black()
            Spacer()
        }
        .onTapGesture {
            onTapItem(suggestion)
        }
        
    }
}


