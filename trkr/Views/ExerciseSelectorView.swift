//
//  ExerciseSelectorView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import SwiftUI

struct ExerciseSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: ExerciseViewModel
    
    private var exercises = Exercise.dummyExercises
    
    var body: some View {
        NavigationStack {
            List (exercises) { eachExercise in
                Button {
                    viewModel.exercises.append(eachExercise)
                    dismiss()
                } label: {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(eachExercise.name)
                        HStack (spacing: 5) {
                            Text("Group: \(eachExercise.group)")
                            Text("⋅")
                            Text("Last performed: \(eachExercise.lastPerformed)")
                            Text("⋅")
                            Text("PR: \(eachExercise.pr)")
                            
                        }.font(.caption)
                    }
                }.buttonStyle(.plain)
            }.listStyle(.plain)
                .navigationTitle("Select exercise")
        }
    }
}

#Preview {
    NavigationStack {
        ExerciseSelectorView()
            .navigationTitle("Select exercise")
    }
}
