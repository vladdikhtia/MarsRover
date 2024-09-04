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
                CustomText(typeTitle: "Date", value: DateFormatter.formattedDate(from: filter.date ?? "June 6, 2019") ?? "")
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
}

//#Preview {
//    HistoryCard(/*filter: FilterEntity()*/)
//}
