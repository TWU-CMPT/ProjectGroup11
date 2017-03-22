//
//  AddVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan, Nick Miller, and Nikita Nemikin on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import TesseractOCR

class AddVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var servingText: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var update: UIButton!
    var done: Bool = false //check for when tesseract is done translating to safely enable user interaction
    var imageSelected: Bool = false //check whether the user has already selected an image
    var servingValue = "1" //set default serving value
    
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
        
        if imageSelected == false{
            /*
             imageSelection -> Force user to select an image on view load to be able to use it for Tesseract image processing
             */
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            
            
            /*
             actionSheet -> Action sheet for selecting photo from Library , in future -> Add camera selection here as well as a actionsheet.action
             */
            let actionSheet = UIAlertController(title: "Select Image", message: "Choose your image source...", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction)
                in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            //Only present the actionsheet if (UserHasSelectedImage) -> selectedImage == false
            self.present(actionSheet, animated: true, completion: nil)
        }
        
    }

    /*
     imagePickerController -> dictionary functionality for Image Selection, definition and cancelation out of the screen on addPressed
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let outImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageSelected = true
        print("[Debug - HomeVC]  Image Was Selected!")
        picker.dismiss(animated: true, completion: nil)
        
        /*
         TESSERACT IMAGE RECOGNITION - create object, assign image and use the object.recognize() functionality to transpose the image to text
        */
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.image = outImage.g8_blackAndWhite()
            tesseract.recognize()
            /*
             Feed the resulting output of tesseract.recognize() -> tesseract.recognizedText into the text label of the textView object to test output. In the future we can subsitute this with using this data as a parameter for a function to feed data to a database or storage methodic
             */
            textView.text = tesseract.recognizedText            //turn on editing once done
            textView.isEditable = true
            update.isEnabled = true
            done = true
            
        }
        print("[Debug - HomeVC]  Image Was Selected!")
        picker.dismiss(animated: true, completion: nil)
        imageSelected = true                                    //Toggle (UserHasSelectedImage) -> Do not display the actionbar on view return
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        //User cancelled image selection -> Move back to HomeVC.
        performSegue(withIdentifier: "addToHome", sender: nil)
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
                    //add the foodItem to the user data array
                    array.append(itemToAdd)
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
    }
    
    @IBAction func updateWasPressed(_ sender: UIButton) {
        //convert translated text and show in second text view the recognized nutrients for users benefit
        //does not have to be pressed for done button to work
        //seperate feature for user to see what will be recognized and stored
        
        if done == true
        {
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
                //convert translated text into a foodItem
                let itemToPrint = separate(strin: textView.text)
                itemToPrint.serving = Double(servingValue)!
                //output foodItem contents
                textView2.text = "Nutrient Name/Amount Per Serving/Total:\n" + itemToPrint.printAll()
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
        let newItem: FoodItem = FoodItem.init(nam: nameText.text!)
        
        //array of nutrient strings to look for
        let nutrientNames: [String] = ["Calories", "Fat", "Cholesterol", "Sodium", "Carbohydrate", "Fibre", "Sugars", "Protein"]
        var n = 0 //counter to work through nutrient names
        
        //break up translated string by line
        let lineArray = strin.components(separatedBy: "\n")
        for i in 0...lineArray.count - 1
        {
            //break up line by token
            let tokenArray = lineArray[i].components(separatedBy: " ")
            for j in 0...tokenArray.count - 1
            {
                //look for nutrients while not all are yet found
                if(n < 8)
                {
                    var scannedString: String
                    scannedString = tokenArray[j]
                    if ( matchMajority(nutrient: nutrientNames[n], scannedN: scannedString ) )
                    {
                        //set nutrient name
                        let name = nutrientNames[n]
                        //check subsequent tokens on line for a corresponding integer amount
                        let amount = getAmount(tokenArray: tokenArray, j: j)
                        //add nutrient to foodItem if not 0 amount
                        if (amount != 0)
                        {
                            let newNutrient: Nutrient = Nutrient.init(nam: name, amoun: amount)
                            _ = newItem.add(nutrient: newNutrient)
                        }
                        //increment n because nutreintNames[n] has been found
                        n += 1
                        //stop looping once found a nutrient on a line
                        break
                    }
                }
            }
        }
        
        //return foodItem
        return newItem
    }

    //check subsequent tokens on line for a corresponding integer amount
    func getAmount(tokenArray: [String], j: Int) -> Double{
        var amount = ""
        for k in j+1...tokenArray.count - 1
        {
            //recognize integers with attached unit fix
            amount = tokenArray[k].replacingOccurrences(of: "g", with: "")
            amount = amount.replacingOccurrences(of: "m", with: "")
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
        let majority = (nutrient.characters.count) / 2 //50% of letters in String to be scanned
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

    
    func updateGoals(item: FoodItem)
    {
        if goalArray.count > 0
        {
            for i in 0...goalArray.count-1
            {
                for j in 0...item.nutrients.count-1
                {
                    if goalArray[i].nutrient == item.nutrients[j].name
                    {
                        goalArray[i].progress += item.nutrients[j].amount
                    }
                }
            }
        }
    }
    
}
