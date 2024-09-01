//
//  HeaderView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedDate: String
    @Binding var isDatePickerPresented: Bool
    @Binding var cameraFilterIsPresented: Bool
    @Binding var roverFilterIsPresented: Bool
    @Binding var currentRover: MarsRover
    @Binding var currentCamera: MarsCamera
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("MARS.CAMERA") // TODO() finish fonts
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(dateConverter(dateString: selectedDate) ?? "")")
                    .font(.system(size: 17, weight: .bold))
                
                Spacer()
                
                HStack(spacing: 12){
                    FilterButton(imageName: "rover", title: "\(currentRover.rawValue)", action: {
                        withAnimation {
                            cameraFilterIsPresented = false
                            roverFilterIsPresented.toggle()
                            print("Pressed Filter Rover")
                        }
                    })
                    
                    FilterButton(imageName: "camera", title: "\(currentCamera.rawValue)", action: {
                        withAnimation {
                            roverFilterIsPresented = false
                            cameraFilterIsPresented.toggle()
                            print("Pressed Filter Rover")
                        }
                    })
                }
            }
            
            Spacer()
            
            VStack(alignment: .center){
                Button(action: {
                    withAnimation {
                        isDatePickerPresented.toggle()
                    }
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
    
    func dateConverter(date: Date) -> String? {
        //        let inputFormatter = DateFormatter()
        //        inputFormatter.dateFormat = "yyyy-MM-dd"
        //
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
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
}

#Preview {
    HeaderView(selectedDate: .constant(""), isDatePickerPresented: .constant(true), cameraFilterIsPresented: .constant(false),
               roverFilterIsPresented: .constant(false),
               currentRover: .constant(.curiosity),
               currentCamera: .constant(.fhaz))
}
