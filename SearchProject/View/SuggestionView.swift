//
//  SuggestionView.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI

struct SuggestionView: View {
    @StateObject var viewModel : SearchViewModel
    var onItemTap: (_ text: String) -> Void = {_ in }
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            ForEach(viewModel.showLocalSuggestions, id:\.id){ data in
                LocalSuggestionViewItem(
                    suggestion: data.name,
                    onDelete: {
                        viewModel.deleteLocalSuggestion(data.localSuggestion)
                    }
                )
            }
            Group {
                switch viewModel._remoteSuggestionState{
                case .success(let content) :
                    ForEach(content.prefix(5), id:\.suggestion){ data in
                        SuggestionViewItem(
                            suggestion: data.suggestion,
                            onTapItem: {data in viewModel.onTapSuggestion(text: data)}
                        )
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


