//
//  ExerciseCardRowSetView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-16.
//

import SwiftUI


struct ExerciseCardSetRowView: View {
    @EnvironmentObject private var viewModel: ExerciseViewModel
    @EnvironmentObject var exercises: Exercise
    
    @ObservedObject var set: Set
    @State var offset: CGSize = .zero
    @State private var onceCompleted = false
    @State private var zerosInHistory = 0
    
    @State var subsetIndentation: CGFloat = 5
    
    var body: some View {
        VStack {
            VStack (spacing: 0) {
                VStack {
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
                }.offset(x: offset.width)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation
                            }
                            .onEnded { _ in
                                withAnimation {
                                    print(self.set.subsets.count)
                                    if offset.width > 200 {
                                        self.set.addSubset()
                                    }
                                    offset = .zero
                                }
                            }
                    )
                
                
                ForEach(self.$set.subsets, id: \.self) { index in
                    HStack {
                        // Set ID
                        Image(systemName: "arrow.turn.down.right")
                            .frame(width: 30, height: 30)
                        
                        // Previous marker
                        HStack {
                            Spacer()
                            Text(index.previous.wrappedValue)
                            Spacer()
                        }
                        .frame(height: 30)
                        .padding(.horizontal)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        // Weights text field
                        TextField("", text: index.weight)
                            .frame(width: 65, height: 30)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        // Reps text field
                        TextField("", text: index.reps)
                            .frame(width: 65, height: 30)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        VStack {
                            
                        }.frame(width: 20)
                        // Checkmark button for marking a set complete.
//                        Button {
//                            withAnimation {
//                                self.viewModel.isCurrentlyResting = true
//                                self.viewModel.restTime = 0
//                            }
//                            index.completed.wrappedValue.toggle()
//                        } label: {
//                            if index.completed.wrappedValue {
//                                Image(systemName: "checkmark.square.fill")
//                                    .resizable()
//                            } else {
//                                Image(systemName: "square")
//                                    .resizable()
//                            }
//                        }.buttonStyle(.plain)
//                            .frame(width: 25, height: 25)
//                            .foregroundStyle(.secondary)
                    }.padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .onAppear(perform: {
                            self.subsetIndentation += 10
                        })
                }
            }
            
            
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



#Preview {
    ExerciseCardSetRowView(set: .init(id: 0))
}
