//
//  HomeView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 31/08/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var roverViewModel: RoverViewModel
    @ObservedObject var coreDataViewModel: CoreDataViewModel
    
    @State var isDatePickerPresented: Bool = false
    @State var cameraFilterIsPresented: Bool = false
    @State var roverFilterIsPresented: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0) {
                    //header
                    HeaderView(
                        selectedDate:  Binding(
                            get: { roverViewModel.formattedDateForDisplaying },
                            set: { newDate in
                                if let date = DateFormatter.date(from: newDate) {
                                    roverViewModel.selectedDate = date
                                    roverViewModel.currentDate = newDate
                                }
                            }),
                        isDatePickerPresented: $isDatePickerPresented,
                        cameraFilterIsPresented: $cameraFilterIsPresented,
                        roverFilterIsPresented: $roverFilterIsPresented,
                        currentRover: Binding(get: {
                            roverViewModel.currentRover
                        }, set: { newRover in
                            roverViewModel.currentRover = newRover
                        }),
                        currentCamera: Binding(get: {
                            roverViewModel.currentCamera
                        }, set: { newCamera in
                            roverViewModel.currentCamera = newCamera
                        }),
                        onClick: add
                    )
                    if !roverViewModel.photos.isEmpty {
                        ScrollView{
                            VStack(spacing: 12){
                                ForEach(roverViewModel.photos) { photo in
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
                    
                    Spacer()
                    
                    if roverFilterIsPresented {
                        FilterSheet(filterTitle: "Rover", filterIsPresented: $roverFilterIsPresented, viewModel: roverViewModel,
                                    saveAction: {
                            roverViewModel.fetchData()
                        }
                        )
                    }
                    
                    if cameraFilterIsPresented {
                        FilterSheet(filterTitle: "Camera",
                                    filterIsPresented: $cameraFilterIsPresented,
                                    viewModel: roverViewModel,
                                    saveAction: {
                            roverViewModel.fetchData()
                        }
                        )
                    }
                }
                
                if isDatePickerPresented {
                    CustomDatePicker(selectedDate: Binding(
                        get: { roverViewModel.selectedDate },
                        set: { newDate in
                            roverViewModel.selectedDate = newDate
                            roverViewModel.currentDate = DateFormatter.string(from: newDate)
                        }), isDatePickerVisible: $isDatePickerPresented, action: roverViewModel.fetchData
                    )
                }
                
                if !isDatePickerPresented && !cameraFilterIsPresented && !roverFilterIsPresented {
                    NavigationLink{
                        HistoryView(viewModel: coreDataViewModel)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        FloatingButton()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding([.bottom, .trailing], 20)
                }
            }
            .edgesIgnoringSafeArea(.all)

        }
    }
    private func add() {
        coreDataViewModel.addFilter(
            roverName: roverViewModel.currentRover.rawValue,
            cameraName: roverViewModel.currentCamera.description,
            date: roverViewModel.currentDate
        )
    }
    
}

#Preview {
    HomeView(roverViewModel: RoverViewModel(), coreDataViewModel: CoreDataViewModel())
    
}


extension Color {
    static let BackgroundOne = Color("BackgroundOne")
    static let AccentOne = Color("AccentOne")
    static let LayerOne = Color("LayerOne")
    static let LayerTwo = Color("LayerTwo")
    static let SystemTwo = Color("SystemTwo")
    static let SystemThree = Color("SystemThree")
}
