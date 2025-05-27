//
//  Pin+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 27/05/2025.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var name: String?
    @NSManaged public var lat: Float
    @NSManaged public var lon: Float
    @NSManaged public var pinphoto: Photo?
    @NSManaged public var pintrip: Trip?

}

extension Pin : Identifiable {

}
