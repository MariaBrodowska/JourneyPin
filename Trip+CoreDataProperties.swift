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
    public var pinArray: [Pin] {
        let set = trippin as? Set<Pin> ?? []
        return set.sorted{$0.name! < $1.name!}
    }

}

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
