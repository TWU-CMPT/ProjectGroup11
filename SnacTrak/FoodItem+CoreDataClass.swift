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
    
    //print fooditem
    func printItem() -> String {
        var result = "Item Name:\n" + self.name! + "\n\n"
        result += "Number of Servings:\n" + String(self.serving) + "\n\n"
        result += self.printAll()
        return result
    }
    
    //print nutrient amounts and totals
    func printAll() -> String {
        var result = "Nutrient Name/Amount Per Serving/Total:\n"
        let nutArray = Array(self.nutrients)
        if nutArray.count > 0
        {
            for i in 0...nutArray.count-1
            {
                let a = nutArray[i]
                let nutName = a.name
                
                if ((nutName == "Sodium") || (nutName == "Cholesterol") || (nutName == "Potassium"))
                {
                    result += a.name! + " " + String(a.amount) + "mg " + String(serving*(a.amount)) + "mg\n"
                }
                else if ((nutName == "Vitamin A") || (nutName == "Vitamin C") || (nutName == "Calcium") || (nutName == "Iron"))
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
    
    //print nutrient amounts only
    func printExisting() -> String {
        var result = ""
        let nutArray = Array(self.nutrients)
        if nutArray.count > 0
        {
            for i in 0...nutArray.count-1
            {
                let a = nutArray[i]
                let nutName = a.name
                
                if ((nutName == "Sodium") || (nutName == "Cholesterol") || (nutName == "Potassium"))
                {
                    result += a.name! + " " + String(format: "%g", a.amount) + "mg\n"
                }
                else if ((nutName == "Vitamin A") || (nutName == "Vitamin C") || (nutName == "Calcium") || (nutName == "Iron"))
                {
                    result += a.name! + " " + String(format: "%g", a.amount) + "%\n"
                }
                else
                {
                    result += a.name! + " " + String(format: "%g", a.amount) + "g\n"
                }
            }
        }
        return result
    }
    
}
