//
//  ExerciseCardView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import SwiftUI

struct ExerciseCardView: View {
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
                                ExerciseCardSetRowView(set: eachSet, isLastSet: eachSet.id == exercise.sets.last?.id)
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
    @StateObject var set: Set
    @State var offset: CGSize = .zero
    @State var isLastSet: Bool
    
    
    var body: some View {
        VStack {
            VStack (spacing: 0) {
                HStack {
                    Text("\(set.id)")
                        .frame(width: 30, height: 30)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    HStack {
                        Spacer()
                        Text(set.previous == "" ? "-" : set.previous)
                        Spacer()
                    }
                    .frame(height: 30)
                    .padding(.horizontal)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    TextField("", text: $set.weight)
                        .frame(width: 65, height: 30)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    TextField("", text: $set.reps)
                        .frame(width: 65, height: 30)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Checkmark button for marking a set complete.
                    Button {
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
            
            // If this set is not the last set, then the average rest time along with the current rest time is displayed.
            // If it is indeed the last set, then the rest time is displayed outside the exercise card in it's own view
            // The current rest time (which is ticking) is only shown when the current set has been marked as complete.
            if (!isLastSet) {
                ZStack {
                    Divider()
                    HStack {
                        HStack {
                            Image(systemName: "timer")
                            Text("Avg: \(set.averageRestTime)")
                        }
                        if (self.set.completed) {
                            HStack {
                                Image(systemName: "timer")
                                Text("Curr: \(set.restTime)")
                            }
                        }
                    }.foregroundStyle(.secondary)
                        .padding(.horizontal, 5)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.vertical, 2)
                }.font(.caption)
            }
        }
    }
}
//
//#Preview {
//    ExerciseCardView(exercise: Exercise.getDummy())
//}
