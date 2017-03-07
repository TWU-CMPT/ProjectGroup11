//
//  DetailsVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-06.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var myLabel: UITextView!
    var details = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = details
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backWasPressed(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "detailsToHome", sender: nil)
    }

}
