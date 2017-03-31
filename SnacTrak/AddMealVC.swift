//
//  AddMealVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-30.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData

class AddMealVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    //initializing date formatter
    let formatter = DateFormatter()
    //array of nutrient names corresponding to totalsToAdd
    let nutrientNames = ["Calories", "Fat", "Cholesterol", "Sodium", "Carbohydrate", "Fibre", "Sugars", "Protein", "Vitamin A", "Vitamin C", "Calcium", "Iron"]
    //array of nutrient amount totals corresponding to nutrientNames
    var totalsToAdd = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    //array to hold names of selected food items
    var itemsToAdd = [String]()
    //array to keep track of selected cells
    var selectedCells = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set date format
        formatter.dateFormat = "MM-dd-yyyy"
        
        //allow for multiplec cell selection
        myTable.allowsMultipleSelection = true
        
        //initialize selection array
        if array.count > 0
        {
            for _ in 0...array.count-1
            {
                selectedCells.append(false)
            }
        }
        
        //set up for return key to end editing
        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when editing name return key will dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        //dont add anything and return to meals view
        performSegue(withIdentifier: "addToMeals", sender: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        
        //if name is entered
        if (textField.text != "")
        {
            //create meal
            let entityMeal = NSEntityDescription.entity(forEntityName: "Meal", in: managedObjectContext)
            let newMeal = NSManagedObject(entity: entityMeal!, insertInto: managedObjectContext) as! Meal
            //set name
            newMeal.name = textField.text
            //update itemsToAdd and totalsToAdd
            if selectedCells.count > 0
            {
                for i in 0...selectedCells.count-1
                {
                    if selectedCells[i] == true
                    {
                        //add selected fooditem names to itemsToAdd
                        itemsToAdd.append(array[i].name!)
                        
                        //add selected fooditem nutrient amount to totalsToAdd
                        let nutArray = Array(array[i].nutrients)
                        if nutArray.count > 0
                        {
                            for j in 0...nutArray.count-1
                            {
                                for k in 0...nutrientNames.count-1
                                {
                                    if nutrientNames[k] == nutArray[j].name
                                    {
                                        totalsToAdd[k] += nutArray[j].amount * array[i].serving
                                        break
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            //set itemNames and totals
            newMeal.itemNames = itemsToAdd
            newMeal.totals = totalsToAdd
            
            //add meal
            do {
                try managedObjectContext.save()
                mealArray.append(newMeal)
            }
            catch{
                print("error")
            }
            
            //return to meals view
            performSegue(withIdentifier: "addToMeals", sender: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Error message:", message: "You need to set a name first!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            alertController.view.tintColor = UIColor.red
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(array.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = array[indexPath.row].name
        cell.detailTextLabel?.text = "Date added: " + formatter.string(from: array[indexPath.row].date as! Date)
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedCells[indexPath.row] = true
    
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        selectedCells[indexPath.row] = false
    }
    
}
