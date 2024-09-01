//
//  FilterSheet.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 01/09/2024.
//

import SwiftUI

struct FilterSheet: View {
    let filterTitle: String
    
    @Binding var filterIsPresented: Bool
    @ObservedObject var viewModel: RoverViewModel
//    let closeAction: () -> Void
    let saveAction: () -> Void
    
    @State private var tempCameraSelection: MarsCamera = .all
    @State private var tempRoverSelection: MarsRover = .curiosity

    var body: some View {
        VStack(spacing: 10) {
            HStack{
                Button(action: {
                    withAnimation {
                        print("Pressed close")
                        filterIsPresented = false
//                        closeAction()
                    }
                }, label: {
                    Image("closeDark")
                })
                
                Spacer()
                
                Text(filterTitle)
                    .font(.system(size: 22, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        print("Pressed Confirm")
                        filterIsPresented = false
                        print("Curent camera is: \(viewModel.currentCamera.description)")
                        
                        updateSelection()
                        saveAction()
                    }
                }, label: {
                    Image("tick")
                })
            }
            .padding([.horizontal, .top], 25)
            
            if filterTitle == "Camera" {
                Picker(
                    "",
                    selection: $tempCameraSelection
//                    selection: Binding(get: {
//                        viewModel.currentCamera
//                    }, set: { newCamera in
//                        viewModel.currentCamera = newCamera
//                    })
                ) {
                    ForEach(MarsCamera.allCases, id: \.self) { camera in
                        Text(camera.description)
                            .tag(camera)
                            .font(.system(size: 22, weight: .bold))
                    }
                }
                .pickerStyle(.wheel)
                .padding()
                
            } else if filterTitle == "Rover" {
                Picker(
                    "",
                    selection: $tempRoverSelection
//                    selection: Binding(get: {
//                        viewModel.currentRover
//                    }, set: { newRover in
//                        viewModel.currentRover = newRover
//                    })
                ) {
                    ForEach(MarsRover.allCases, id: \.self) { rover in
                        Text(rover.path)
                            .tag(rover)
                            .font(.system(size: 22, weight: .bold))
                    }
                }
                .pickerStyle(.wheel)
                .padding()
            }
        }
        .background(Color.BackgroundOne)
        .frame(height: 306)
        .clipShape(.rect(cornerRadius: 50))
        .shadow(
            color: Color.LayerOne.opacity(0.1),
            radius: 12,
            x: 0,
            y: -12
        )
        .transition(.move(edge: .bottom))
        .animation(.default)
    }
    
    private func updateSelection() {
            if filterTitle == "Camera" {
                viewModel.currentCamera = tempCameraSelection
            } else if filterTitle == "Rover" {
                viewModel.currentRover = tempRoverSelection
            }
        }
}

#Preview {
    FilterSheet(filterTitle: "Camera", filterIsPresented: .constant(true), viewModel: RoverViewModel(),/*, closeAction: {},*/ saveAction: {})
}
