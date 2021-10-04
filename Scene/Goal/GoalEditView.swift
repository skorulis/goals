//
//  GoalEditView.swift
//  GoalEditView
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import SwiftUI
import ASSwiftUI
import Neumorphic
import Introspect

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
                Picker("Status", selection: $viewModel.status) {
                    ForEach(Goal.Status.allCases) { status in
                        Text(status.rawValue)
                            .tag(status)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
                
                TextField("Name", text: $viewModel.title)
                    .modifier(NeumorphicFieldModifier())
                TextEditor(text: $viewModel.details)
                    .introspectTextView(customize: { view in
                        view.backgroundColor = .clear
                    })
                    .frame(minHeight: 200)
                    .modifier(NeumorphicFieldModifier())
                targetDate
                buttons
            }
            .padding(16)
        }
        .background(Color.white)
        
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
                Text("Save").bold()
            }
            .buttonStyle(FlatButtonStyle(.success, .small))
            
            Button(action: delete) {
                Text("Delete").bold()
            }
            .buttonStyle(FlatButtonStyle(.danger, .small))
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

