//
//  LocalSuggestionView.swift
//  SearchProject
//
//  Created by TI Digital on 01/08/21.
//

import SwiftUI

struct LocalSuggestionView: View {
    @StateObject var viewModel : SearchViewModel
    var onItemTap: (_ text: String) -> Void = {_ in }
    var body: some View {
        VStack(alignment: .leading, spacing : 8){
            HStack{
                Text("Riwayat Pencarian")
                    .hindSemiBold16Black()
                Spacer()
                Button(action: {
                    viewModel.deleteAllLocalSuggestion()
                }, label: {
                    Text("Hapus semua")
                        .foregroundColor(Color(UIColor(named: "ColorRed700")!))
                        .hindSemiBold16Black()
                })
                .accessibilityIdentifier("buttonHapusSemua")
                
            }
            ForEach(viewModel.showLocalSuggestions, id:\.id){ data in
                    LocalSuggestionViewItem(
                        suggestion: data.name,
                        onItemTap: { string in
                            onItemTap(string)
                        }, onDelete: {
                            viewModel.deleteLocalSuggestion(data.localSuggestion)
                        }
                    )
            }
        } .padding(.horizontal,16)
    }
}

