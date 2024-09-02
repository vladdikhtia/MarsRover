//
//  FloatingButton.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import SwiftUI

struct FloatingButton: View {
        var body: some View {
        Image("history")
            .resizable()
            .padding()
            .frame(width: 70, height: 70)
            .background(Color.AccentOne)
            .clipShape(Circle())
            .shadow(
                color: Color.LayerOne.opacity(0.2),
                radius: 10,
                x: 0,
                y: 2
            )
    }
}

#Preview {
    FloatingButton()
}
