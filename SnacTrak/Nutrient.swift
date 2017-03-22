//
//  Nutrient.swift
//  SnacTrak
//
//  Created by Nick Miller and Brittany Ryan on 2017-03-02.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

class Nutrient{
    //attributes
    
    var name: String
    var amount: Double
    
    //methods
    
    //initialize nutrient
    init(nam: String, amoun: Double){
        self.name = nam
        self.amount = amoun
    }
    
    //check if nutrients are equal
    func equalTo(nam: String) -> Bool{
        if(nam.uppercased() == self.name.uppercased()){
        return true
        }
        else{
        return false
        }
    }
    
    //convert nutrient to string
    func toString() -> String{
        let result = self.name + " " + String(self.amount)
        return result
    }
    
}
