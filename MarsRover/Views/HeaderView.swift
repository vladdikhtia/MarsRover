//
//  HeaderView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("MARS.CAMERA") // finish fonts
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("June 6, 2019")
                    .font(.system(size: 17, weight: .bold))
                
                Spacer()
                
                HStack(spacing: 12){
                    FilterButton(imageName: "rover", title: "All", action: {print("Pressed Filter Rover")})
                    
                    FilterButton(imageName: "camera", title: "All", action: {print("Pressed Filter Camera")})
                }
            }
            
            Spacer()
            
            VStack(alignment: .center){
                Button(action: {
                    print("Calendar pressed")
                }, label: {
                    Image("calendar")
                        .resizable()
                        .frame(width: 30, height: 34)
                })
                .padding(.top, 12)
                .frame(width: 44, height: 44, alignment: .center)
                
                Spacer()
                
                FilterButton(imageName: "addMy", title: "", action: {print("Pressed Save Button")})
            }
        }
        .foregroundColor(Color.LayerOne)
        .padding(.top, 54) // remove if Iphone with TouchID
        .padding(.vertical)
        .padding(.horizontal, 20)
        .background(Color.accentOne)
        .frame(height: 202)
    }
}

#Preview {
    HeaderView()
}
