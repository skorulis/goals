//
//  Goal.swift
//  Goal
//
//  Created by Alexander Skorulis on 2/10/21.
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: NSManagedObject, Identifiable {
 
    @nonobjc class func fetch() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }
    
    @NSManaged public var title: String
    @NSManaged public var details: String
    @NSManaged public var timestamp: Date
    @NSManaged public var target: Date?
    
    @NSManaged private var statusString: String?
    
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
