//
//  DetailCard.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 01/09/2024.
//

import SwiftUI

struct DetailCard: View {
    let photo: Photo
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 15){
                CustomText(typeTitle: "Rover", value: photo.rover.name)
                CustomText(typeTitle: "Camera", value: photo.camera.fullName)
                CustomText(typeTitle: "Date", value: dateConverter(dateString:photo.earthDate) ?? "")
            }
            .padding(.leading, 16)
            
            Spacer()
            
            Rectangle() // TODO() make it works with ios 13
                .fill(Color.red)
                .frame(width: 130, height: 130)
                .clipShape(.rect(cornerRadius: 20))
                .padding(10)
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
    
    func dateConverter(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
    }
    
    func dateConverter(date: Date) -> String? {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
    }
}

#Preview {
    DetailCard(photo: example.photos[0])
}
