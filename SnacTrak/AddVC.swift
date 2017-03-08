//
//  AddVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan and Nikita Nemikin on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import TesseractOCR

class AddVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, G8TesseractDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var update: UIButton!
    var done: Bool = false //check for when tesseract is done translating to safely enable user interaction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //editing and button off until load
        nameText.delegate = self
        textView.delegate = self
        textView.isEditable = false
        update.isEnabled = false
        
        //set up for tap gesture to remove keyboard after editing
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //set textView borders
        textView!.layer.borderWidth = 1
        textView!.layer.borderColor = UIColor.gray.cgColor
        textView2!.layer.borderWidth = 1
        textView2!.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //create tesseract object as constant
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            /*
             tesseract.image -> currently loads a pre-defined image by name on disk, in the future we can make separate functionality to retrieve a name based reference (e.g selectImage -> returns: imageName) and feed the imageName reference into tesseract.image here.
             */
            tesseract.image = UIImage(named: "demoImage")?.g8_blackAndWhite()
            tesseract.recognize()
            
            /*
             feed the resulting output of tesseract.recognize() -> tesseract.recognizedText into the text label of the textView object to test output. In the future we can subsitute this with using this data as a parameter for a function to feed data to a database or storage methodic.
             */
            textView.text = tesseract.recognizedText
            
            //turn on editing once done
            textView.isEditable = true
            update.isEnabled = true
            done = true
            
        }
    }
    
    /*
     progressImageRecognition -> debugging print functionality, will be used to track how well the nutrient labels are being recognized, they are fed as 2x , blackAndWhite converted.
     */
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    //xcode generated function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //if tesseract is done conversion
        if done == true
        {
            //if name is entered
            if (nameText.text != "")
            {
                //convert translated text into a foodItem
                let itemToAdd = separate(strin: textView.text)
                //add the foodItem to the user data array
                array.append(itemToAdd)
                //return to home view
                performSegue(withIdentifier: "addToHome", sender: nil)
            }
            //error message if no name
            else
            {
                let alertController = UIAlertController(title: "Error message:", message: "You need to set a name first!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                alertController.view.tintColor = UIColor.red
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func updateWasPressed(_ sender: UIButton) {
        //convert translated text and show in second text view the recognized nutrients for users benefit
        //does not have to be pressed for done to work
        //seperate feature for user to see what will be recognized and stored
        let itemToPrint = separate(strin: textView.text)
        textView2.text = itemToPrint.printAll()
    }
    
    func separate(strin: String) -> FoodItem{
        
        //initialize a foodItem
        let newItem: FoodItem = FoodItem.init(nam: nameText.text!)
        
        //break up translated string by line
        let lineArray = strin.components(separatedBy: "\n")
        for i in 0...lineArray.count - 1
        {
            //break up line by token
            let tokenArray = lineArray[i].components(separatedBy: " ")
            for j in 0...tokenArray.count - 1
            {
                //find key nutrient
                if ( tokenArray[j].lowercased().contains("fat") || tokenArray[j].lowercased().contains("sodium") || tokenArray[j].lowercased().contains("carbohydrate") || tokenArray[j].lowercased().contains("protein") )
                {
                    //check subsequent tokens on line for a corresponding integer amount
                    for k in j+1...tokenArray.count - 1
                    {
                        //recognize integers with attached unit fix
                        var unitless = tokenArray[k].replacingOccurrences(of: "g", with: "")
                        unitless = unitless.replacingOccurrences(of: "m", with: "")
                        //check for valid number
                        if Int(unitless) != nil
                        {
                            //add nutrient to foodItem
                            let newNutrient: Nutrient = Nutrient.init(nam: tokenArray[j], amoun: Int(unitless)!)
                            _ = newItem.add(nutrient: newNutrient)
                            
                        }
                    }
                }
            }
        }
        
        //return foodItem
        return newItem
    }
    
    
    //potential algorithm being developed to improve regconition
    //not implemented as of version 1
    /*
     //finds out if 2 strings have a majority of matching characters
     //returns: Boolean
     func matchMajority(nutrient: String, scannedN: String) -> Bool{
     var numMatched = 0                                  //counter for characters matched
     let majority = (nutrient.characters.count) / 2      //50% of letters in String to be scanned
     var count: Int                                      //the number of letters to scan through
     
     //find out which word is the smaller one
     if(nutrient.characters.count < scannedN.characters.count){
     count = nutrient.characters.count
     }
     else{
     count = scannedN.characters.count
     }
     
     var aa = Array(nutrient.uppercased().characters)         //turn Strings into array of chars cuz Swift is annoying
     var ba = Array(scannedN.uppercased().characters)         //also make sure both are upper cased
     
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
    */

}
