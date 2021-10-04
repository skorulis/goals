//
//  GoalListViewModel.swift
//  GoalListViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation

final class GoalListViewModel: ObservableObject {
    
    let database: PersistenceController
    
    @Published var selectedGoal: Goal?
    
    init(database: PersistenceController) {
        self.database = database
    }
}

// MARK: - Logic

extension GoalListViewModel {
 
    var newGoal: Goal {
        let goal = Goal(context: database.container.viewContext)
        return goal
    }
    
}

// MARK: - Behaviors

extension GoalListViewModel {
    
    func add() {
        
    }
    
}
