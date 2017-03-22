//
//  AddGoalVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-21.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class AddGoalVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nutrientPicker: UIPickerView!
    @IBOutlet weak var amountGiven: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //array to populate picker view
    var nutrients = ["Calories", "Carbohydrate", "Cholesterol", "Fat", "Fibre", "Protein", "Sodium", "Sugars"]
    var pickerRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set picker view starting row
        nutrientPicker.selectRow(3, inComponent: 0, animated: true)
        //limit date picker range
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        
        //set up for tap gesture and return key to end editing
        amountGiven.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function for tap gesture
    func dismissKeyboard() {
        view.endEditing(true)
    }
    //when editing amount return key will dismiss keyboard, tap gesture also works
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    //nutrient picker view functions
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nutrients[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nutrients.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRow = row
    }
    
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        //dont add anything and return to goals view
        performSegue(withIdentifier: "addToGoals", sender: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {

        //if incorrect amount input
        if ((Double(amountGiven.text!) == nil) || (Double(amountGiven.text!)! < 1))
        {
            let alertController = UIAlertController(title: "Error message:", message: "Invalid amount input!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            alertController.view.tintColor = UIColor.red
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //add goal
            let nutrient = nutrients[pickerRow]
            let amount = amountGiven.text
            let completedBy = datePicker.date
            let newGoal: Goal = Goal.init(nut: nutrient, amoun: Double(amount!)!, date: completedBy)
            goalArray.append(newGoal)
            //return to goals view
            performSegue(withIdentifier: "addToGoals", sender: nil)
            
        }
    }
}
