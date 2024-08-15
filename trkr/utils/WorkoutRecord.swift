//
//  WorkoutRecord.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-13.
//

import Foundation
import SwiftUI

/**
 Represents an entire workout, which acts as the view model.
 */
class WorkoutRecord: ObservableObject {
    @Published var exercises: [Exercise]
    @Published var time: String
    @Published var totalSeconds: Int
    
    init() {
        self.exercises = []
        self.time = "00:00:00"
        self.totalSeconds = 0
    }
    
    init(exercises: [Exercise], time: String) {
        self.exercises = exercises
        self.time = time
        self.totalSeconds = 0
    }
    
    func addExercise(_ exercise: Exercise) {
        self.exercises.append(exercise)
    }
}
