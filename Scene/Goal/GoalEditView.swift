//
//  GoalEditView.swift
//  GoalEditView
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct GoalEditView {
    
    @StateObject var viewModel: GoalEditViewModel
}

// MARK: - Rendering

extension GoalEditView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Name", text: $viewModel.title)
                TextEditor(text: $viewModel.details)
                Button(action: viewModel.save) {
                    Text("Save")
                }
            }
        }
        
    }
}

// MARK: - Previews

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = GoalEditViewModel(goal: Goal())
        GoalEditView(viewModel: viewModel)
    }
}

