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
            VStack(alignment: .leading,spacing : 8 ){
                ForEach(viewModel._searchResultList, id: \.name){ article in
                    SearchListViewItem(article: article)
                    Divider()
                }.padding(.horizontal,16)
                if viewModel.loadMore {
                    HStack{
                        ProgressView()
                            .onAppear{
                                viewModel.infiniteScroll()
                            }
                    }
                }
                else {
                    GeometryReader{ reader -> Color in
                        let minY = Int(reader.frame(in: .global).minY + 45)
                        
                        let height = Int(UIScreen.main.bounds.height)
                        print("miny =  \(minY) ,, height: \(height)")
                        print(viewModel._searchResultList.isEmpty)
                        if !viewModel._searchResultList.isEmpty && minY == height && viewModel.next != nil {
                            DispatchQueue.main.async {
                                viewModel.loadMore = true
                            }
                        }
                        return Color.clear
                    }
                    
                }
            }
            
        }
        .padding(.top, -5)
    }
}
