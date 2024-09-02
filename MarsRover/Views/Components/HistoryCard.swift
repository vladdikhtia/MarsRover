//
//  FilterCard.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import SwiftUI

struct HistoryCard: View {
    let filter: FilterEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Rectangle()
                    .frame(height: 2)

                Text("Filters")
                    .font(.system(size: 22, weight: .bold))
            }
            .foregroundColor(Color.AccentOne)
            
            VStack(alignment: .leading, spacing: 6){
                CustomText(typeTitle: "Rover", value: filter.rover ?? "Curiosity")
                CustomText(typeTitle: "Camera", value: filter.camera ?? "Front Hazard Avoidance Camera")
                CustomText(typeTitle: "Date", value: dateConverter(dateString: filter.date ?? "June 6, 2019"))
            }
        }
        .padding(16)
        .background(Color.BackgroundOne)
        .clipShape(.rect(cornerRadius: 30))
        .frame(height: 136)
        .shadow(
            color: Color.LayerOne.opacity(0.08),
            radius: 16,
            x: 0,
            y: 3
        )
    }
    func dateConverter(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return ""
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
    }
}

//#Preview {
//    HistoryCard(/*filter: FilterEntity()*/)
//}
