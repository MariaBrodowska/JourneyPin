//
//  User+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 14/06/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var lastActive: Bool
    @NSManaged public var usertrip: NSSet?

}

// MARK: Generated accessors for usertrip
extension User {

    @objc(addUsertripObject:)
    @NSManaged public func addToUsertrip(_ value: Trip)

    @objc(removeUsertripObject:)
    @NSManaged public func removeFromUsertrip(_ value: Trip)

    @objc(addUsertrip:)
    @NSManaged public func addToUsertrip(_ values: NSSet)

    @objc(removeUsertrip:)
    @NSManaged public func removeFromUsertrip(_ values: NSSet)

}

extension User : Identifiable {

}
