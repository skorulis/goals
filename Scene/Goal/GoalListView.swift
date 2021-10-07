//
//  GoalListView.swift
//  GoalListView
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct GoalListView {
    
    @StateObject var viewModel: GoalListViewModel
    
    @EnvironmentObject var factory: GenericFactory
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [],
        predicate: Self.activePredicate
    )
    var activeGoals: FetchedResults<Goal>
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [],
        predicate: Self.inactivePredicate
    )
    var inactiveGoals: FetchedResults<Goal>
    
}

// MARK: - Rendering

extension GoalListView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.activeGoals) { goal in
                    cell(goal: goal)
                }
                
                Text("Finished goals")
                ForEach(inactiveGoals) { goal in
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
        .padding(8)
    }
    
    private func cell(goal: Goal) -> some View {
        Button {
            viewModel.selectedGoal = goal
        } label: {
            VStack(alignment: .leading) {
                Text(goal.title)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.neutral500, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
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
    
    static var activePredicate: NSPredicate {
        NSPredicate(format: "statusString = %@ OR statusString = nil",Goal.Status.ongoing.rawValue)
    }
    
    static var inactivePredicate: NSPredicate {
        NSPredicate(format: "statusString != %@ AND statusString != nil",Goal.Status.ongoing.rawValue)
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

