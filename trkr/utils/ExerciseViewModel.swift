//
//  ExerciseViewModel.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import Foundation
import SwiftUI

class ExerciseViewModel: ObservableObject {
    /**
     List of exercises that are in the current workout.
     */
    @Published var exercises: [Exercise] = [Exercise.getDummy()]
    
    /**
     The total time of the workout in seconds, displayed as an Int
     */
    @Published var totalSeconds = 0 {
        didSet {
            let hour = Int(self.totalSeconds / 3600)
            let minutes = Int((self.totalSeconds - hour * 3600) / 60)
            let seconds = Int(self.totalSeconds - (hour * 3600 + minutes * 60))
            
            let displayHours: String = hour < 10 ? "0\(hour)" : "\(hour)"
            let displayMinutes: String = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let displaySeconds: String = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            
            
            self.totalDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
        }
    }
    /**
     The current rest time displayed as an Int
     */
    @Published var restTime = 0 {
        didSet {
            let hour = Int(self.restTime / 3600)
            let minutes = Int((self.restTime - hour * 3600) / 60)
            let seconds = Int(self.restTime - (hour * 3600 + minutes * 60))
            
            let displayHours: String = hour < 10 ? "0\(hour)" : "\(hour)"
            let displayMinutes: String = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let displaySeconds: String = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            
            self.restDisplayTime = "\(displayHours):\(displayMinutes):\(displaySeconds)"
        }
    }
    
    /**
     The total duration of the workout, displayed as hh:mm:ss
     */
    @Published var totalDisplayTime = "00:00:00"
    
    /**
     The current rest time, displayed as hh:mm:ss
     */
    @Published var restDisplayTime = "00:00:00"
    
    /**
     Enable/disable the modal view for displaying the exercise selector view
     */
    @Published var exerciseSelectorViewToggle = false
    
    /**
     Used to check if the Rest timer should be shown.
     */
    @Published var isCurrentlyResting = false
    
    func resetCurrentRestTime() {
        self.restTime = 0
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.totalSeconds += 1
            if self.isCurrentlyResting {
                if self.restTime == -1 {
                    self.restTime = 1
                } else {
                    self.restTime += 1
                }
            }
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        self.exercises.append(exercise)
    }
    
    func addSet() {
        self.exercises.last?.sets.append(Set(id: self.exercises.last!.sets.count))
    }
}
