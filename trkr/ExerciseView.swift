//
//  ExerciseView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-12.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject private var workout = WorkoutRecord()
    @State private var totalSeconds = 0
    @State private var currentRestTime = 0
    @State private var totalDisplayTime = "00:00:00"
    @State private var restDisplayTime = "00:00:00"
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalSeconds += 1
            let hour = Int(totalSeconds / 3600)
            let minutes = Int((totalSeconds - hour * 3600) / 60)
            let seconds = Int(totalSeconds - (hour * 3600 + minutes * 60))
            
            let displayHours = hour < 10 ? "0\(hour)" : "\(hour)"
            let displayMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let displaySeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            
            totalDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
            restDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    ExerciseCardView(exercise: Exercise.getDummy())
                    RestTimeView()
                }
                VStack {
                    Spacer()
                    BottomBar(currentRestDisplayTime: $restDisplayTime, totalDisplayTime: $totalDisplayTime)
                }
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Workout")
                    }
                }
        }.onAppear {
            timer()
        }
    }
}

/**
 Displays the timers and the "Add exercise" button
 */
struct BottomBar: View {
    @Binding var currentRestDisplayTime: String
    @Binding var totalDisplayTime: String
    
    var body: some View {
        ZStack {
            HStack (spacing: 0) {
                Button(action: {
                }, label: {
                    HStack (spacing: 4) {
                        Image(systemName: "plus")
                        Text("Exercise")
                    }
                }).buttonStyle(.plain)
                    .padding(10)
                
                
                Divider()
                    .frame(height: 20)
                
                HStack (spacing: 4) {
                    Image(systemName: "timer")
                    Text("Rest")
                    Text(currentRestDisplayTime)
                        .fontWeight(.semibold)
                        .fontDesign(.monospaced)
                }.padding(10)
                    .frame(width: 130)
                
                
                Divider()
                    .frame(height: 20)
                
                HStack (spacing: 4) {
                    Image(systemName: "clock")
                    Text("Total")
                    Text(totalDisplayTime)
                        .fontWeight(.semibold)
                        .fontDesign(.monospaced)
                }.padding(10)
                    .frame(width: 130)
                
            }
            .font(.caption)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: .infinity))
        }
        
    }
}

struct ExerciseCardView: View {
    @StateObject var exercise: Exercise
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                
                VStack (spacing: 0) {
                    VStack (spacing: 5) {
                        HStack {
                            Text(exercise.name)
                                .fontWeight(.bold)
                                .font(.headline)
                            Spacer()
                            Text("Add set")
                                .font(.callout)
                        }.padding(.bottom)
                        
                        ExerciseCardHeader()
                        VStack (spacing: 0) {
                            ForEach(exercise.sets, id: \.self) { eachSet in
                                ExerciseCardSet(set: eachSet)
                                if (eachSet.id != exercise.sets.last?.id) {
                                    ZStack {
                                        Divider()
                                        HStack {
                                            HStack {
                                                Image(systemName: "timer")
                                                Text("Avg: 00:10:00")
                                            }
                                            
                                            HStack {
                                                Image(systemName: "timer")
                                                Text("Curr: 00:10:00")
                                            }
                                        }.foregroundStyle(.secondary)
                                            .padding(.horizontal, 5)
                                            .background(.regularMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .padding(.vertical, 2)
                                    }.font(.caption)
                                }
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

struct RestTimeView: View {
    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 5) {
                Image(systemName: "timer")
                Text("Rest time")
            }
            Text("00:00:10")
        }.font(.subheadline)
            .foregroundColor(.secondary)
    }
}

struct ExerciseCardHeader: View {
    var body: some View {
        HStack {
            Text("Set")
                .frame(width: 30)
            Text("Previous")
                .frame(width: 120, height: 20)
            Text("Weight")
                .frame(width: 55)
            Text("Reps")
                .frame(width: 55)
            Text("")
                .frame(width: 20)
        }.frame(maxWidth: .infinity)
            .fontWeight(.medium)
    }
}

struct ExerciseCardSet: View {
    @StateObject var set: Set
    @State var offset: CGSize = .zero
    @State var done = false
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Text("\(set.id)")
                    .frame(width: 30, height: 30)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Text(set.previous)
                    .frame(width: 120, height: 30)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                TextField("", text: $set.weight)
                    .frame(width: 55, height: 30)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                TextField("", text: $set.reps)
                    .frame(width: 55, height: 30)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Button {
                    done.toggle()
                } label: {
                    if done {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                    } else {
                        Image(systemName: "square")
                            .resizable()
                    }
                }.buttonStyle(.plain)
                    .frame(width: 20, height: 20)
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
    }
}


#Preview {
    ExerciseView()
}
