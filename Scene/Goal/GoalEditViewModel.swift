//
//  GoalEditViewModel.swift
//  GoalEditViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation

final class GoalEditViewModel: ObservableObject {
    
    var goal: Goal
    
    @Published var selectingDate: Bool = false
    
    @Published var title: String
    @Published var details: String
    @Published var target: Date?
    
    init(goal: Goal) {
        self.goal = goal
        self.title = goal.title
        self.details = goal.details
        self.target = goal.target
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
        goal.title = title
        goal.details = details
        goal.target = target
        try? goal.managedObjectContext?.save()
    }
    
    func delete() {
        goal.managedObjectContext?.delete(goal)
        try? goal.managedObjectContext?.save()
    }
}
