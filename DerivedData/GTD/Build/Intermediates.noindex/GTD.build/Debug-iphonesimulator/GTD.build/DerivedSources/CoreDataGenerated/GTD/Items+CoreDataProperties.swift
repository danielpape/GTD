//
//  Items+CoreDataProperties.swift
//  
//
//  Created by Daniel Pape on 06/06/2019.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var name: String?

}
