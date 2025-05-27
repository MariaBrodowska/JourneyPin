//
//  User+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 27/05/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var usertrip: Trip?

}

extension User : Identifiable {

}
