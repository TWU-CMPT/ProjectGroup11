//
//  GoalsVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-19.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTable: UITableView!
    
    //initializing date formatter
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up navigation
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //set date format
        formatter.dateFormat = "MM-dd-yyyy"
    }
    
    @IBAction func addWasPressed(_ sender: UIBarButtonItem) {
        //move to add view
        performSegue(withIdentifier: "goalsToAdd", sender: nil)
    }

    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(goalArray.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "goalCell")
        cell.textLabel?.text = goalArray[indexPath.row].toString()
        cell.detailTextLabel?.text = "By: " + formatter.string(from: goalArray[indexPath.row].completedBy as! Date)
        return(cell)
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //delete and reload table on swipe left and delete
            do {
                managedObjectContext.delete(goalArray[indexPath.row])
                try managedObjectContext.save()
                goalArray.remove(at: indexPath.row)
                myTable.reloadData()
            }
            catch{
                print("goal delete error")
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //segue to graphical goal progress display
        performSegue(withIdentifier: "goalsToDisplay", sender: indexPath.row)
    }
    
    //prepare function to pass selected data for segue to display view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goalsToDisplay")
        {
            let DestViewController = segue.destination as! DisplayVC
            DestViewController.gdetails = sender as! Int
        }
    }

}
