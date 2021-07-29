//
//  AutocompleteViewItem.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

struct AutocompleteViewItem: View {
    let suggestion : String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor(named: "ColorGray300")!))
                .padding(.trailing,8)
                .padding(.vertical,16)
            Text("Hello, World!")
        }
    }
}

struct AutocompleteViewItem_Previews: PreviewProvider {
    static var previews: some View {
        AutocompleteViewItem(suggestion: "Trump")
            .previewLayout(.sizeThatFits)
    }
}
