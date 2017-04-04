//
//  AddGoalVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-21.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData

class AddGoalVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nutrientPicker: UIPickerView!
    @IBOutlet weak var amountGiven: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //array to populate picker view
    let nutrients = ["Calories (g)", "Calcium (%)", "Carbohydrate (g)", "Cholesterol (mg)", "Fat (g)", "Fibre (g)", "Iron (%)", "Potassium (mg)", "Protein (g)", "Sodium (mg)", "Sugars (g)", "Vitamin A (%)", "Vitamin C (%)"]
    //array to get name
    let nutrientNames = ["Calories", "Calcium", "Carbohydrate", "Cholesterol", "Fat", "Fibre", "Iron", "Potassium", "Protein", "Sodium", "Sugars", "Vitamin A", "Vitamin C"]
    //default picker position
    var pickerRow = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set picker view starting row
        nutrientPicker.selectRow(6, inComponent: 0, animated: true)
        //limit date picker range
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        //set up for tap gesture and return key to end editing
        amountGiven.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //function for tap gesture
    func dismissKeyboard() {
        view.endEditing(true)
    }
    //when editing amount return key will dismiss keyboard
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
            //create goal
            let entityGoal = NSEntityDescription.entity(forEntityName: "Goal", in: managedObjectContext)
            let newGoal = NSManagedObject(entity: entityGoal!, insertInto: managedObjectContext) as! Goal
            newGoal.nutrient = nutrientNames[pickerRow]
            newGoal.amount = Double(amountGiven.text!)!
            newGoal.completedBy = datePicker.date as NSDate?
            //add goal
            do {
                try managedObjectContext.save()
                goalArray.append(newGoal)
            }
            catch {
                print("goal add error")
            }
            //return to goals view
            performSegue(withIdentifier: "addToGoals", sender: nil)
        }
    }
    
}
