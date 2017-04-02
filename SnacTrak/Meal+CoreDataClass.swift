//
//  Meal+CoreDataClass.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-30.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation
import CoreData

@objc(Meal)
public class Meal: NSManagedObject {

    //print meal
    func printMeal() -> String {
        var result = "Meal Name:\n" + self.name! + "\n\n"
        let nutArray = ["Calories", "Fat", "Cholesterol", "Sodium", "Carbohydrate", "Fibre", "Sugars", "Protein", "Vitamin A", "Vitamin C", "Calcium", "Iron", "Potassium"]
        result += "Included Food Items:\n"
        if self.itemNames.count > 0
        {
            for i in 0...self.itemNames.count-1
            {
                result += self.itemNames[i] + "\n"
            }
        }
        result += "\nNutrient Name/Total:\n"
        for j in 0...nutArray.count-1
        {
            //bound check just in case
            if totals.count > j
            {
                if totals[j] > 0
                {
                    //assumed totals correspond to nutArray
                    if ((j == 2) || (j == 3) || (j == 12))
                    {
                        result += nutArray[j] + " " + String(totals[j]) + "mg\n"
                    }
                    else if j > 7
                    {
                        result += nutArray[j] + " " + String(totals[j]) + "%\n"
                    }
                    else
                    {
                        result += nutArray[j] + " " + String(totals[j]) + "g\n"
                    }
                }
            }
        }
        return result
    }
    
}
