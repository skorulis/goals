//
//  GoalListViewModel.swift
//  GoalListViewModel
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import Realm
import RealmSwift

final class GoalListViewModel: ObservableObject {
    
    let realm: RealmService
    
    @Published var selectedGoal: Goal?
    
    @Published var activeGoals: Results<Goal>
    @Published var inactiveGoals: Results<Goal>
    
    private var activeToken: RLMNotificationToken?
    private var inactiveToken: RLMNotificationToken?
    
    init(realm: RealmService) {
        self.realm = realm
        activeGoals = realm.db.objects(Goal.self).filter(Self.activePredicate)
        inactiveGoals = realm.db.objects(Goal.self).filter(Self.inactivePredicate)
        
        activeToken = activeGoals.observe { [unowned self] _ in
            self.objectWillChange.send()
        }
        
        inactiveToken = inactiveGoals.observe { [unowned self] _ in
            self.objectWillChange.send()
        }
    }
}

// MARK: - Logic

extension GoalListViewModel {
 
    var newGoal: Goal {
        return Goal()
    }
    
    static var activePredicate: NSPredicate {
        NSPredicate(format: "statusString = %@ OR statusString = nil",Goal.Status.ongoing.rawValue)
    }
    
    static var inactivePredicate: NSPredicate {
        NSPredicate(format: "statusString != %@ AND statusString != nil",Goal.Status.ongoing.rawValue)
    }
    
}

// MARK: - Inner types

extension GoalListViewModel {
 
}

// MARK: - Behaviors

extension GoalListViewModel {
    
    func add() {
        
    }
    
}
