//
//  TerpopulerViewItem.swift
//  Search
//
//  Created by TI Digital on 26/07/21.
//

import SwiftUI
import URLImage

struct TerpopulerViewItem: View {

    let article: ArticleTerpopuler

    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2){
                LabelView(label: article.isFreemium)
                    .padding(.bottom, 8)
                Text(article.title.htmlToString)
                    .titleNewsSearchStyle()
                Text(getDateWithCategory(date: article.publishedDate, category: (article.terms?.category![0].name)!).htmlToString)
                    .dateSearchStyle()
                Spacer()
            }
            .modifier(BoxSearchText())
            Spacer()
            if let imgurl = article.thumbnails.availableSizes,
               let url = URL(string: imgurl){
                URLImage(url: url,
                         failure:{ error, _ in
                    PlaceholderImageView()
                }, content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipped()
                         })
            }
            else{
                PlaceholderImageView()
            }
        }
        .frame(height: 90)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

