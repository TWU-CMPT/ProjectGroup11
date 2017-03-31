//
//  AddVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan, Nick Miller, and Nikita Nemikin on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData
import TesseractOCR

class AddVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var servingText: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var update: UIButton!
    var imageSelected: Bool = false //check whether the user has already selected an image
    var servingValue = "1" //set default serving value
    var imageToRecognize: UIImage? = nil //image for tesseract
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set up for tap gesture and return key to end editing
        nameText.delegate = self
        servingText.delegate = self
        textView.delegate = self
        textView.isEditable = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //set textView borders
        textView!.layer.borderWidth = 1
        textView!.layer.borderColor = UIColor.gray.cgColor
        textView2!.layer.borderWidth = 1
        textView2!.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set up selection menu
        if imageSelected == false {
            //set up photo library option
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.navigationBar.tintColor = .red
            
            //set up action sheet
            let actionSheet = UIAlertController(title: "Add Options Menu", message: "Choose your information source...", preferredStyle: .actionSheet)
            actionSheet.view.tintColor = UIColor.red
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
                //redirect to camera
            }))
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
                //present photo library
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            actionSheet.addAction(UIAlertAction(title: "Manual Entry", style: .default, handler: {(action:UIAlertAction) in
                //Get rid of loading text and dismiss action sheet
                self.textView.text = "Calories 0g\nFat 0g\nCholesterol 0mg\nSodium 0mg\nCarbohydrate 0g\nFibre 0g\nSugars 0g\nProtein 0g\nVitamin A 0%\nVitamin C 0%\nCalcium 0%\nIron 0%\nPotassium 0mg\n"
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action:UIAlertAction) in
                //return to home view
                self.performSegue(withIdentifier: "addToHome", sender: nil)
            }))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageSelected == true
        {
            //translate image to text
            if let tesseract = G8Tesseract(language: "eng") {
                tesseract.delegate = self
                tesseract.image = imageToRecognize?.g8_blackAndWhite()
                tesseract.recognize()
                //ouput recognized text to view
                textView.text = tesseract.recognizedText
            }
        }
    }

    //imagePickerController functions to select image from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //set image variables
        imageToRecognize = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageSelected = true
        //dismiss picker and back to add screen
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss picker and back to add screen menu
        picker.dismiss(animated: true, completion: nil)
    }
    
    //ouput recognition progress
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    //function for tap gesture
    func dismissKeyboard() {
        view.endEditing(true)
    }
    //when editing name return key will dismiss keyboard, tap gesture also works
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        //dont add anything and return to home view
        performSegue(withIdentifier: "addToHome", sender: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        //change serving value if necessary
        if (servingText.text != "")
        {
            servingValue = servingText.text!
        }
        else
        {
            servingValue = "1"
        }
        
        //if name is entered
        if (nameText.text != "")
        {
            //if incorrect serving input
            if ((Double(servingValue) == nil) || (Double(servingValue)! < 1))
            {
                errorMessage(messag: "Invalid serving input!")
            }
            else
            {
                //convert translated text into a foodItem
                let itemToAdd = separate(strin: textView.text)
                itemToAdd.serving = Double(servingValue)!
                
                //add foodItem
                do {
                    try managedObjectContext.save()
                    array.append(itemToAdd)
                }
                catch{
                    print("foodItem add error")
                }

                //update appropriate goal progress
                updateGoals(item: itemToAdd)

                //return to home view
                performSegue(withIdentifier: "addToHome", sender: nil)
            }
        }
        //error message if no name
        else
        {
            errorMessage(messag: "You need to set a name first!")
        }
    }
    
    @IBAction func updateWasPressed(_ sender: UIButton) {
        //change serving value if necessary
        if (servingText.text != "")
        {
            servingValue = servingText.text!
        }
        else
        {
            servingValue = "1"
        }
        
        //if incorrect serving input
        if ((Double(servingValue) == nil) || (Double(servingValue)! < 1))
        {
            errorMessage(messag: "Invalid serving input!")
        }
        else
        {
            //convert translated text into a temporary foodItem
            let itemToPrint = separate(strin: textView.text)
            itemToPrint.serving = Double(servingValue)!
            //output foodItem contents
            textView2.text = itemToPrint.printAll()
            //delete foodItem
            do {
                managedObjectContext.delete(itemToPrint)
                try managedObjectContext.save()
            }
            catch{
                print("foodItem delete error")
            }
        }
    }
    
    //pop-up error message
    func errorMessage(messag: String)
    {
        let alertController = UIAlertController(title: "Error message:", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        alertController.view.tintColor = UIColor.red
        self.present(alertController, animated: true, completion: nil)
    }
    
    //convert translated text into a foodItem
    func separate(strin: String) -> FoodItem{
        
        //initialize a foodItem
        let entityFoodItem = NSEntityDescription.entity(forEntityName: "FoodItem", in: managedObjectContext)
        let newItem = NSManagedObject(entity: entityFoodItem!, insertInto: managedObjectContext) as! FoodItem
        newItem.name = nameText.text!
        newItem.date = NSDate()
        
        //array of nutrient strings to look for
        let nutrientNames: [String] = ["Calories", "Fat", "Cholesterol", "Sodium", "Carbohydrate", "Fibre", "Sugars", "Protein", "Vitamin A", "Vitamin C", "Calcium", "Iron", "Potassium"]
        var n = 0
        
        // array of bools to indicate if nutrient was found
        var found: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false]
        
        // array of bools to indicate if nutrient has been previously searched for
        // this is so the algorithm does not continue to look for a nutrient that is not present in input
        var prevSearched: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false]
        var name: String
        repeat
        {
            //set n to equal nutrient not yet found (will begin at 0 initially)
            n = findNotFound(foundArray: found)
            if( n == 99){
                break
            }
            
            if(n < 13)
            {
                // if nutrient has been previously searched for
                if(prevSearched[n] == true)
                {
                    //Set to indicate that it doesnt exist in input
                    found[n] = true
                    //Reset n to equal next not found nutrient
                    n = findNotFound(foundArray: found)
                    if( n == 99){
                        break
                    }                }
                //Set new n to indicate it has been previously searched for
                prevSearched[n] = true
            }
            
            //break up translated string by line
            let lineArray = strin.components(separatedBy: "\n")
            for i in 0...lineArray.count - 1
            {
                //break up line by token
                let tokenArray = lineArray[i].components(separatedBy: " ")
                for j in 0...tokenArray.count - 1
                {
                    //look for nutrients while not all are yet found
                    if(n < 13)
                    {
                        var scannedString: String
                        
                        scannedString = tokenArray[j]
                        //if the majority of letters match current nutrient & nutrient has not already been found
                        if (( matchMajority(nutrient: nutrientNames[n], scannedN: scannedString )) && (found[n] == false ))
                        {
                            // if current nutrient is "Vitamin A" or "C"
                            if((n == 8) || (n == 9)){
                                // Get letter at next element
                                scannedString = tokenArray[j + 1]
                                if( n == 8 && matchMajority(nutrient: "A", scannedN: scannedString)){
                                    name = nutrientNames[n]
                                }
                                if( n == 9 && matchMajority(nutrient: "C", scannedN: scannedString)){
                                    name = nutrientNames[n]
                                }
                                else{
                                    n += 1
                                    break
                                }
                            }
                            
                            //set nutrient name
                            name = nutrientNames[n]
                            
                            //check subsequent tokens on line for a corresponding integer amount
                            let amount = getAmount(tokenArray: tokenArray, j: j)
                            
                            // set bool to indicate nutrient was found
                            found[n] = true
                            
                            //add nutrient to foodItem if not 0 amount
                            if (amount != 0)
                            {
                                let entityNutrient = NSEntityDescription.entity(forEntityName: "Nutrient", in: managedObjectContext)
                                let newNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
                                newNutrient.name = name
                                newNutrient.amount = amount
                                newItem.addToNutrients(newNutrient)
                            }
                            //increment n because nutreintNames[n] has been found
                            n += 1
                            //stop looping once found a nutrient on a line
                            if(n < 8)
                            {
                                break
                            }
                        }
                        
                    }
                }
            }
        }while( n < 99) //if n is 99 then all nutrients that are present are found
        
        return newItem
    }
    
    //Finds the element of a nutrient that has not yet been found
    func findNotFound(foundArray: [Bool]) -> Int{
        
        for index in 0...foundArray.count - 1
        {
            let fnd = foundArray[index]
            //check if current nutrient has been set to found
            if(fnd == false){
                return index
            }
        }
        //return 99 if all nutrients have been found
        return 99
    }
    
    //check subsequent tokens on line for a corresponding integer amount
    func getAmount(tokenArray: [String], j: Int) -> Double{
        var amount = ""
        for k in j+1...tokenArray.count - 1
        {
            //recognize integers with attached unit fix
            amount = tokenArray[k].replacingOccurrences(of: "g", with: "")
            amount = amount.replacingOccurrences(of: "m", with: "")
            amount = amount.replacingOccurrences(of: "%", with: "")
            // if tesseract mistook 0g for "09"
            if(amount == "09"){
                return 0
            }
                //check for valid number
            else if Double(amount) != nil
            {
                return Double(amount)!
            }
        }
        return 0
    }
    
    //finds out if 2 strings have a majority of matching characters
    func matchMajority(nutrient: String, scannedN: String) -> Bool{
        var numMatched = 0 //counter for characters matched
        var majority: Int
        
        //if nutrient is one of these then extra characters are required to ensure they are correct
        if(nutrient == "Fat" || nutrient == "Calcium"){
            majority = ((nutrient.characters.count) / 2) + 1
        }
        else{
            majority = (nutrient.characters.count) / 2 //50% of letters in String to be scanned
        }
        var count: Int //the number of letters to scan through
        
        //find out which word is the smaller one
        if(nutrient.characters.count < scannedN.characters.count){
            count = nutrient.characters.count
        }
        else{
            count = scannedN.characters.count
        }
        
        //turn Strings into array of chars
        var aa = Array(nutrient.uppercased().characters)
        var ba = Array(scannedN.uppercased().characters)
        
        if(count > 0){  
            //search through each letter
            for index in 0...count - 1{
                var a: Character
                var b: Character

                a = aa[index]
                b = ba[index]

                if (a == b){
                    //increment if letters match
                    numMatched += 1
                }
            }
        }
        if(numMatched >= majority){
            return true
        }
        else {
            return false
        }
    }

    //update goal progress amount
    func updateGoals(item: FoodItem)
    {
        //if there are goals
        if goalArray.count > 0
        {
            for i in 0...goalArray.count-1
            {
                let nutArray = Array(item.nutrients)
                if nutArray.count > 0
                {
                    for j in 0...nutArray.count-1
                    {
                        //if a nutrient in current food item is the goal nutrient
                        if goalArray[i].nutrient == nutArray[j].name
                        {
                            //update progress amount
                            goalArray[i].progress += nutArray[j].amount * item.serving
                        }
                    }
                }
            }
        }
    }
    
}
