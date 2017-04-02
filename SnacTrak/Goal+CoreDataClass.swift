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
    func toString() -> String {
        var result = ""
        let nutName = self.nutrient
        if ((nutName == "Sodium") || (nutName == "Cholesterol") || (nutName == "Potassium"))
        {
            result = String(self.amount) + "mg of " + self.nutrient!
        }
        else if ((nutName == "Vitamin A") || (nutName == "Vitamin C") || (nutName == "Calcium") || (nutName == "Iron"))
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
