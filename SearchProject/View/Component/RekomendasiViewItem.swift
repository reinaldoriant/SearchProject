//
//  RekomendasiViewItem.swift
//  SearchProject
//
//  Created by TI Digital on 30/07/21.
//

import SwiftUI

struct RekomendasiViewItem: View {
    let articles:[Article]
    
    var body: some View {
        ForEach(0..<10){ i in
            RekomendasiListViewItem(articles: articles[i])
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
