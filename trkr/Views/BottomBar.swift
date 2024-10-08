//
//  BottomBar.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import SwiftUI

/**
 Displays the timers and the "Add exercise" button
 */
struct BottomBar: View {
    @EnvironmentObject var viewModel: ExerciseViewModel
    
    @State var totalDisplayTime = "00:00:00"
    @State var restDisplayTime = "00:00:00"
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack (spacing: 0) {
                    Button(action: {
                        viewModel.exerciseSelectorViewToggle = true
                    }, label: {
                        HStack (spacing: 4) {
                            Image(systemName: "plus")
                            Text("Exercise")
                        }
                    }).buttonStyle(.plain)
                        .padding(10)
                    
                    
                    Divider()
                        .frame(height: 20)
                    
//                    if viewModel.isCurrentlyResting {
//                        HStack (spacing: 4) {
//                            Image(systemName: "timer")
//                            Text("Rest")
//                            Text(restDisplayTime)
//                                .fontWeight(.semibold)
//                                .fontDesign(.monospaced)
//                        }.padding(10)
//                            .frame(width: 130)
//                    }
                    
                    Divider()
                        .frame(height: 20)
                    
                    HStack (spacing: 4) {
                        Image(systemName: "clock")
                        Text("Total")
                        Text(totalDisplayTime)
                            .fontWeight(.semibold)
                    }.padding(10)
                    
                }
                .font(.subheadline)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .padding(.vertical)
            }
        }
        .onReceive(viewModel.$totalDisplayTime, perform: { nv in
            totalDisplayTime = nv
        })
        .onReceive(viewModel.$restDisplayTime, perform: { nv in
            restDisplayTime = nv
        })
        
    }
}

#Preview {
    BottomBar()
        .environmentObject(ExerciseViewModel())
}
