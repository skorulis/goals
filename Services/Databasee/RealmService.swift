//
//  RealmService.swift
//  Goals
//
//  Created by Alexander Skorulis on 4/10/21.
//

import Foundation
import Realm
import RealmSwift

final class RealmService {
    
    let app = App(id: Secrets.realmAppID)
    var db: Realm
    
    init() {
        self.db = try! Realm()
        authenticate()
    }
    
    private func authenticate() {
        app.login(credentials: Credentials.anonymous) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                case .success(let user):
                    print("Login as \(user) succeeded!")
                    // Continue below
                    //onLogin()
                }
            }
        }
    }
    
}
