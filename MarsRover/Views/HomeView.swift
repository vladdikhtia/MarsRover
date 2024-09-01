//
//  HomeView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: RoverViewModel
    
    @State var isDatePickerPresented: Bool = false
    @State var cameraFilterIsPresented: Bool = false
    @State var roverFilterIsPresented: Bool = false
    var body: some View {
        ZStack{
            NavigationView {
                VStack{
                    //header
                    HeaderView(
                        selectedDate:  Binding(
                            get: { viewModel.formattedDateForDisplaying },
                            set: { newDate in
                                if let date = DateFormatter.date(from: newDate) {
                                    viewModel.selectedDate = date
                                    viewModel.currentDate = newDate
                                }
                            }),
                        isDatePickerPresented: $isDatePickerPresented,
                        cameraFilterIsPresented: $cameraFilterIsPresented,
                        roverFilterIsPresented: $roverFilterIsPresented,
                        currentRover: Binding(get: {
                            viewModel.currentRover
                        }, set: { newRover in
                            viewModel.currentRover = newRover
                        }),
                        currentCamera: Binding(get: {
                            viewModel.currentCamera
                        }, set: { newCamera in
                            viewModel.currentCamera = newCamera
                        })
                    )
                    
                    if !viewModel.photos.isEmpty {
                        ScrollView{ // TODO()add top padding 20
                            VStack(spacing: 12){
                                ForEach(viewModel.photos) { photo in
                                    DetailCard(photo: photo)
                                }
                            }
                            .padding(.top, 12)
                        }
                    } else {
                        if #available(iOS 14.0, *) {
                            ProgressView("Data is loading...")
                                .padding(.top, 200)
                        } else {
                            Text("Data is loading...")
                                .font(.system(size: 17, weight: .bold))
                                .padding(.top, 200)
                        }
                    }
                    
//                    Button(action: {
//                        print("Show current date\(viewModel.currentDate)")
//                        viewModel.fetchData()
//                    }, label: {
//                        Text("date")
//                            .padding()
//                            .background(Color.green)
//                    })
                    
                    Spacer()
                    
                    if roverFilterIsPresented {
                        FilterSheet(filterTitle: "Rover", filterIsPresented: $roverFilterIsPresented, viewModel: viewModel,
                            saveAction: {
                            viewModel.fetchData()
                            }
                        )
                    }
                    
                    if cameraFilterIsPresented {
                        FilterSheet(filterTitle: "Camera", filterIsPresented: $cameraFilterIsPresented, viewModel: viewModel,
                            saveAction: {
                            viewModel.fetchData()
                            }
                        )
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            if isDatePickerPresented {
                CustomDatePicker(selectedDate: Binding(
                    get: { viewModel.selectedDate },
                    set: { newDate in
                        viewModel.selectedDate = newDate
                        viewModel.currentDate = DateFormatter.string(from: newDate)
                    }), isDatePickerVisible: $isDatePickerPresented, action: viewModel.fetchData
                )
            }
        }
    }
    
}

#Preview {
    HomeView(viewModel: RoverViewModel())
}


extension Color {
    static let BackgroundOne = Color("BackgroundOne")
    static let AccentOne = Color("AccentOne")
    static let LayerOne = Color("LayerOne")
    static let LayerTwo = Color("LayerTwo")
    static let SystemTwo = Color("SystemTwo")
    static let SystemThree = Color("SystemThree")
}



//if #available(iOS 15.0, *) {
//                                        AsyncImage(
//                                            url: URL(string: photo.imgSrc)) { image in
//                                                image
//                                                    .resizable()
//                                                    .scaledToFit()
//                                                    .frame(width: 130, height: 130)
//                                                    .clipShape(.rect(cornerRadius: 20))
//                                                    .padding(10)
//                                            } placeholder: {
//                                                Rectangle()
//                                                    .fill(Color.gray.opacity(0.2))
//                                                    .frame(width: 130, height: 130)
//                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                                                    .padding(10)
//                                            }
//                                    } else {
//                                        Rectangle() // TODO() make it works with ios 13
//                                            .fill(Color.red)
//                                            .frame(width: 130, height: 130)
//                                            .clipShape(.rect(cornerRadius: 20))
//                                            .padding(10)
//                                    }
