//
//  HomeVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-05.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

var array = [FoodItem]()


class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutWasPressed(sender: UIBarButtonItem) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "segue2", sender: nil)
    }
    
    @IBAction func addWasPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "homeToAdd", sender: nil)
    }
    
    
    // MARK: - Table View
    
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
            array.remove(at: indexPath.row)
            myTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let myString = array[indexPath.row].printAll()
        performSegue(withIdentifier: "homeToDetails", sender: myString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "homeToDetails")
        {
            let DestViewController = segue.destination as! DetailsVC
            DestViewController.details = sender as! String
        }
    }
    
}
