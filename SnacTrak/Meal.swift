//
//  Meal.swift
//  SnacTrak
//
//  Created by Nick Miller on 2017-03-03.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

import Foundation
/*
class Meal{
    var name: String
    var foodItems: Array<FoodItem>
    
    init(nam: String, items: Array<FoodItem>){
        self.name = nam
        self.foodItems = items
    }
    
    init(nam: String){
        self.name = nam
        self.foodItems = [FoodItem]()
    }
    
    func add(food: FoodItem) -> Bool{
        self.foodItems.append(food)
        if(self.foodItems.isEmpty){
            return false
        }
        return true
    }
    
    func remove(nam: String) -> Bool{
        var success = false
        for index in 0...self.foodItems.count{
            let a = foodItems[index]
            if (a.name == nam){
                self.foodItems.remove(at: index)
                success = true
                return success
            }
        }
        return success
    }
    
    func equalTo(nam: String) -> Bool{
        if(nam.uppercased() == self.name.uppercased()){
            return true
        }
        else{
            return false
        }
    }
    
    func toString() -> String{
        let result = self.name
        return result
    }
    
    func printAll() -> String{
        var result = ""
        for index in 0...self.foodItems.count{
            let a = foodItems[index]
            result = result + a.toString() + "/n"
        }
        return result
    }
    
}*/
