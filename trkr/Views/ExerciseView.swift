//
//  ExerciseView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-12.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    ForEach(viewModel.exercises, id: \.self) { eachExercise in
                        // CardView
                        ExerciseCardView(exercise: eachExercise)
                        // End card view
                    }
                }
                // Bottom bar
                BottomBar()
                    .environmentObject(viewModel)
                // End bottom bar
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Workout")
                    }
                }
        }.onAppear {
            viewModel.startTimer()
        }.sheet(isPresented: $viewModel.exerciseSelectorViewToggle, content: {
            ExerciseSelectorView()
                .environmentObject(viewModel)
        })
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


#Preview {
    ExerciseView()
}
