//
//  SuggestionView.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI

struct SuggestionView: View {
    @StateObject var viewModel : SearchViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Group {
                switch viewModel._remoteSuggestionState{
                case .success(let content) :
                    ForEach(content.prefix(5), id:\.suggestion){ data in
                        SuggestionViewItem(suggestion: data.suggestion)
                    }
                case .failed :
                    Text("Hello")
                case .loading:
                    EmptyView()
                }
            }
            Spacer()
        }
    }
}


