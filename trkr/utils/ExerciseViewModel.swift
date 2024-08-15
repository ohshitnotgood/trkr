//
//  ExerciseViewModel.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import Foundation
import SwiftUI

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = [Exercise.getDummy()]
    @Published var totalSeconds = 0
    @Published var currentRestTime = 0
    @Published var totalDisplayTime = "00:00:00"
    @Published var restDisplayTime = "00:00:00"
    
    @Published var exerciseSelectorViewToggle = false
    
    func resetCurrentRestTime() {
        self.currentRestTime = 0
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.totalSeconds += 1
            
            let hour = Int(self.totalSeconds / 3600)
            let minutes = Int((self.totalSeconds - hour * 3600) / 60)
            let seconds = Int(self.totalSeconds - (hour * 3600 + minutes * 60))
            
            let displayHours: String = hour < 10 ? "0\(hour)" : "\(hour)"
            let displayMinutes: String = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let displaySeconds: String = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            
            
            self.totalDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
            self.restDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        self.exercises.append(exercise)
    }
    
    func addExerciseFromModalView() {
        
    }
    
    func addSet() {
        self.exercises.last?.sets.append(Set(id: self.exercises.last!.sets.count))
    }
}
