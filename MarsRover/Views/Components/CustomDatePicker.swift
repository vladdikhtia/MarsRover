//
//  CustomDatePicker.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 01/09/2024.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    @Binding var isDatePickerVisible: Bool
    @State private var tempDate: Date
    let action: () -> Void
    
    init(selectedDate: Binding<Date>, isDatePickerVisible: Binding<Bool>, action: @escaping () -> Void) {
        self._selectedDate = selectedDate
        self._isDatePickerVisible = isDatePickerVisible
        self._tempDate = State(initialValue: selectedDate.wrappedValue)
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isDatePickerVisible = false
                    }
                }
            
            VStack {
                HStack{
                    Button(action: {
                        withAnimation {
                            print("Pressed close")
                            isDatePickerVisible = false
                            tempDate = selectedDate
                        }
                    }, label: {
                        Image("closeDark")
                    })
                    
                    Spacer()
                    
                    Text("Date")
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            print("Pressed Confirm")
                            selectedDate = tempDate
                            isDatePickerVisible = false
                            action()
                        }
                    }, label: {
                        Image("tick")
                    })
                }
                .padding(25)
                
                DatePicker(
                    "",
                    selection: $tempDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
            }
            .frame(height: 312)
            .background(Color.BackgroundOne)
            .clipShape(.rect(cornerRadius: 50))
            .padding(.horizontal, 20)
            .shadow(
                color: Color.LayerOne.opacity(0.08),
                radius: 16,
                x: 0,
                y: 3
            )
        }
    }
}

#Preview {
    CustomDatePicker(selectedDate: .constant(Date()), isDatePickerVisible: .constant(true), action: {})
}
