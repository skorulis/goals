//
//  GoalSummaryView.swift
//  Goals
//
//  Created by Alexander Skorulis on 4/10/21.
//

import Foundation

import SwiftUI

// MARK: - Memory footprint

struct GoalSummaryView {
    
    let goal: Goal
    
}

// MARK: - Rendering

extension GoalSummaryView: View {
    
    var body: some View {
        Text(goal.title)
    }
}

// MARK: - Previews

struct GoalSummaryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let db = PersistenceController.inMemory
        let goal = Goal(context: db.mainContext)
        goal.title = "TEST 123"
        return GoalSummaryView(goal: goal)
    }
}

