//
//  TerpopulerView.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import SwiftUI
import URLImage


struct TerpopulerView: View {
    @State private var lastList: Bool = false
    let article:[ArticleTerpopuler]
    
    var body: some View {
        ForEach(0..<10){ i in
            TerpopulerViewItem(article: article[i])
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



