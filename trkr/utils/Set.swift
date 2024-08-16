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
        return lhs.uid == rhs.uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var restTime: Int = 0
    @Published var completed: Bool = false
    @Published var currentRestTime = "00:00:00"
    @Published var subsets: [Subset] = []
    
    @Published var weight: String
    @Published var reps: String
    @Published var id: Int
    
    let previous: String
    let averageRestTime: String

    let uid = UUID()
    
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
    
    func addSubset() {
        self.subsets.append(.init(weight: "", reps: ""))
    }
    
    func convertToSubset() -> Subset {
        return .init(weight: self.weight, reps: self.reps)
    }
}

class Subset: ObservableObject, Hashable {
    @Published var weight: String
    @Published var reps: String
    @Published var completed: Bool = false
    
    var uid = UUID()
    
    var previous: String = ""
    
    init(weight: String, reps: String) {
        self.weight = weight
        self.reps = reps
    }
    
    init(uid: UUID, weight: String, reps: String) {
        self.uid = uid
        self.weight = weight
        self.reps = reps
    }
    
    static func == (lhs: Subset, rhs: Subset) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}
