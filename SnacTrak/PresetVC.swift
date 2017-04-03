//
//  PresetVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-04-02.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class PresetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    
    
    var itemSelected = false
    var selectedCell = -1
    var selectedSection = -1
    var name: String = ""
    var info: String = ""
    
    struct Presets {
        var sectionName: String!
        var sectionPresets: [String]!
    }
    var tableArray = [Presets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tint back button red
        self.navigationController?.navigationBar.tintColor = UIColor.red;
        
        tableArray = [Presets(sectionName: "Raw Fruits:", sectionPresets: ["Apple","Avocado","Banana","Cantaloupe","Grapefruit","Grapes","Honeydew Melon","Kiwifruit","Lemon","Lime","Nectarine","Orange","Peach","Pear","Pineapple","Plums","Strawberries","Sweet Cherries", "Tangerine","Watermelon"]),Presets(sectionName: "Raw Vegetables:", sectionPresets: ["Asparagus","Bell Pepper","Broccoli","Carrot","Cauliflower","Celery","Cucumber","Green (Snap) Beans","Green Cabbage","Green Onion","Iceberg Lettuce","Leaf Lettuce","Mushrooms","Onion","Potato","Radishes","Summer Squash","Sweet Corn","Sweet Potato","Tomato"])]
    }

    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        if selectedCell == -1
        {
            let alertController = UIAlertController(title: "Error message:", message: "You need to select an item first!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            alertController.view.tintColor = UIColor.red
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //set item details based on selected
            itemSelected = true
            name = tableArray[selectedSection].sectionPresets[selectedCell]
            switch(selectedSection)
            {
            case 0:
                //fruits
                switch(selectedCell)
                {
                case 0:
                    info += "Per 1 large (242g)\n"
                    info += "Calories 130g\nCarbohydrate 34g\nFibre 5g\nSugars 25g\nProtein 1g\nVitamin A 2%\nVitamin C 8%\nCalcium 2%\nIron 2%\nPotassium 260mg\n"
                case 1:
                    info += "Per 1/5 medium (30g)\n"
                    info += "Calories 50g\nFat 4.5g\nCarbohydrate 3g\nFibre 1g\nProtein 1g\nVitamin C 4%\nIron 2%\nPotassium 140mg\n"
                case 2:
                    info += "Per 1 medium (126g)\n"
                    info += "Calories 110g\nCarbohydrate 30g\nFibre 3g\nSugars 19g\nProtein 1g\nVitamin A 2%\nVitamin C 15%\nIron 2%\nPotassium 450mg\n"
                case 3:
                    info += "Per 1/4 medium (134g)\n"
                    info += "Calories 50g\nSodium 20mg\nCarbohydrate 12g\nFibre 1g\nSugars 11g\nProtein 1g\nVitamin A 120%\nVitamin C 80%\nCalcium 2%\nIron 2%\nPotassium 240mg\n"
                case 4:
                    info += "Per 1/2 medium (154g)\n"
                    info += "Calories 60g\nCarbohydrate 15g\nFibre 2g\nSugars 11g\nProtein 1g\nVitamin A 35%\nVitamin C 100%\nCalcium 4%\nPotassium 160mg\n"
                case 5:
                    info += "Per 3/4 cup (126g)\n"
                    info += "Calories 90g\nSodium 15mg\nCarbohydrate 23g\nFibre 1g\nSugars 20g\nVitamin C 2%\nCalcium 2%\nPotassium 240mg\n"
                case 6:
                    info += "Per 1/10 medium melon (134g)\n"
                    info += "Calories 50g\nSodium 30mg\nCarbohydrate 12g\nFibre 1g\nSugars 11g\nProtein 1g\nVitamin A 2%\nVitamin C 45%\nCalcium 2%\nIron 2%\nPotassium 210mg\n"
                case 7:
                    info += "Per 2 medium (148g)\n"
                    info += "Calories 90g\nFat 1g\nCarbohydrate 20g\nFibre 4g\nSugars 13g\nProtein 1g\nVitamin A 2%\nVitamin C 240%\nCalcium 4%\nIron 2%\nPotassium 450mg\n"
                case 8:
                    info += "Per 1 medium (58g)\n"
                    info += "Calories 15g\nCarbohydrate 5g\nFibre 2g\nSugars 2g\nVitamin C 40%\nCalcium 2%\nPotassium 75mg\n"
                case 9:
                    info += "Per 1 medium (67g)\n"
                    info += "Calories 20g\nCarbohydrate 7g\nFibre 2g\nVitamin C 35%\nPotassium 75mg\n"
                case 10:
                    info += "Per 1 medium (140g)\n"
                    info += "Calories 60g\nFat 0.5g\nCarbohydrate 15g\nFibre 2g\nSugars 11g\nProtein 1g\nVitamin A 8%\nVitamin C 15%\nIron 2%\nPotassium 250mg\n"
                case 11:
                    info += "Per 1 medium (154g)\n"
                    info += "Calories 80g\nCarbohydrate 19g\nFibre 3g\nSugars 14g\nProtein 1g\nVitamin A 2%\nVitamin C 130%\nCalcium 6%\nPotassium 250mg\n"
                case 12:
                    info += "Per 1 medium (147g)\n"
                    info += "Calories 60g\nFat 0.5g\nCarbohydrate 15g\nFibre 2g\nSugars 13g\nProtein 1g\nVitamin A 6%\nVitamin C 15%\nIron 2%\nPotassium 230mg\n"
                case 13:
                    info += "Per 1 medium (166g)\n"
                    info += "Calories 100g\nCarbohydrate 26g\nFibre 6g\nSugars 16g\nProtein 1g\nVitamin C 10%\nCalcium 2%\nPotassium 190mg\n"
                case 14:
                    info += "Per 2 slices 3\" diameter, 3/4\" thick (112g)\n"
                    info += "Calories 50g\nSodium 10mg\nCarbohydrate 13g\nFibre 1g\nSugars 10g\nProtein 1g\nVitamin A 2%\nVitamin C 50%\nCalcium 2%\nIron 2%\nPotassium 120mg\n"
                case 15:
                    info += "Per 2 medium (151g)\n"
                    info += "Calories 70g\nCarbohydrate 19g\nFibre 2g\nSugars 16g\nProtein 1g\nVitamin A 8%\nVitamin C 10%\nIron 2%\nPotassium 230mg\n"
                case 16:
                    info += "Per 8 medium (147g)\n"
                    info += "Calories 50g\nCarbohydrate 11g\nFibre 2g\nSugars 8g\nProtein 1g\nVitamin C 160%\nCalcium 2%\nIron 2%\nPotassium 170mg\n"
                case 17:
                    info += "Per 21 cherries; 1 cup (140g)\n"
                    info += "Calories 100g\nCarbohydrate 26g\nFibre 1g\nSugars 16g\nProtein 1g\nVitamin A 2%\nVitamin C 15%\nCalcium 2%\nIron 2%\nPotassium 350mg\n"
                case 18:
                    info += "Per 1 medium (109g)\n"
                    info += "Calories 50g\nCarbohydrate 13g\nFibre 2g\nSugars 9g\nProtein 1g\nVitamin A 6%\nVitamin C 45%\nCalcium 4%\nPotassium 160mg\n"
                case 19:
                    info += "Per 1/8 medium melon; 2 cups diced pieces (280g)\n"
                    info += "Calories 80g\nCarbohydrate 21g\nFibre 1g\nSugars 20g\nProtein 1g\nVitamin A 30%\nVitamin C 25%\nCalcium 2%\nIron 4%\nPotassium 270mg\n"
                default:
                    print("error in fruits switch case")
                }
            case 1:
                //vegetables
                switch(selectedCell)
                {
                case 0:
                    info += "Per 5 spears (93g)\n"
                    info += "Calories 20g\nCarbohydrate 4g\nFibre 2g\nSugars 2g\nProtein 2g\nVitamin A 10%\nVitamin C 15%\nCalcium 2%\nIron 2%\nPotassium 230mg\n"
                case 1:
                    info += "Per 1 medium (148g)\n"
                    info += "Calories 25g\nSodium 40mg\nCarbohydrate 6g\nFibre 2g\nSugars 4g\nProtein 1g\nVitamin A 4%\nVitamin C 190%\nCalcium 2%\nIron 4%\nPotassium 220mg\n"
                case 2:
                    info += "Per 1 medium stalk (148g)\n"
                    info += "Calories 45g\nFat 0.5g\nSodium 80mg\nCarbohydrate 8g\nFibre 3g\nSugars 2g\nProtein 4g\nVitamin A 6%\nVitamin C 220%\nCalcium 6%\nIron 6%\nPotassium 460mg\n"
                case 3:
                    info += "Per 1 carrot, 7\" long, 1 1/4\" diameter (78g)\n"
                    info += "Calories 30g\nSodium 60mg\nCarbohydrate 7g\nFibre 2g\nSugars 5g\nProtein 1g\nVitamin A 110%\nVitamin C 10%\nCalcium 2%\nIron 2%\nPotassium 250mg\n"
                case 4:
                    info += "Per 1/6 medium head (99g)\n"
                    info += "Calories 25g\nSodium 30mg\nCarbohydrate 5g\nFibre 2g\nSugars 2g\nProtein 2g\nVitamin C 100%\nCalcium 2%\nIron 2%\nPotassium 270mg\n"
                case 5:
                    info += "Per 2 medium stalks (110g)\n"
                    info += "Calories 15g\nSodium 115mg\nCarbohydrate 4g\nFibre 2g\nSugars 2g\nVitamin A 10%\nVitamin C 15%\nCalcium 4%\nIron 2%\nPotassium 260mg\n"
                case 6:
                    info += "Per 1/3 medium (99g)\n"
                    info += "Calories 10g\nCarbohydrate 2g\nFibre 1g\nSugars 1g\nProtein 1g\nVitamin A 4%\nVitamin C 10%\nCalcium 2%\nIron 2%\nPotassium 140mg\n"
                case 7:
                    info += "Per 3/4 cup cut (83g)\n"
                    info += "Calories 20g\nCarbohydrate 5g\nFibre 3g\nSugars 2g\nProtein 1g\nVitamin A 4%\nVitamin C 10%\nCalcium 4%\nIron 2%\nPotassium 200mg\n"
                case 8:
                    info += "Per 1/12 medium head (84g)\n"
                    info += "Calories 25g\nSodium 20mg\nCarbohydrate 5g\nFibre 2g\nSugars 3g\nProtein 1g\nVitamin C 70%\nCalcium 4%\nIron 2%\nPotassium 190mg\n"
                case 9:
                    info += "Per 1/4 cup chopped (25g)\n"
                    info += "Calories 10g\nSodium 10mg\nCarbohydrate 2g\nFibre 1g\nSugars 1g\nVitamin A 2%\nVitamin C 8%\nCalcium 2%\nIron 2%\nPotassium 70mg\n"
                case 10:
                    info += "Per 1/6 medium head (89g)\n"
                    info += "Calories 10g\nSodium 10mg\nCarbohydrate 2g\nFibre 1g\nSugars 2g\nProtein 1g\nVitamin A 6%\nVitamin C 6%\nCalcium 2%\nIron 2%\nPotassium 125mg\n"
                case 11:
                    info += "Per 1 1/2 cups shredded (85g)\n"
                    info += "Calories 15g\nSodium 35mg\nCarbohydrate 2g\nFibre 1g\nSugars 1g\nProtein 1g\nVitamin A 130%\nVitamin C 6%\nCalcium 2%\nIron 4%\nPotassium 170mg\n"
                case 12:
                    info += "Per 5 medium (84g)\n"
                    info += "Calories 20g\nSodium 15mg\nCarbohydrate 3g\nFibre 1g\nProtein 3g\nVitamin C 2%\nIron 2%\nPotassium 300mg\n"
                case 13:
                    info += "Per 1 medium (148g)\n"
                    info += "Calories 45g\nSodium 5mg\nCarbohydrate 11g\nFibre 3g\nSugars 9g\nProtein 1g\nVitamin C 20%\nCalcium 4%\nIron 4%\nPotassium 190mg\n"
                case 14:
                    info += "Per 1 medium (148g)\n"
                    info += "Calories 110g\nCarbohydrate 26g\nFibre 2g\nSugars 1g\nProtein 3g\nVitamin C 45%\nCalcium 2%\nIron 6%\nPotassium 620mg\n"
                case 15:
                    info += "Per 7 radishes (85g)\n"
                    info += "Calories 10g\nSodium 55mg\nCarbohydrate 3g\nFibre 1g\nSugars 2g\nVitamin C 30%\nCalcium 2%\nIron 2%\nPotassium 190mg\n"
                case 16:
                    info += "Per 1/2 medium (98g)\n"
                    info += "Calories 20g\nCarbohydrate 4g\nFibre 2g\nSugars 2g\nProtein 1g\nVitamin A 6%\nVitamin C 30%\nCalcium 2%\nIron 2%\nPotassium 260mg\n"
                case 17:
                    info += "Per kernels from 1 medium ear (90g)\n"
                    info += "Calories 90g\nFat 2.5g\nCarbohydrate 18g\nFibre 2g\nSugars 5g\nProtein 4g\nVitamin A 2%\nVitamin C 10%\nIron 2%\nPotassium 250mg\n"
                case 18:
                    info += "Per 1 medium, 5\" long, 2\" diameter (130g)\n"
                    info += "Calories 100g\nSodium 70mg\nCarbohydrate 23g\nFibre 4g\nSugars 7g\nProtein 2g\nVitamin A 120%\nVitamin C 30%\nCalcium 4%\nIron 4%\nPotassium 440mg\n"
                case 19:
                    info += "Per 1 medium (148g)\n"
                    info += "Calories 25g\nSodium 20mg\nCarbohydrate 5g\nFibre 1g\nSugars 3g\nProtein 1g\nVitamin A 20%\nVitamin C 40%\nCalcium 2%\nIron 4%\nPotassium 340mg\n"
                default:
                    print("error in vegetables switch case")
                }
            default:
                print("error in section switch case")
            }
            info += "Percent Daily Values are based on a 2,000 calorie diet"
            //return to add view
            performSegue(withIdentifier: "presetToAdd", sender: self)
        }
    }
    
    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tableArray[section].sectionPresets.count)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return(tableArray.count)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return(tableArray[section].sectionName)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "presetCell")
        cell.textLabel?.text = tableArray[indexPath.section].sectionPresets[indexPath.row]
        cell.accessoryType = cell.isSelected ? .checkmark: .none
        cell.selectionStyle = .none
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedSection = indexPath.section
        selectedCell = indexPath.row
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //prepare function to pass selected data for segue to add view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presetToAdd")
        {
            let DestViewController = segue.destination as! AddVC
            DestViewController.itemSelected = itemSelected
            DestViewController.nameSelected = name
            DestViewController.infoSelected = info
        }
    }
    
 }
