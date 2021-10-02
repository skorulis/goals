//
//  GoalEditViewModel.swift
//  GoalEditViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation

final class GoalEditViewModel: ObservableObject {
    
    var goal: Goal
    
    @Published var title: String
    @Published var details: String
    
    init(goal: Goal) {
        self.goal = goal
        self.title = goal.title
        self.details = goal.details
    }
    
    
}

// MARK: - Behaviors

extension GoalEditViewModel {
    
    func save() {
        goal.title = title
        try? goal.managedObjectContext?.save()
    }
}
