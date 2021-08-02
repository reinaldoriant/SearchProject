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
                if viewModel.loadMoreDown {
                    HStack{
                        Spacer()
                        SpinnerBar()
                            .onAppear{
                                viewModel.infiniteScroll()
                            }
                            
                        Spacer()
                    }
                }
                else {
                    GeometryReader{ reader -> Color in
                        let minY = Int(reader.frame(in: .global).minY + 45)
                        let heightInfinity = Int(UIScreen.main.bounds.height)
                        print("miny =  \(minY) ,, height: \(heightInfinity)")
                        print(viewModel._searchResultList.isEmpty)
                        if !viewModel._searchResultList.isEmpty && minY == heightInfinity && viewModel.next != nil {
                            DispatchQueue.main.async {
                                viewModel.loadMoreDown = true
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
