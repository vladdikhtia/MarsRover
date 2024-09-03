//
//  HistoryView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var roverViewModel: RoverViewModel
    @ObservedObject var coreDataViewModel: CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isActionSheetPresented = false
    @State private var selectedFilter: FilterEntity? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            //header
            ZStack(alignment: .leading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    print("Go home")
                }) {
                    Image("left")
                }
                .padding(.leading, 12)
                
                Text("History")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color.LayerOne)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 54)
            .frame(height: 132)
            .background(Color.AccentOne)
            .shadow(
                color: .black.opacity(0.12),
                radius: 12,
                y: 5
            )
            
            if !coreDataViewModel.filters.isEmpty {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(coreDataViewModel.filters) { filter in
                            HistoryCard(filter: filter)
                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    self.selectedFilter = filter
                                    self.isActionSheetPresented = true
                                }
                        }
                    }
                    .padding(.top, 20)
                }
            } else {
                Spacer()
                
                Image("groupIm")
                    .opacity(0.8)
                
                Text("Browsing history is empty.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.LayerTwo)
                
                Spacer()
                Spacer()
            }
        }
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(
                title: Text("Menu Filter"),
                buttons: [
                    .default(Text("Use"), action: {
                        guard let filter = selectedFilter else {
                            print("ERROR")
                            return
                        }
                        roverViewModel.currentRover = MarsRover(rawValue: filter.rover ?? "Curiosity") ?? .curiosity
                        roverViewModel.currentCamera = MarsCamera(rawValue: filter.camera ?? "PANCAM") ?? .pancam
                        roverViewModel.currentDate = filter.date ?? "2006-9-10"
                        self.presentationMode.wrappedValue.dismiss()
                        roverViewModel.fetchData()
                        
                    }),
                    .destructive(Text("Delete"), action: {
                        withAnimation {
                            if let filter = selectedFilter {
                                coreDataViewModel.deleteFilter(filter: filter)
                            }
                        }
                    }),
                    .cancel(Text("Cancel"))
                ]
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HistoryView(roverViewModel: RoverViewModel(), coreDataViewModel: CoreDataViewModel())
}

