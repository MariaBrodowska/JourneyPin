//
//  Trip+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 03/06/2025.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var date: Date?
    @NSManaged public var notes: String?
    @NSManaged public var tripname: String?
    @NSManaged public var trippin: NSSet?
    @NSManaged public var tripuser: User?

}

// MARK: Generated accessors for trippin
extension Trip {

    @objc(addTrippinObject:)
    @NSManaged public func addToTrippin(_ value: Pin)

    @objc(removeTrippinObject:)
    @NSManaged public func removeFromTrippin(_ value: Pin)

    @objc(addTrippin:)
    @NSManaged public func addToTrippin(_ values: NSSet)

    @objc(removeTrippin:)
    @NSManaged public func removeFromTrippin(_ values: NSSet)

}

extension Trip : Identifiable {

}
