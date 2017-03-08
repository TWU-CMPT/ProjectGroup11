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
        // Do any additional setup after loading the view, typically from a nib.
        
        //set up for sign in
        //remember signed-in user
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //if signed in automatically change to home view
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            performSegue(withIdentifier: "segue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWasPressed(sender: AnyObject) {
        //sign in redirect to google on button press
        GIDSignIn.sharedInstance().signIn()
    }
    
}

