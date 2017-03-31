//
//  MealsVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-19.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData

class MealsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set up navigation
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //load saved meals
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            mealArray = results as! [Meal]
        }
        catch {
            print("meal fetch error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addWasPressed(_ sender: UIBarButtonItem) {
        //move to add view
        performSegue(withIdentifier: "mealsToAdd", sender: nil)
    }
    
    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(mealArray.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mealCell")
        cell.textLabel?.text = mealArray[indexPath.row].name
        return(cell)
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //delete and reload table on swipe left and delete
            do {
                managedObjectContext.delete(mealArray[indexPath.row])
                try managedObjectContext.save()
                mealArray.remove(at: indexPath.row)
                myTable.reloadData()
            }
            catch{
                print("goal delete error")
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //on cell tap move to details view and display corresponding information
        let myDetails = mealArray[indexPath.row].printMeal()
        performSegue(withIdentifier: "mealsToDetails", sender: myDetails)
    }
    
    //prepare function to pass details data for segue to details view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mealsToDetails")
        {
            let DestViewController = segue.destination as! DetailsVC
            DestViewController.details = sender as! String
        }
    }
}
