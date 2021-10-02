//
//  MainCoordinator.swift
//  MainCoordinator
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import Stinsen
import SwiftUI

final class MainCoordinator: NavigationCoordinatable {
    
    private let factory: GenericFactory
    
    let stack = NavigationStack(initial: \MainCoordinator.start)

    @Root var start = goalList
    @Route(.push) var details = goalDetails
    
    init(factory: GenericFactory) {
        self.factory = factory
    }
    
    @ViewBuilder func goalList() -> some View {
        GoalListView(viewModel: self.factory.resolve())
    }
    
    @ViewBuilder func goalDetails(goal: Goal) -> some View {        
        GoalEditView(viewModel: self.factory.resolve(GoalEditViewModel.self, argument: goal))
    }
}
