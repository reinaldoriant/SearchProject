//
//  LabelView.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//


import SwiftUI

struct LabelView: View {
    let label:Bool
    
    var body: some View {
        if(label){
            Text("Bebas Akses")
                .labelStyle()
                .padding(.horizontal,8)
                .background(Color(UIColor(named: "ColorBlueLabel")!))
                .cornerRadius(4)
               
        }
    }
}

