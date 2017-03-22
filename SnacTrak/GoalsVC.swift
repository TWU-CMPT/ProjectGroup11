//
//  GoalsVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-19.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

//global array
var goalArray = [Goal]()

class GoalsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTable: UITableView!
    
    //initializing date formatter
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //set date format
        formatter.dateFormat = "MM-dd-yyyy"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addWasPressed(_ sender: UIBarButtonItem) {
        //move to add view
        performSegue(withIdentifier: "goalsToAdd", sender: nil)
    }

    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(goalArray.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "goalCell")
        cell.textLabel?.text = goalArray[indexPath.row].toString()
        cell.detailTextLabel?.text = "By: " + formatter.string(from: goalArray[indexPath.row].completedBy as Date)
        return(cell)
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //delete and reload table on swipe left and delete
            goalArray.remove(at: indexPath.row)
            myTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //segue to graphical goal progress display - Version 3
    }

}
