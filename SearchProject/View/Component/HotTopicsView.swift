//
//  HotTopicsView.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import SwiftUI

struct HotTopicsViewItem: View {
    let hotTopics: String
    var body: some View {
        Text(hotTopics)
            .padding(.vertical,4)
            .padding(.horizontal,16)
            .background(Color(UIColor(named:"ColorYellow500")!))
            .cornerRadius(4)
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("Hind-SemiBold", size: 14))
        
    }
}

struct HotTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        HotTopicsViewItem(hotTopics: HotList.dummyData.name)
            .previewLayout(.sizeThatFits)
    }
}
