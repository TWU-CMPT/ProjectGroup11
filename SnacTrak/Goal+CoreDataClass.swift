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
        var result = ""
        let nutName = self.nutrient?.lowercased()
        
        if ((nutName == "sodium") || (nutName == "cholesterol"))
        {
            result = String(self.amount) + "mg of " + self.nutrient!
        }
        else if ((nutName == "vitamin a") || (nutName == "vitamin c") || (nutName == "calcium") || (nutName == "iron"))
        {
            result = String(self.amount) + "% of " + self.nutrient!
        }
        else
        {
            result = String(self.amount) + "g of " + self.nutrient!
        }
        return result
    }
}
