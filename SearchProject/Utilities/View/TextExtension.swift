//
//  FontExtension.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import SwiftUI

extension Text{
    //MARK: - Search
    func titleStyle() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("Hind-SemiBold", size: 16))
    }
    func dateSearchStyle() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorGray666")!))
            .font(Font.custom("Hind-regular", size: 12))
    }
    func titleNewsSearchStyle() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("PlayFairDisplay-Bold", size: 14))
    }
    func labelStyle() -> Text{
        self
            .font(Font.custom("Hind-Bold", size: 12))
    }
}

