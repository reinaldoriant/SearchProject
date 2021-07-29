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
    
    // MARK: - Body
    var body: some View {
        VStack {
            searchBar
            switch _viewModel.searchViewState{
            case .searchLanding :
                landingSearch
            case .searchSuggestion:
                searchSuggestion
            case .searchResult:
                searchResultView
            }
        }
    }
    
    //MARK: - Search Bar
    var searchBar: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                // Back Button
                Button(action: {
                    withAnimation{
                        if(_viewModel.isLandingState){
                            exit(0)
                        }
                        else{
                            _viewModel.isShowLanding = true
                            _viewModel.searchQuery = ""
                            _viewModel.isShowSearchResult = false
                        }
                        
                    }
                }, label: {
                    Image(systemName: "arrow.left")
                        .padding(.leading,16)
                        .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
                })
                // Search Field
                SearchFieldViewItem(viewModel: _viewModel)
                    .disabled(_viewModel.isShowLanding || _viewModel.isShowSearchResult)
                    .onTapGesture {
                        withAnimation {
                            _viewModel.isShowSearchResult = false
                            _viewModel.isShowLanding = false
                        }
                    }
                // Show Filter
                if _viewModel.isShowFilter{
                    withAnimation{
                        searchFilter
                    }
                }
            }
        }
        
    }
    
    //MARK: - Landing Search
    var landingSearch : some View{
        LandingSearchView()
            .onAppear{
                _viewModel.isLandingState = true
            }
    }
    
    //MARK: - Search Result
    var searchResultView: some View {
        Group {
            switch _viewModel._searchResultState {
            case .loading:
                ProgressView()
                Spacer()
            case .success(let content):
                if(content.isEmpty) {
                    SearchNotFoundView()
                }else {
                    withAnimation(.easeIn){
                        SearchFoundView(viewModel: _viewModel)
                    }
                }
            case .failed(let error):
                Text("Error gini Cong 🥲 \(error.localizedDescription)")
                Spacer()
            }
        }
        .onAppear{
            _viewModel.isLandingState = false
            
        }
        
    }
    //MARK: - Search Filter
    var searchFilter: some View {
        FilterViewItem()
    }
    
    //MARK: - Suggestion
    var searchSuggestion: some View {
        
        SuggestionView(viewModel: _viewModel)
            .onAppear{
                _viewModel.isLandingState = false
                
            }
    }
    
}

