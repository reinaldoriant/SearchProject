//
//  SearchFieldView.swift
//  Search
//
//  Created by TI Digital on 27/07/21.
//

import SwiftUI

struct SearchFieldViewItem: View {
    
    @StateObject var viewModel : SearchViewModel
    
    var body: some View {
        HStack{
            backButton
            //MARK: - Search Box
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
                TextField("Cari Berita ini...", text: $viewModel.searchQuery, onCommit: {
                    onInputData()
                })
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(Color(.white))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(UIColor(named:"ColorBlueKompas")!), lineWidth: 1)
            )
            .frame(height: 32)
            .padding(.leading, 4)
            .padding(.trailing, 16)
            .padding(.vertical,16)
        }
    }
    var backButton : some View {
        Button(action: {
            if !viewModel.isShowLanding {
                withAnimation{
                    viewModel.isShowLanding = true
                    viewModel.isShowSearchResult = false
                }
            }
        }, label: {
            Image(systemName: "arrow.left")
                .padding(.leading,16)
                .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
        })
    }
    
    func onInputData(){
        viewModel.getSearchResult()
        viewModel.isShowSearchResult.toggle()
    }
}

struct SearchFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldViewItem(viewModel: SearchViewModel(service: SearchService()))
    }
}
