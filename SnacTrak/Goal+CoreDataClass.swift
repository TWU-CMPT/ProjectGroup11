//
//  Goal+CoreDataClass.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-25.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: NSManagedObject {

    //convert goal to string
    func toString() -> String{
        let result = String(self.amount) + "g of " + self.nutrient!
        return result
    }
}
