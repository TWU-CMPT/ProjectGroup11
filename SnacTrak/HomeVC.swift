//
//  HomeVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

//global array
var array = [FoodItem]()

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //initializing date formatter
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set up navigation
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //set date format
        formatter.dateFormat = "MM-dd-yyyy"
        //check if any goal deadlines have passed
        checkGoals()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //reload table data
        myTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addWasPressed(_ sender: UIBarButtonItem) {
        //move to add view
        performSegue(withIdentifier: "homeToAdd", sender: nil)
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
        cell.detailTextLabel?.text = "Date added: " + formatter.string(from: array[indexPath.row].date as Date)
        return(cell)
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //delete and roload table on swipe left and delete
            array.remove(at: indexPath.row)
            myTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //on cell tap move to details view and display corresponding information
        let myDetails = "Item Name: \n" + array[indexPath.row].name + "\n\n" + "Nutient name/Amount Per Serving/Total:\n" + array[indexPath.row].printAll()
        performSegue(withIdentifier: "homeToDetails", sender: myDetails)
    }
    
    //prepare function to pass details data for segue to details view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "homeToDetails")
        {
            let DestViewController = segue.destination as! DetailsVC
            DestViewController.details = sender as! String
        }
    }
    
    func checkGoals()
    {
        if goalArray.count > 0
        {
            for i in 0...goalArray.count-1
            {
                //***currently always true, need to find a way to truncate dates to ignore time
                //if Date() > goalArray[i].completedBy
                //{
                //    print(String(describing: Date()) + "\n")
                //    print(String(describing: goalArray[i].completedBy) + "\n")
                //    //alert they didnt reach their goal
                //    let message = "Goal " + String(goalArray[i].amount) + "g of " + goalArray[i].nutrient + " not reached"
                //    alertMessage(messag: message)
                //    //remove goal from array
                //    goalArray.remove(at: i)
                //}
                //else if goalArray[i].progress >= goalArray[i].amount
                if goalArray[i].progress >= goalArray[i].amount
                {
                    //alert they reached their goal
                    let message = "Goal " + String(goalArray[i].amount) + "g of " + goalArray[i].nutrient + " reached"
                    alertMessage(messag: message)
                    //remove goal from array
                    goalArray.remove(at: i)
                }
            }
        }
    }
    
    //pop-up error message
    func alertMessage(messag: String)
    {
        let alertController = UIAlertController(title: "Goal Alert:", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        alertController.view.tintColor = UIColor.red
        self.present(alertController, animated: true, completion: nil)
    }
    
}
