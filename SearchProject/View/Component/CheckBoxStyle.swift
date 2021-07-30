//
//  CheckBoxStyle.swift
//  SearchProject
//
//  Created by TI Digital on 30/07/21.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
                .padding(.trailing, 10)
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 21, height: 21)
                .foregroundColor(configuration.isOn ? Color(UIColor(named: "ColorBlueKompas")!) : .gray)
                .font(.system(size: 1, weight: .regular, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        
    }
}
