//
//  FilterButton.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct FilterButton: View {
    let imageName: String
    let title: String
    let action: () -> Void
    
    var body: some View{
        Button(action: {
            action()
        }, label: {
            HStack{
                Image(imageName)
                Text(title)
            }
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(Color.layerOne)
            .padding(7)
            .frame(
                width: title.isEmpty ? 38 : 140,
                height: 38,
                alignment: .leading
            )
            .background(Color.BackgroundOne)
            .clipShape(.rect(cornerRadius: 10))
        })
    }
}

#Preview {
    FilterButton(imageName: "camera", title: "All", action: {})
}
