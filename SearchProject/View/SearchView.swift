//
//  LandingSearch.swift
//  Search
//
//  Created by TI Digital on 22/07/21.
//

import SwiftUI

struct SearchView: View {
    //MARK: - Properties
    @StateObject private var _viewModel = SearchViewModel(service: SearchService())
    private var _searchTyping = ""
    
    init(){
        _searchTyping = _viewModel.searchTyping
    }
    // MARK: - Body
    var body: some View {
        VStack {
            SearchFieldViewItem(viewModel: _viewModel)
                .disabled(_viewModel.isShowLanding || _viewModel.isShowSearchResult)
                .onTapGesture {
                    withAnimation {
                        _viewModel.isShowSearchResult = false
                        _viewModel.isShowLanding = false
                    }
                }
            switch _viewModel.searchViewState{
            case .searchLanding :
                LandingSearchView()
            case .searchSuggestion:
                LandingSearchView()
            case .searchResult:
                searchResultView
            }
        }
    }
    
    //MARK: - Search Result
    var searchResultView: some View {
        Group {
            switch _viewModel._searchResultState {
            case .loading:
                ProgressView()
            case .success(let content):
                if(content.isEmpty) {
                    SearchNotFoundView()
                }else {
                    SearchFoundView(viewModel: _viewModel)
                }
            case .failed(let error):
                Text("Error gini COng 🥲 \(error.localizedDescription)")
            }
        }
    }
    
}

struct LandingSearch_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
