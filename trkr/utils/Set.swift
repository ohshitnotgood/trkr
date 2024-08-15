//
//  Set.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-15.
//

import Foundation

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
    
    @Published var restTime: Int = 0
    @Published var completed: Bool = false
    @Published var currentRestTime = "00:00:00"
    
    @Published var weight: String
    @Published var reps: String
    
    let id: Int
    let previous: String
    let averageRestTime: String
    
    init(id: Int) {
        self.id = id
        self.weight = ""
        self.reps = ""
        self.previous = ""
        self.averageRestTime = "00:00:00"
    }
    
    init(id: Int, weight: String, reps: String, previous: String, averageRestTime: String) {
        self.id = id
        self.weight = weight
        self.reps = reps
        self.previous = previous
        self.averageRestTime = averageRestTime
    }
}
