//
//  TerpopulerView.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import SwiftUI
import URLImage


struct TerpopulerViewItem: View {
    let article:[SearchArticle]
    
    var body: some View {
        ForEach(0..<10){ i in
            SearchListViewItem(article: article[i])
                .padding(.vertical,8)
                .if(i == 9){View in
                    View.padding(.bottom, 16)
                }
            if(0...8 ~= i){
                Divider()
            }
        }
    }
}



