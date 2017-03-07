//
//  FoodItem.swift
//  SnacTrak
//
//  Created by Nick Miller on 2017-03-03.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

class FoodItem{
    var name: String
    var nutrients: Array<Nutrient>
    
    init(nam: String, nuts: Array<Nutrient>){
        self.name = nam
        self.nutrients = nuts
    }
    
    init(nam: String){
        self.name = nam
        self.nutrients = [Nutrient]()
    }
    
    func add(nutrient: Nutrient) -> Bool{
        self.nutrients.append(nutrient)
        if(self.nutrients.isEmpty){
            return false
        }
        return true
    }
    
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
        for index in 0...(self.nutrients.count-1){
            let a = nutrients[index]
            result = result + a.toString() + "\n"
        }
        return result
    }
    
    
    
}
