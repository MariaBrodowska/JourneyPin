//
//  Trip+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 27/05/2025.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var tripname: String?
    @NSManaged public var notes: String?
    @NSManaged public var date: Date?
    @NSManaged public var trippin: Pin?
    @NSManaged public var tripuser: User?

}

extension Trip : Identifiable {

}
