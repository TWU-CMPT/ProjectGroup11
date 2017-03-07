//
//  AddVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import TesseractOCR   //Tesseract OCR Framework import statement

class AddVC: UIViewController, G8TesseractDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //Create Tesseract object as constant
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            /*
             tesseract.image -> Currently loads a pre-defined image by name on disk, in the future we can make separate functionality to retrieve a name based reference (e.g selectImage -> returns: imageName) and feed the imageName reference into tesseract.image here.
             */
            tesseract.image = UIImage(named: "demoImage2")?.g8_blackAndWhite()
            tesseract.recognize()
            
            
            /*
             Feed the resulting output of tesseract.recognize() -> tesseract.recognizedText into the text label of the textView object to test output. In the future we can subsitute this with using this data as a parameter for a function to feed data to a database or storage methodic.
             */
            separate(strin: tesseract.recognizedText)
            textView.text = tesseract.recognizedText
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
    
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToHome", sender: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        //save and add item, back
        testClasses()
        performSegue(withIdentifier: "addToHome", sender: nil)
    }
    
    func testClasses() {
        
        //test classes
        let newItem: FoodItem = FoodItem.init(nam: "Granola Bar")
        let newNutrient: Nutrient = Nutrient.init(nam: "fiber",amoun: 2)
        let otherNutrient: Nutrient = Nutrient.init(nam: "protein",amoun: 5)
        _ = newItem.add(nutrient: newNutrient)
        _ = newItem.add(nutrient: otherNutrient)
        print(newItem.printAll())
        
        array.append(newItem)
        
    }
    
    func separate(strin: String) {
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
        //let result: FoodItem = FoodItem.init(nam: "name")
        //return result
    }


}
