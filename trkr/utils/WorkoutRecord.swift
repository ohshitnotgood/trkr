//
//  WorkoutRecord.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-13.
//

import Foundation

/**
 Represents an entire workout
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

/**
 Represents an exercise within a single workout.
 */
class Exercise: ObservableObject {
    let name: String
    @Published var sets: [Set]
    
    static func getDummy() -> Exercise {
        let sets: [Set] = [
            .init(id: 1, weight: "30", reps: "10", previous: "30x10"),
            .init(id: 2, weight: "40", reps: "10", previous: "30x10")
        ]
        return Exercise(name: "Bench Press", sets: sets)
    }
    
    init(name: String, sets: [Set]) {
        self.name = name
        self.sets = sets
    }
    
    func addSet() {
        self.sets.append(Set(id: sets.count + 1))
    }
}

/**
 Represents an individual set inside an exercise
 */
class Set: Equatable, Hashable, ObservableObject {
    enum CodingKeys: CodingKey {
        case weight, reps, restTime, id, previous
    }
    
    static func == (lhs: Set, rhs: Set) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var weight: String
    @Published var reps: String
    @Published var restTime: Int = 0
    
    let id: Int
    let previous: String
    
    init(id: Int) {
        self.id = id
        self.weight = ""
        self.reps = ""
        self.previous = ""
    }
    
    init(id: Int, weight: String, reps: String, previous: String) {
        self.id = id
        self.weight = weight
        self.reps = reps
        self.previous = previous
    }
}
