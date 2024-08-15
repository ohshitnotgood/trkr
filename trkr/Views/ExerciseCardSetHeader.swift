//
//  ExerciseCardSetHeader.swift
//  trkr
//
//  Created by Praanto Samadder on 2024-08-15.
//

import SwiftUI


struct ExerciseCardSetHeader: View {
    var body: some View {
        HStack {
            Text("Set")
                .frame(width: 30)
            Spacer()
            Text("Previous")
            Spacer()
            Text("Weight")
                .frame(width: 65)
            Text("Reps")
                .frame(width: 65)
            Text("")
                .frame(width: 20)
        }.frame(maxWidth: .infinity)
            .fontWeight(.medium)
    }
}

#Preview {
    ExerciseCardSetHeader()
}
