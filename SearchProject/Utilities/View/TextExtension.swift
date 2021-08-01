//
//  FontExtension.swift
//  Search
//
//  Created by TI Digital on 25/07/21.
//

import SwiftUI

extension Text{
    //MARK: - hind
    func hindSemiBold16Black() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("Hind-SemiBold", size: 16))
    }
    func hindSemiBold18Black() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("Hind-SemiBold", size: 18))
    }
    func hindRegular12Gray() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorGray666")!))
            .font(Font.custom("Hind-Regular", size: 12))
    }
    func hindRegular16Black() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("Hind-Regular", size: 16))
    }
    func hindRegular16Blue() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
            .font(Font.custom("Hind-Regular", size: 16))
    }
    func hindSemiBold16Blue() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
            .font(Font.custom("Hind-SemiBold", size: 16))
    }
    //MARK: - playfair
    func playfairBold14Black() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlack333")!))
            .font(Font.custom("PlayfairDisplay-Bold", size: 14))
    }
    //MARK: - Others
    func labelStyle() -> Text{
        self
            .foregroundColor(Color(UIColor(named: "ColorBlueKompas")!))
            .font(Font.custom("Hind-Bold", size: 12))
    }
    
}


