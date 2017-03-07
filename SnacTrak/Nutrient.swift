//
//  Nutrient.swift
//  SnacTrak
//
//  Created by Nick Miller on 2017-03-02.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

class Nutrient{
    var name: String
    var amount: Int
    
    init(nam: String, amoun: Int){
        self.name = nam
        self.amount = amoun
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
        let result = self.name + " " + String(self.amount)
        return result
    }
    
    
    
}
