//
//  RekomendasiListViewItem.swift
//  SearchProject
//
//  Created by TI Digital on 30/07/21.
//

import SwiftUI
import URLImage

struct RekomendasiListViewItem: View {
    let articles: Article
    @State var isHidden = false
    
    var body: some View {
        HStack{
            if(articles.isFreemium){
                isFree
            }
            else{
                isNotFree
            }
            Spacer()
            if let imgurl = articles.thumbnails.availableSizes,
               let url = URL(string: imgurl){
                URLImage(url: url,
                         failure:{ error, _ in
                            PlaceholderImageViewItem()
                         }, content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipped()
                         })
            }
            else{
                PlaceholderImageViewItem()
            }
        }
        .frame(height: 90)
    }
    
    var isFree: some View {
        VStack(alignment: .leading, spacing: 0){
            LabelView(label: articles.isFreemium)
                .padding(.bottom, 8)
            Text(articles.title)
                .playfairBold14Black()
            Text(getDateWithCategory(date: articles.publishedDate, category: (articles.terms.category![0].name)))
                .hindRegular12Gray()
        }
        .modifier(BoxSearchText())
    }
    
    var isNotFree: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(articles.title)
                .playfairBold14Black()
            Text(getDateWithCategory(date: articles.publishedDate, category: (articles.terms.category![0].name)))
                .hindRegular12Gray()
            Spacer()
        }
        .modifier(BoxSearchText())
    }
}
