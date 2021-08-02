//
//  SpinnerBar.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI

struct SpinnerBar: View {
    @State private var isLoading = false
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.white)
                .shadow(radius: 2)
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color(UIColor(named: "ColorBlueKompas")!), lineWidth: 2)
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.default.repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}

