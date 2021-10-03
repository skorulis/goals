//
//  DateSelectionView.swift
//  Goals
//
//  Created by Alexander Skorulis on 3/10/21.
//

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct DateSelectionView {
    
    @Binding private var outputDate: Date?
    @State private var innerDate: Date
    
    @Environment(\.presentationMode) var presentationMode
    
    init(date: Binding<Date?>) {
        _outputDate = date
        _innerDate = State(initialValue: date.wrappedValue ?? Date())
    }
}

// MARK: - Rendering

extension DateSelectionView: View {
    
    var body: some View {
        VStack {
            DatePicker("Date",
                       selection: $innerDate,
                       displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            
            buttons
        }
        .padding(16)
    }
    
    private var buttons: some View {
        HStack {
            Button(action: save) {
                Text("Select")
            }
            
            Button(action: delete) {
                Text("Clear")
            }
        }
    }
}

// MARK: - Behaviors

private extension DateSelectionView {
    
    func save() {
        outputDate = innerDate
        presentationMode.wrappedValue.dismiss()
    }
    
    func delete() {
        outputDate = nil
        presentationMode.wrappedValue.dismiss()
    }
    
}

// MARK: - Previews

struct DateSelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(Date()) { d in
            DateSelectionView(date: d)
        }
    }
}

