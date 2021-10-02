//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Skorulis on 2/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var factory: GenericFactory

    var body: some View {
        NavigationView {
            GoalListView(viewModel: factory.resolve())
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
