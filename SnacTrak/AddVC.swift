//
//  AddVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import TesseractOCR

class AddVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, G8TesseractDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var update: UIButton!
    var done: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //editing and button off until load
        nameText.delegate = self
        textView.delegate = self
        textView.isEditable = false
        update.isEnabled = false
        
        //Looks for single or multiple taps.
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
        
        //Create Tesseract object as constant
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            /*
             tesseract.image -> Currently loads a pre-defined image by name on disk, in the future we can make separate functionality to retrieve a name based reference (e.g selectImage -> returns: imageName) and feed the imageName reference into tesseract.image here.
             */
            tesseract.image = UIImage(named: "demoImage")?.g8_blackAndWhite()
            tesseract.recognize()
            
            /*
             Feed the resulting output of tesseract.recognize() -> tesseract.recognizedText into the text label of the textView object to test output. In the future we can subsitute this with using this data as a parameter for a function to feed data to a database or storage methodic.
             */
            textView.text = tesseract.recognizedText
            
            //turn on editing once done
            textView.isEditable = true
            update.isEnabled = true
            done = true
            
        }
    }
    
    
    /*
     progressImageRecognition -> Debugging print functionality, will be used to track how well the nutrient labels are being recognized, they are fed as 2x , blackAndWhite converted.
     */
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToHome", sender: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        
        if done == true
        {
            //save and add item, back
            if (nameText.text != "")
            {
                let itemToAdd = separate(strin: textView.text)
                array.append(itemToAdd)
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
        
        //do something
        let itemToPrint = separate(strin: textView.text)
        textView2.text = itemToPrint.printAll()
    }
    
    func separate(strin: String) -> FoodItem{
        
        //initialize FoodItem
        let newItem: FoodItem = FoodItem.init(nam: nameText.text!)
        
        //break up translating string by line
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
                    for k in j+1...tokenArray.count - 1
                    {
                        //unit fix
                        var unitless = tokenArray[k].replacingOccurrences(of: "g", with: "")
                        unitless = unitless.replacingOccurrences(of: "m", with: "")
                        //check for number
                        if Int(unitless) != nil
                        {
                            //valid number, add nutrient
                            let newNutrient: Nutrient = Nutrient.init(nam: tokenArray[j], amoun: Int(unitless)!)
                            _ = newItem.add(nutrient: newNutrient)
                            
                        }
                    }
                }
            }
        }
        
        return newItem
    }
    
    
    /*
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
    */

}
