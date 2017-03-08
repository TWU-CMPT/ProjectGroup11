//
//  FoodItem.swift
//  SnacTrak
//
//  Created by Nick Miller and Brittany Ryan on 2017-03-03.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

class FoodItem{
    //attributes
    
    var name: String
    var nutrients: Array<Nutrient>
    
    //methods
    
    //initialize foodItem
    init(nam: String, nuts: Array<Nutrient>){
        self.name = nam
        self.nutrients = nuts
    }
    init(nam: String){
        self.name = nam
        self.nutrients = [Nutrient]()
    }
    
    //add nutrient to foodItem
    func add(nutrient: Nutrient) -> Bool{
        self.nutrients.append(nutrient)
        if(self.nutrients.isEmpty){
            return false
        }
        return true
    }
    
    //remove nutrient to foodItem
    func remove(nam: String) -> Bool{
        var success = false
        let n = nam;
        for index in 0...self.nutrients.count{
            let a = nutrients[index]
            if (a.equalTo(nam: n)){
                self.nutrients.remove(at: index)
                success = true
                return success
            }
        }
        return success
    }
    
    //check if foodItems are equal
    func equalTo(nam: String) -> Bool{
        if(nam.uppercased() == self.name.uppercased()){
            return true
        }
        else{
            return false
        }
    }
    
    //convert foodItem to string for version 1 temporary storing method before database
    func toString() -> String{
        var result = self.name
        if nutrients.count > 0
        {
            for index in 0...(self.nutrients.count-1){
                let a = nutrients[index]
                if index == 0
                {
                    result = result + "." + a.toString()
                }
                else{
                    result = result + " " + a.toString()
                }
                
            }
        }
        return result
    }
    
    //convert foodItem to string of contained nutrients
    func printAll() -> String{
        var result = ""
        if nutrients.count > 0
        {
            for index in 0...(self.nutrients.count-1){
                let a = nutrients[index]
                result = result + a.toString() + "\n"
            }
        }
        
        return result
    }
    
    
    
}
