//
//  FoodItem+CoreDataProperties.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-25.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var serving: Double
    @NSManaged public var nutrients: Set<Nutrient>

}

// MARK: Generated accessors for nutrients
extension FoodItem {

    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: Nutrient)

    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: Nutrient)

    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)

    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)

}
