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
    
    // Using observed object may cause issues
    @ObservedObject var viewModel: GoalEditViewModel
    
    @Environment(\.presentationMode) var presentationMode
}

// MARK: - Rendering

extension GoalEditView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("Name", text: $viewModel.title)
                TextEditor(text: $viewModel.details)
                    .frame(minHeight: 200)
                targetDate
                buttons
            }
            .padding(16)
        }
        
    }
    
    private var targetDate: some View {
        Button {
            viewModel.selectingDate = true
        } label: {
            Text(viewModel.targetText)
        }
        .popover(isPresented: $viewModel.selectingDate) {
            DateSelectionView(date: $viewModel.target)
        }
    }
    
    private var buttons: some View {
        HStack {
            Button(action: viewModel.save) {
                Text("Save")
            }
            
            Button(action: delete) {
                Text("Delete")
            }
        }
    }
}

// MARK: - Behaviors

extension GoalEditView {
    
    func delete() {
        viewModel.delete()
    }
    
}

// MARK: - Previews

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        let db = PersistenceController.inMemory
        let viewModel = GoalEditViewModel(goal: Goal(context: db.mainContext))
        GoalEditView(viewModel: viewModel)
    }
}

