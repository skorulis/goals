//
//  GoalRealm.swift
//  Goals
//
//  Created by Alexander Skorulis on 4/10/21.
//

import Foundation
import RealmSwift
import Realm

final class Goal: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted public var title: String = ""
    @Persisted public var details: String = ""
    @Persisted public var timestamp: Date = Date()
    @Persisted public var target: Date?
    
    @Persisted private var statusString: String?
    
    public var status: Status {
        get {
            return Status(rawValue: statusString ?? "") ?? .ongoing
        }
        set {
            statusString = newValue.rawValue
        }
    }
}

extension Goal {
    
    public enum Status: String, CaseIterable, Identifiable {
        case ongoing
        case finished
        case failed
        
        public var id: String {
            return rawValue
        }
    }
}
