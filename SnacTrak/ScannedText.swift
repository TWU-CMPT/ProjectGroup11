//
//  ScannedText.swift
//  SnacTrak
//
//  Created by Nick Miller on 2017-03-04.
//  Copyright © 2017 Nick Miller. All rights reserved.
//

class ScannedText{
    var text: String
    
    init(txt: String){
        self.text = txt
    }
    
    
    func separate() -> FoodItem{
        //do{
        //    self.text = txt.components(separatedBy: .newlines))   // Swift is annoying
        //}catch{
        //    print(error)
        //}
        //separate text into array w/ each element containing line
        //separate this line into sparate array
        //check if element contains "servings" (important as we need to multiply nutrient values by this #)
        //skip over rest of elements for this line until one w/ an integer is reached
             //most labels in Canada have French so we have to skip over any other Strings
             //ie. Common Format is "Sugar / Sucre 25g" so we have to skip the French
        //assign servings int this value 
                //(we might be better off with allowing user input for servings, as some have different wording)
        // call matchMajority func with arguments "Calories" and first element of next new line array
        // if returns true -> create new nutrient with numeric value a few spaces over
        // repeat in pattern on most labels
        
        // Note: make sure to use the same array variable for the the inner line arrays so its less memory intensive
        
        // Will also need to handle the case where the 1st element of an inner line array returns false
             // perhaps save it as a nutrient anyway and let user correct it on confirmation screen?
        
        
        
        //test classes
        let result: FoodItem = FoodItem.init(nam: "name")
        
        return result
    }
    
    //Finds out if 2 strings have a majority of matching characters
    //Returns: Boolean
    func matchMajority(nutrient: String, scannedN: String) -> Bool{
        var numMatched = 0                                  // counter for characters matched
        let majority = (nutrient.characters.count) / 2      // 50% of letters in String to be scanned
        var count: Int                                      // the number of letters to scan through
        
        // Find out which word is the smaller one
        if(nutrient.characters.count < scannedN.characters.count){
            count = nutrient.characters.count
        }
        else{
            count = scannedN.characters.count
        }
        
        var aa = Array(nutrient.uppercased().characters)         //Turn Strings into array of chars cuz Swift is annoying
        var ba = Array(scannedN.uppercased().characters)         // also make sure both are upper cased
        
        //search through each letter
        for index in 0...count{
        
            let a = aa[index]
            let b = ba[index]
            
            if (a == b){
                numMatched += 1                            //increment if letters match
            }
        }
        if(numMatched >= majority){
            return true
        }
        else {
            return false
        }
    }
    
    
}
