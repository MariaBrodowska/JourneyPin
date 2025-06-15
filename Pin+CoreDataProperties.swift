//
//  Pin+CoreDataProperties.swift
//  journeypin
//
//  Created by maria on 15/06/2025.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var pintrip: Trip?

}

extension Pin : Identifiable {

}
