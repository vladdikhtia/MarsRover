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
    @State private var showAddFilterAlert: Bool = false
    
    @State private var isImageViewerPresented = false
    @State private var selectedImage: UIImage? = nil
    
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
                        onClick: { showAddFilterAlert = true }
                    )
                    if !roverViewModel.photos.isEmpty {
                        ScrollView{
                            VStack(spacing: 12){
                                ForEach(roverViewModel.photos, id: \.id) { photo in
                                    DetailCard(photo: photo) { image in
                                        if let image = image {
                                            selectedImage = image
                                            isImageViewerPresented = true
                                        }
                                    }
                                    
//                                    if photo = roverViewModel.appPhotos.last {
//                                        Text("Loading data...")
//                                            .onAppear {
//                                                roverViewModel.fetchData()
//                                            }
//                                    }
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
                if isImageViewerPresented,
                   let image = selectedImage {
                    FullScreenImageView(image: image, isImageShown: $isImageViewerPresented)
                        .transition(.opacity)
                        .zIndex(1)
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
                        HistoryView(roverViewModel: roverViewModel, coreDataViewModel: coreDataViewModel)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        FloatingButton()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding([.bottom, .trailing], 20)
                }
            }
            .animation(.easeInOut, value: isImageViewerPresented)
            .alert(isPresented: $showAddFilterAlert,
                   content: {
                Alert(
                    title: Text("Save Filters"),
                    message: Text("The current filters and the date you have chosen can be saved to the filter history.")
                    ,
                    primaryButton: .default(Text("Save"))
                    {
                        coreDataViewModel.addFilter(
                            roverName: roverViewModel.currentRover.rawValue,
                            cameraName: roverViewModel.currentCamera.rawValue,
                            date: roverViewModel.currentDate
                        )
                        print("Save pressed!")
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            })
            .edgesIgnoringSafeArea(.all)
        }
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
