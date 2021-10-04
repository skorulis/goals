//
//  GoalEditViewModel.swift
//  GoalEditViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation

final class GoalEditViewModel: ObservableObject {
    
    var goal: Goal
    
    let database: RealmService
    
    @Published var selectingDate: Bool = false
    
    @Published var title: String
    @Published var details: String
    @Published var target: Date?
    @Published var status: Goal.Status
    
    init(goal: Goal, database: RealmService) {
        self.goal = goal
        self.database = database
        self.title = goal.title
        self.details = goal.details
        self.target = goal.target
        self.status = goal.status
    }
    
}

// MARK: - Logic

extension GoalEditViewModel {
 
    var targetText: String {
        if let date = target {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        } else {
            return "Select date"
        }
    }
    
}

// MARK: - Behaviors

extension GoalEditViewModel {
    
    func save() {
        let db = database.db
        
        try! db.write {
            goal.title = title
            goal.details = details
            goal.target = target
            goal.status = status
            if goal.realm == nil {
                db.add(goal)
            }
        }
    }
    
    func delete() {
        if let db = goal.realm?.thaw() {

            try! db.write {
                db.delete(goal)
            }
        }
    }
}
