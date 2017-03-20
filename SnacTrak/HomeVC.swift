//
//  HomeVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

//global array for version 1 data and storing
var array = [FoodItem]()


class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
    
    @IBAction func signOutWasPressed(sender: UIBarButtonItem) {
        //sign out and return to sign in view
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "segue2", sender: nil)
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = array[indexPath.row].name
        
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
    
}
