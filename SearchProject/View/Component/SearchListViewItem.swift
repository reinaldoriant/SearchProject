//
//  SearchArticleViewItem.swift
//  Search
//
//  Created by TI Digital on 28/07/21.
//

import SwiftUI
import URLImage

struct SearchListViewItem: View {
    
    let article: SearchArticle
    
    @State var isHidden = false
    @State private var newTitle : String = ""
    
    var body: some View {
        HStack{
            if(article.isFreemium){
                isFree
            }
            else{
                isNotFree
            }
            Spacer()
            if let imgurl = article.thumbnails.availableSizes,
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
        .onAppear{
            DispatchQueue.main.async {
                newTitle = article.title.html2String
            }
        }
    }
    
    var isFree: some View {
        VStack(alignment: .leading, spacing: 0){
            LabelView(label: article.isFreemium)
                .padding(.bottom, 8)
            Text(newTitle)
                .playfairBold14Black()
            Text(getDateWithCategory(date: article.publishedDate, category: (article.terms?.category![0].name)!))
                .hindRegular12Gray()
            
        }
        .modifier(BoxSearchText())
    }
    
    var isNotFree: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(newTitle)
                .playfairBold14Black()
            Text(getDateWithCategory(date: article.publishedDate, category: (article.terms?.category![0].name)!))
                .hindRegular12Gray()
            Spacer()
        }
        .modifier(BoxSearchText())
    }
}





