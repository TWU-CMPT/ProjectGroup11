//
//  ViewController.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit

class TitleScreen: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up for sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        //remember signed-in user
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if signed in automatically change to home view
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            performSegue(withIdentifier: "segue", sender: nil)
        }
    }
    
    @IBAction func signInWasPressed(sender: AnyObject) {
        //sign in redirect to google on button press
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func useOfflineWasPressed(_ sender: UIButton) {
        //bypass login
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
}

