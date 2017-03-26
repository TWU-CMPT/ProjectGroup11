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

    //convert foodItem to string of contained nutrients
    func printAll() -> String{
        var result = ""
        let nutArray = Array(self.nutrients)
        if nutArray.count > 0
        {
            for i in 0...nutArray.count-1
            {
                let a = nutArray[i]
                result = result + a.name! + " "
                result = result + String(a.amount) + "g "
                result = result + String(serving*(a.amount)) + "g\n"
            }
        }
        return result
    }
    
}
