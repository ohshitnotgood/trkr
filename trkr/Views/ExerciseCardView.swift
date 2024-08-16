//
//  ExerciseCardView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import SwiftUI

struct ExerciseCardView: View {
    @EnvironmentObject private var viewModel: ExerciseViewModel
    @StateObject var exercise: Exercise
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThickMaterial)
                
                VStack (spacing: 0) {
                    VStack (spacing: 5) {
                        HStack {
                            Text(exercise.name)
                                .fontWeight(.bold)
                                .font(.headline)
                            Spacer()
                            Button ("Add set") {
                                withAnimation {
                                    self.exercise.addSet()
                                }
                            }.buttonStyle(.plain)
                                .font(.callout)
                        }.padding(.bottom)
                        
                        ExerciseCardSetHeader()
                        
                        VStack (spacing: 0) {
                            ForEach(exercise.sets, id: \.self) { eachSet in
                                EXCardSetGroupView(set: eachSet)
                                    .environmentObject(viewModel)
                                    .environmentObject(exercise)
                            }
                        }.clipShape(RoundedRectangle(cornerRadius: 10))
                    }.padding()
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray, lineWidth: 0.1)
                        }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
    }
}
