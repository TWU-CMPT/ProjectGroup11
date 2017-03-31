//
//  Nutrient+CoreDataProperties.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-25.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData


extension Nutrient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrient> {
        return NSFetchRequest<Nutrient>(entityName: "Nutrient");
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var foodItem: FoodItem?

}
