//
//  GoalEditViewModel.swift
//  GoalEditViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation

final class GoalEditViewModel: ObservableObject {
    
    var goal: Goal?
    
    let database: PersistenceController
    
    @Published var selectingDate: Bool = false
    
    @Published var title: String
    @Published var details: String
    @Published var target: Date?
    @Published var status: Goal.Status
    
    init(goal: Goal?, database: PersistenceController) {
        self.goal = goal
        self.database = database
        self.title = goal?.title ?? ""
        self.details = goal?.details ?? ""
        self.target = goal?.target
        self.status = goal?.status ?? .ongoing
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
        let goal = self.goal ?? Goal(context: database.container.viewContext)
        
        goal.title = title
        goal.details = details
        goal.target = target
        goal.status = status
        try? goal.managedObjectContext?.save()
    }
    
    func delete() {
        guard let goal = goal else { return }
        goal.managedObjectContext?.delete(goal)
        try? goal.managedObjectContext?.save()
    }
}
