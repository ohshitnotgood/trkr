//
//  Exercise.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-15.
//

import SwiftUI


/**
 Represents an exercise within a single workout.
 */
class Exercise: ObservableObject, Hashable, Identifiable {
    let name: String
    let pr: String
    let group: ExerciseGroup
    let lastPerformed: String
    @Published var sets: [Set]
    
    
    init(name: String, pr: String, group: ExerciseGroup, lastPerformed: String, sets: [Set]) {
        self.name = name
        self.pr = pr
        self.group = group
        self.lastPerformed = lastPerformed
        self.sets = sets
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name == rhs.name
    }
    
    static var dummyExercises: [Exercise] = [
        .init(name: "Bench Press", pr: "40", group: .chest, lastPerformed: "01 August 2024", sets: []),
        .init(name: "Bicep Curls", pr: "40", group: .biceps, lastPerformed: "12 August 2024", sets: []),
        .init(name: "Chest Press", pr: "40", group: .chest, lastPerformed: "31 July 2024", sets: []),
        .init(name: "Leg Press", pr: "310", group: .legs, lastPerformed: "30 August 2024", sets: [])
    ]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
    
    static func getDummy() -> Exercise {
        return dummyExercises.randomElement()!
    }
    
    
    func addSet() {
        withAnimation {
            self.sets.append(Set(id: sets.count + 1))
        }
    }
}

enum ExerciseGroup: String {
    case chest = "Chest"
    case legs = "Legs"
    case shoulders = "Shoulders"
    case biceps = "Biceps"
    case triceps = "Triceps"
}
