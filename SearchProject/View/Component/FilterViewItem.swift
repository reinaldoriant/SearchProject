//
//  FilterViewItem.swift
//  SearchProject
//
//  Created by TI Digital on 30/07/21.
//

import SwiftUI

struct FilterViewItem: View {
    var body: some View {
        HStack{
            Image("imgFilterBut")
                .frame(width: 15, height: 16)
                .padding(.trailing, 6)
            Text("Filter")
                .hindRegular16Blue()
        }
        .padding(.trailing,16)
    }
}

struct FilterViewItem_Previews: PreviewProvider {
    static var previews: some View {
        FilterViewItem()
            .previewLayout(.sizeThatFits)
    }
}
