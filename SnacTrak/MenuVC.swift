//
//  MenuVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-19.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //if sign out is pressed
        if (indexPath.row == 5)
        {
            //sign out and return to sign in view
            GIDSignIn.sharedInstance().signOut()
            performSegue(withIdentifier: "segue2", sender: nil)
        }
    }

}
