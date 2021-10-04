//
//  GoalListView.swift
//  GoalListView
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import SwiftUI
import ASSwiftUI
import RealmSwift

// MARK: - Memory footprint

struct GoalListView {
    
    @StateObject var viewModel: GoalListViewModel
    
    @EnvironmentObject var factory: GenericFactory
    
}

// MARK: - Rendering

extension GoalListView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.activeGoals) { goal in
                    Button {
                        viewModel.selectedGoal = goal
                    } label: {
                        Text(goal.title)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Text("Finished goals")
                ForEach(viewModel.inactiveGoals) { goal in
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
                .buttonStyle(FlatButtonStyle(.success, .medium))
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

// MARK: - Logic

extension GoalListView {
    
    
}

// MARK: - Previews

struct GoalListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let db = RealmService()
        let viewModel = GoalListViewModel(realm: db)
        GoalListView(viewModel: viewModel)
    }
}

