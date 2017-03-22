//
//  Goal.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-21.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import Foundation

class Goal{
    //attributes
    
    var nutrient: String
    var amount: Double
    var completedBy: Date
    var progress: Double
    
    //methods
    
    //initialize goal
    init(nut: String, amoun: Double, date: Date){
        self.nutrient = nut
        self.amount = amoun
        self.completedBy = date
        self.progress = 0
    }
    
    //convert goal to string
    func toString() -> String{
        let result = String(self.amount) + "g of " + self.nutrient
        return result
    }
    
}
