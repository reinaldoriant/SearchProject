//
//  SearchResultView.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

struct SearchFoundView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading,spacing : 0 ){
                ForEach(viewModel._searchResultList, id: \.name){ article in
                    SearchListViewItem(article: article)
                        .padding(.vertical, 8)
                    Divider()
                }
                .padding(.horizontal,16)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoundView(viewModel: SearchViewModel(service: SearchService()))
    }
}
