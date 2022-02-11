//
//  Prod_item+CoreDataProperties.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//
//

import Foundation
import CoreData


extension Prod_item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prod_item> {
        return NSFetchRequest<Prod_item>(entityName: "Prod_item")
    }

    @NSManaged public var id: Int16
    //@NSManaged public var liked: Bool

}

extension Prod_item : Identifiable {

}
