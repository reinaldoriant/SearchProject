//
//  LandingSearch.swift
//  Search
//
//  Created by TI Digital on 22/07/21.
//

import SwiftUI

struct SearchView: View {
    //MARK: - Properties
    @StateObject private var searchData = SearchViewModel()
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "arrow.left")
                    .padding(.leading,16)
                    .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
                    
                //MARK: - Search Box
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
                    TextField("Cari Berita ini...", text: $searchData.searchQuery)
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
            //MARK: - Landing Search
            LandingSearchView()
        }
    }
}

struct LandingSearch_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
