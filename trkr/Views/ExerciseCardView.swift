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
                                ExerciseCardSetRowView(set: eachSet)
                                    .environmentObject(viewModel)
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

struct ExerciseCardGroupView: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct ExerciseCardSetRowView: View {
    @EnvironmentObject private var viewModel: ExerciseViewModel
    @StateObject var set: Set
    @State var offset: CGSize = .zero
    @State private var onceCompleted = false
    @State private var zerosInHistory = 0
    
    
    var body: some View {
        VStack {
            VStack (spacing: 0) {
                HStack {
                    // Set ID
                    Text("\(set.id)")
                        .frame(width: 30, height: 30)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Previous marker
                    HStack {
                        Spacer()
                        Text(set.previous == "" ? "-" : set.previous)
                        Spacer()
                    }
                    .frame(height: 30)
                    .padding(.horizontal)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Weights text field
                    TextField("", text: $set.weight)
                        .frame(width: 65, height: 30)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Reps text field
                    TextField("", text: $set.reps)
                        .frame(width: 65, height: 30)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Checkmark button for marking a set complete.
                    Button {
                        withAnimation {
                            self.viewModel.isCurrentlyResting = true
                            self.viewModel.restTime = 0
                        }
                        self.set.completed.toggle()
                    } label: {
                        if set.completed {
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                        } else {
                            Image(systemName: "square")
                                .resizable()
                        }
                    }.buttonStyle(.plain)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.secondary)
                }.padding(.vertical, 5)
            }
            .offset(x: offset.width)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
            
            // Divider with rest counter
            ZStack {
                Divider()
                HStack {
                    HStack {
                        Image(systemName: "timer")
                        Text("Avg: \(set.averageRestTime)")
                    }
                    if (self.set.completed) {
                        Button {
                            withAnimation {
                                viewModel.isCurrentlyResting = false
                            }
                        } label: {
                            HStack {
                                Image(systemName: "timer")
                                Text("Curr: \(set.currentRestTime)")
                            }
                        }.buttonStyle(.plain)
                    }
                }.foregroundStyle(.secondary)
                    .padding(.horizontal, 5)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.vertical, 2)
            }.font(.caption)
        }.onReceive(viewModel.$restDisplayTime, perform: { nv in
            if self.set.completed {
                // Keep track of the number of times the currentRest value is reset
                if self.viewModel.restTime == 0  {
                    zerosInHistory += 1
                }
                
                // If the number of resets is less then 0, only then you update the UI
                // There is at most 2 valid counter resets
                // Once when the current counter starts
                // Once when the next counter starts
                if zerosInHistory < 2 {
                    self.set.currentRestTime = nv
                }
            }
        })
    }
}
