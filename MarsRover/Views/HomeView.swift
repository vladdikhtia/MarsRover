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
                if !viewModel.photos.isEmpty {
                    ScrollView{ // TODO()add top padding 20
                        VStack(spacing: 12){
                            ForEach(viewModel.photos) { photo in
                                DetailCard(photo: photo)
                            }
                        }
                    }
                } else {
                    if #available(iOS 14.0, *) {
                        ProgressView("Data is loading...")
                            .padding(.top, 200)
                    } else {
                        Text("Data is loading...")
                            .font(.system(size: 17, weight: .bold))
                            .padding(.top, 200)
                    }
                }
                Spacer()
            }
            .background(Color.BackgroundOne)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    HomeView(viewModel: RoverViewModel())
}


extension Color {
    static let BackgroundOne = Color("BackgroundOne")
    static let AccentOne = Color("AccentOne")
    static let LayerOne = Color("LayerOne")
    static let LayerTwo = Color("LayerTwo")
    static let SystemTwo = Color("SystemTwo")
    static let SystemThree = Color("SystemThree")
}



//if #available(iOS 15.0, *) {
//                                        AsyncImage(
//                                            url: URL(string: photo.imgSrc)) { image in
//                                                image
//                                                    .resizable()
//                                                    .scaledToFit()
//                                                    .frame(width: 130, height: 130)
//                                                    .clipShape(.rect(cornerRadius: 20))
//                                                    .padding(10)
//                                            } placeholder: {
//                                                Rectangle()
//                                                    .fill(Color.gray.opacity(0.2))
//                                                    .frame(width: 130, height: 130)
//                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                                                    .padding(10)
//                                            }
//                                    } else {
//                                        Rectangle() // TODO() make it works with ios 13
//                                            .fill(Color.red)
//                                            .frame(width: 130, height: 130)
//                                            .clipShape(.rect(cornerRadius: 20))
//                                            .padding(10)
//                                    }
