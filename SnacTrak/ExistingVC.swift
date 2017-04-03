//
//  ExistingVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-04-02.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class ExistingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    
    //initializing date formatter
    let formatter = DateFormatter()
    var itemSelected = false
    var selected = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set date format
        formatter.dateFormat = "MM-dd-yyyy"
        //tint back button red
        self.navigationController?.navigationBar.tintColor = UIColor.red;
    }

    @IBAction func doneWasPressed(_ sender: UIBarButtonItem) {
        if selected == -1
        {
            let alertController = UIAlertController(title: "Error message:", message: "You need to select an item first!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            alertController.view.tintColor = UIColor.red
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //return to add view
            itemSelected = true
            performSegue(withIdentifier: "existingToAdd", sender: self)
        }
    }
    
    //table view functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(array.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = array[indexPath.row].name
        cell.detailTextLabel?.text = "Date added: " + formatter.string(from: array[indexPath.row].date as! Date)
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selected = indexPath.row
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //prepare function to pass selected data for segue to add view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "existingToAdd")
        {
            let DestViewController = segue.destination as! AddVC
            DestViewController.itemSelected = itemSelected
            DestViewController.nameSelected = array[selected].name!
            DestViewController.servingSelected = array[selected].serving
            DestViewController.infoSelected = array[selected].printExisting()
        }
    }
    
}
