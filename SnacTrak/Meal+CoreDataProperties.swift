//
//  Meal+CoreDataProperties.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-30.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal");
    }

    @NSManaged public var name: String?
    @NSManaged public var itemNames: [String]
    @NSManaged public var totals: [Double]

}
