//
//  HomeVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData

//global variables
var array = [FoodItem]()
var goalArray = [Goal]()
var mealArray = [Meal]()
let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //initializing date formatter
    let formatter = DateFormatter()
    //variables to control alert messages
    var messages = [String]()
    var count = 0
    
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
        
        //load saved foodItems
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            array = results as! [FoodItem]
        }
        catch {
            print("foodItem fetch error")
        }
        
        //load saved goals
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do {
            let results = try managedObjectContext.fetch(fetchRequest2)
            goalArray = results as! [Goal]
        }
        catch {
            print("goal fetch error")
        }
        
        //check if any goal deadlines have passed
        checkGoals()
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
        cell.detailTextLabel?.text = "Date added: " + formatter.string(from: array[indexPath.row].date as! Date)
        return(cell)
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //delete and reload table on swipe left and delete
            do {
                managedObjectContext.delete(array[indexPath.row])
                try managedObjectContext.save()
                array.remove(at: indexPath.row)
                myTable.reloadData()
            }
            catch{
                print("foodItem delete error")
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //on cell tap move to details view and display corresponding information
        let myDetails = array[indexPath.row].printItem()
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
            for i in (0...goalArray.count-1).reversed()
            {
                //check if date to be completed by has passed
                let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
                let now = Date()
                let date = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now, options: NSCalendar.Options.matchFirst)!
                if date > goalArray[i].completedBy as! Date
                {
                    //add not reached goal alert
                    let message = "Goal " + goalArray[i].toString() + " not reached"
                    messages.append(message)
                    //delete goal
                    do {
                        managedObjectContext.delete(goalArray[i])
                        try managedObjectContext.save()
                        goalArray.remove(at: i)
                    }
                    catch{
                        print("goal delete error")
                    }
                    
                    
                }
                //check if goal amount has been reached
                else if goalArray[i].progress >= goalArray[i].amount
                {
                    //add reached goal alert
                    let message = "Goal " + goalArray[i].toString() + " reached"
                    messages.append(message)
                    //delete goal
                    do {
                        managedObjectContext.delete(goalArray[i])
                        try managedObjectContext.save()
                        goalArray.remove(at: i)
                    }
                    catch{
                        print("goal delete error")
                    }
                }
            }
            //if there are message alerts
            if messages.count > 0
            {
                //pop-up first alert
                count += 1
                alertMessage(messag: messages[0])
            }
        }
    }
    
    //pop-up alert message
    func alertMessage(messag: String)
    {
        let alertController = UIAlertController(title: "Goal Alert:", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
            //recursively call alertMessage until all alerts have been processed
            if self.count < self.messages.count
            {
                self.count += 1
                self.alertMessage(messag: self.messages[self.count-1])
            }
        }))
        alertController.view.tintColor = UIColor.red
        self.present(alertController, animated: true, completion: nil)
    }
    
}
