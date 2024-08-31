//
//  CustomText.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct CustomText: View {
    let typeTitle: String
    let value: String
    
    var body: some View{
        Text("\(typeTitle): ")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color.LayerTwo)
        
        + Text(value)
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(Color.LayerOne)
    }
}

#Preview {
    CustomText(typeTitle: "Rover", value: "Curiosity")
}
