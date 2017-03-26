//
//  Goal+CoreDataProperties.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-25.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal");
    }

    @NSManaged public var nutrient: String?
    @NSManaged public var amount: Double
    @NSManaged public var completedBy: NSDate?
    @NSManaged public var progress: Double

}
