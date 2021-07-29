//
//  PlaceholderImageView.swift
//  Search
//
//  Created by TI Digital on 26/07/21.
//

import SwiftUI

struct PlaceholderImageView: View {
    var body: some View {
        Image("imgSearchPlaceholder")
            .resizable()
            .clipped()
            .aspectRatio(contentMode: .fill)
            .frame(width: 90,height: 90)
    }
}

struct PlaceholderImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImageView()
            .previewLayout(.sizeThatFits)
    }
}
