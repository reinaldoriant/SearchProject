//
//  SearcNotFoundView.swift
//  Search
//
//  Created by TI Digital on 28/07/21.
//

import SwiftUI

struct SearchNotFoundView: View {
    //MARK: - Properties
    @StateObject var viewModel = SearchNotFoundViewModel(service: SearchService())
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                SearchNotFoundViewDescItem()
                    .padding(.bottom, 16)
                HStack{
                    Text("Rekomendasi untuk Anda")
                        .titleStyle()
                        .modifier(TitleText())
                    Spacer()
                }
                Group{
                    switch viewModel._rekomendasiState {
                    case .loading:
                        ProgressView().padding(.leading,16)
                    case .success(let content):
                        TerpopulerViewItem(article: content)
                            .padding(.horizontal,16)
                    case .failed(let error):
                        Text("error \(error.localizedDescription)")
                            .padding(.leading,16)
                    }
                }
            }
            .onAppear{
                viewModel.getRekomendasi()
            }
            
        } .ignoresSafeArea(.all, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
    }
}

struct SearcNotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNotFoundView(viewModel: SearchNotFoundViewModel(service: SearchService()))
    }
}
