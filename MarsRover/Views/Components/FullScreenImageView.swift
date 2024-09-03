//
//  ScrollImageView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 03/09/2024.
//

import SwiftUI

struct FullScreenImageView: View {
    var image: UIImage

    @Environment (\.presentationMode) var presentationMode
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    
    var body: some View {
        Image(uiImage: UIImage())
            .resizable()
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
    }
}

#Preview {
    FullScreenImageView()
}
