//
//  SaveBook+CoreDataProperties.swift
//  BookApp
//
//  Created by mun on 1/3/25.
//
//

import Foundation
import CoreData


extension SaveBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveBook> {
        return NSFetchRequest<SaveBook>(entityName: "SaveBook")
    }

    @NSManaged public var author: String?
    @NSManaged public var price: Int16
    @NSManaged public var title: String?
    @NSManaged public var contents: String?
    @NSManaged public var thumbnail: String?

}

extension SaveBook : Identifiable {

}
