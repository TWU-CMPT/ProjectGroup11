//
//  ViewController.swift
//  SnakTrak v1.0
//
//  Created by Nik Nem on 2017-03-02.
//  Copyright © 2017 CMPT276-Group11. All rights reserved.
//

import UIKit
import TesseractOCR   //Tesseract OCR Framework import statement

class ViewController: UIViewController, G8TesseractDelegate {

    //Initialize textView outlet
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Tesseract object as constant
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            /*
             tesseract.image -> Currently loads a pre-defined image by name on disk, in the future we can make separate functionality to retrieve a name based reference (e.g selectImage -> returns: imageName) and feed the imageName reference into tesseract.image here.
            */
            tesseract.image = UIImage(named: "demoImage3")?.g8_blackAndWhite()
            tesseract.recognize()
            
            
            /*
             Feed the resulting output of tesseract.recognize() -> tesseract.recognizedText into the text label of the textView object to test output. In the future we can subsitute this with using this data as a parameter for a function to feed data to a database or storage methodic.
             */
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


}

