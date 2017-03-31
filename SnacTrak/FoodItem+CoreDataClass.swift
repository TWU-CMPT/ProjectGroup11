//
//  FoodItem+CoreDataClass.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-25.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData

@objc(FoodItem)
public class FoodItem: NSManagedObject {
    
    func printAll() -> String {
        var result = "Nutrient Name/Amount Per Serving/Total:\n"
        let nutArray = Array(self.nutrients)
        if nutArray.count > 0
        {
            for i in 0...nutArray.count-1
            {
                let a = nutArray[i]
                let nutName = a.name?.lowercased()
                
                if ((nutName == "sodium") || (nutName == "cholesterol"))
                {
                    result += a.name! + " " + String(a.amount) + "mg " + String(serving*(a.amount)) + "mg\n"
                }
                else if ((nutName == "vitamin a") || (nutName == "vitamin c") || (nutName == "calcium") || (nutName == "iron"))
                {
                    result += a.name! + " " + String(a.amount) + "% " + String(serving*(a.amount)) + "%\n"
                }
                else
                {
                    result += a.name! + " " + String(a.amount) + "g " + String(serving*(a.amount)) + "g\n"
                }
            }
        }
        return result
    }
    
    func printItem() -> String {
        var result = "Item Name:\n" + self.name! + "\n\n"
        
        result += "Number of Servings:\n" + String(self.serving) + "\n\n"
        
        result += self.printAll()
        
        return result
    }
    
}
