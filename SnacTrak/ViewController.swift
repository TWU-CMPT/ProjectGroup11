//
//  ViewController.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            performSegue(withIdentifier: "segue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWasPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

