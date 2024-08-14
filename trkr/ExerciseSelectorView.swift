//
//  ExerciseSelectorView.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-14.
//

import SwiftUI

struct ExerciseSelectorView: View {
    var body: some View {
        List {
            VStack (alignment: .leading, spacing: 0) {
                Text("Bench press")
                HStack (spacing: 5) {
                    Text("Group: Chest")
                    Text("⋅")
                    Text("Last performed: 01 Aug 2024")
                    Text("⋅")
                    Text("PR: 30")
                    
                }.font(.caption)
            }
        }.listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ExerciseSelectorView()
            .navigationTitle("Select exercise")
    }
}
