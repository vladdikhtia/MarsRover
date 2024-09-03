//
//  ScrollImageView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 03/09/2024.
//

import SwiftUI

struct FullScreenImageView: View {
    var image: UIImage
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @Binding var isImageShown: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                isImageShown = false
                print("Close pressed")
            }, label: {
                Image("closeLight")
                
            })
            .padding(.leading, 12)
            .padding(.top, 68)
            
            Spacer()
            
            ScrollView([.vertical, .horizontal]) {
                Image(uiImage: image)
                    .resizable()
                    .background(Color.white)
                    .scaledToFit()
                    .frame(height: 393, alignment: .center)
                    .frame(maxWidth: 393, alignment: .center)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / lastScaleValue
                                lastScaleValue = value
                                scale *= delta
                            }
                            .onEnded { _ in
                                lastScaleValue = 1.0
                            }
                    )
                    .onTapGesture(count: 2, perform: {
                        withAnimation {
                            if scale == 1.0 {
                                scale = 1.5
                            } else {
                                scale = 1.0
                            }
                        }
                    })
                    .clipped()
            }
            
            Spacer()
        }
        .background(Color.LayerOne)
    }
}

#Preview {
    FullScreenImageView(image: UIImage(systemName: "house") ?? UIImage(), isImageShown: .constant(false))
}
