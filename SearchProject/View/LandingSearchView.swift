//
//  LandingSearchView.swift
//  Search
//
//  Created by TI Digital on 22/07/21.
//

import SwiftUI

struct LandingSearchView: View {
    //MARK: - Properties
    @StateObject var viewModel = LandingSearchViewModel(service: SearchService())
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack(alignment: .leading, spacing:0 ){
                    //MARK: - Title Topik Hangat
                    HStack{
                        Text("Topik Hangat")
                        .titleStyle()
                        .modifier(TitleText())
                        Spacer()}
                    //MARK: - Button Topik Hangat
                    Group{
                        switch viewModel._hotTopicsState {
                        case .success(let hotTopics):
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    ForEach(hotTopics, id: \.name){ item in
                                        HotTopicsView(hotTopics: item.name)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        case .failed(error: let error):
                            Text("Kenapa ini 🥲 \(error.localizedDescription)")
                        case .loading:
                            ProgressView()
                                .padding(.leading,16)
                        }
                    }
                    .padding(.top,8)
                    .padding(.bottom, 32)
                    
                    //MARK: - Terpopuler
                    HStack{ Text("Terpopuler")
                        .titleStyle()
                        .modifier(TitleText())
                        Spacer()}
                    Group{
                        switch viewModel._popularState {
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
            }
        }
        .onAppear{
            viewModel.getHotTopics()
            viewModel.getTerpopuler()
        }
        .ignoresSafeArea(.all, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
    }
}

struct LandingSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LandingSearchView()
    }
}
