//
//  Photo+CoreDataProperties.swift
//  journeypin
//
//  Created by Al Sneed on 03/06/2025.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photo: Data?
    @NSManaged public var photopin: Pin?

}

extension Photo : Identifiable {

}
