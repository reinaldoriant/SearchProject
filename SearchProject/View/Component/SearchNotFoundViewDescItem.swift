//
//  SearchNotFoundViewItem.swift
//  Search
//
//  Created by TI Digital on 28/07/21.
//

import SwiftUI

struct SearchNotFoundViewDescItem: View {
    var body: some View {
        VStack{
            Image("imgSearchNotFound")
                .resizable()
                .scaledToFit()
                .frame(width: 154, height: 154, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(spacing: 4){
                Text("Pencarian Anda Tidak Ditemukan")
                .font(Font.custom("Hind-Regular", size: 16))
                Text("Coba gunakan lata kunci lain atau baca artikel rekomendasi dibawah ini.")
                .font(Font.custom("Hind-Regular", size: 14))
            }
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .multilineTextAlignment(.center)
            .frame(width: 308, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(.vertical,24)
        .background(Color(UIColor(named: "ColorBlueKompas")!.withAlphaComponent(0.05)))
        
    }
}

struct SearchNotFoundViewItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchNotFoundViewDescItem().previewLayout(.sizeThatFits)
    }
}
