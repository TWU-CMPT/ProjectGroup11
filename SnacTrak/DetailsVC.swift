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
        //print details to view
        myLabel.text = details
        //tint back button red
        self.navigationController?.navigationBar.tintColor = UIColor.red;
    }
    
}
