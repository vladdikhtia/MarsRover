//
//  DetailCard.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 01/09/2024.
//

import SwiftUI

struct DetailCard: View {
    let photo: Photo
    let onClick: (UIImage?) -> Void
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 15){
                CustomText(typeTitle: "Rover", value: photo.rover.name)
                CustomText(typeTitle: "Camera", value: photo.camera.fullName)
                CustomText(typeTitle: "Date", value: DateFormatter.formattedDate(from:photo.earthDate) ?? "")
            }
            .padding(.leading, 16)
            
            Spacer()
            
            AsyncImageView(url: photo.secureImgSrc)
                .frame(width: 130, height: 130)
                .clipShape(.rect(cornerRadius: 20))
                .padding(10)
                .onTapGesture {
                    Task {
                        let image = await loadImageAsyncAwait(urlString: photo.secureImgSrc)
                        onClick(image)
                    }
                }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color.BackgroundOne)
        .clipShape(.rect(cornerRadius: 30))
        .shadow(
            color: Color.LayerOne.opacity(0.08),
            radius: 16,
            x: 0,
            y: 3
        )
        .padding(.horizontal, 20)
    }
    
    private func loadImageAsyncAwait(urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch  {
            print("Failed to load image: \(error.localizedDescription)")
            return nil
        }
    }

}

#Preview {
    DetailCard(photo: example.photos[0], onClick: {_ in })
}
