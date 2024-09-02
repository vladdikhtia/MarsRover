//
//  HistoryView.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 02/09/2024.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode

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
                    .foregroundColor(Color.layerOne)
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
            
            if !viewModel.filters.isEmpty {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.filters) { filter in
                            HistoryCard(filter: filter)
                                .padding(.horizontal, 20)
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
        .edgesIgnoringSafeArea(.all)
        
    }        
}

#Preview {
    HistoryView(viewModel: CoreDataViewModel())
}
