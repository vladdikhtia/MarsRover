//
//  HomeView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: RoverViewModel
    var body: some View {
        
        NavigationView {
            VStack{
                //header
                HeaderView()
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    HomeView()
}


extension Color {
    static let BackgroundOne = Color("BackgroundOne")
    static let AccentOne = Color("AccentOne")
    static let LayerOne = Color("LayerOne")
    static let LayerTwo = Color("LayerTwo")
    static let SystemTwo = Color("SystemTwo")
    static let SystemThree = Color("SystemThree")
}


