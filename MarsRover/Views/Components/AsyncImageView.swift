//
//  AsyncImageView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject private var imageLoader: AsyncImageLoader
    private let placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        _imageLoader = ObservedObject(wrappedValue: AsyncImageLoader())
        self.placeholder = placeholder
        
        if let imageURL = URL(string: url) {
            _imageLoader.wrappedValue.loadImage(from: imageURL)
        }
    }
    
    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    AsyncImageView(url: "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG")
}
