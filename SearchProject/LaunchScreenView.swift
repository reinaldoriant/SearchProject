//
//  ContentView.swift
//  SearchProject
//
//  Created by TI Digital on 29/07/21.
//

import SwiftUI


struct LaunchScreenView: View {
    @State private var _animate = false
    @State private var _endSplash = false

    var body: some View {
        ZStack{
            HomeScreen()
                .opacity(_endSplash ? 1 : 0)
                .onAppear()
            
            ZStack{
                Color("BackgroundKompas")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Image("Logo Kompas")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform:animateSplash )
            .opacity(_animate ? 0 : 1)
        }
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation(Animation.easeOut(duration: 0.025)){
                _animate.toggle()
            }
            withAnimation(Animation.linear(duration: 2)){
                _endSplash.toggle()
            }
        }
    }
    
}

//MARK: - HomeScreen
struct HomeScreen: View {
    var body: some View {
        VStack {
            SearchView()
        }
    }
}

// MARK: - Preview
struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
