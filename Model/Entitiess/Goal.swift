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
    
}
