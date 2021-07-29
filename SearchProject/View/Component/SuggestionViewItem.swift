//
//  AutocompleteViewItem.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

struct SuggestionViewItem: View {
    let suggestion : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor(named: "ColorGray300")!))
                    .padding(.trailing,8)
                Text(suggestion)
                    .hindRegular16Black()
            }.frame(width: 279, alignment: .leading)
        }
    }
}


