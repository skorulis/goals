//
//  GoalListView.swift
//  GoalListView
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import SwiftUI
import Stinsen
import ASSwiftUI

// MARK: - Memory footprint

struct GoalListView {
    
    @StateObject var viewModel: GoalListViewModel
    @EnvironmentObject var mainRouter: MainCoordinator.Router
    
    @EnvironmentObject var factory: GenericFactory
    
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [], predicate: nil)

    var goals: FetchedResults<Goal>
    
}

// MARK: - Rendering

extension GoalListView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(goals) { goal in
                    Button {
                        viewModel.selectedGoal = goal
                    } label: {
                        Text(goal.title)
                    }
                }
                
                Button {
                    viewModel.selectedGoal = viewModel.newGoal
                } label: {
                    Text("Add")
                }
            }
            navigation
        }
    }
    
    private var navigation: some View {
        NavigationHelper.invisible(selection: $viewModel.selectedGoal) { goal in
            GoalEditView(viewModel: factory.resolve(GoalEditViewModel.self, argument: goal))
        }
    }
    
    @ViewBuilder
    private var details: some View {
        if let goal = viewModel.selectedGoal {
            GoalEditView(viewModel: factory.resolve(GoalEditViewModel.self, argument: goal))
        }
    }
}

// MARK: - Previews

struct GoalListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let db = PersistenceController.inMemory
        let viewModel = GoalListViewModel(database: db)
        GoalListView(viewModel: viewModel)
    }
}

