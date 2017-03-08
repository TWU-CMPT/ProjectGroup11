//
//  AppDelegate.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-03-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//
//  Editing Standard:
//  all classes have first and subsequent word first letters capitalized
//  all variables and function names start lowercase and subsequent word first letters are capitalized
//  button function names are of the form buttonWasPressed
//  comments have no initial space and are lowercase, headers being exception
//  xcode generated comments are left in their formating


import UIKit
//import CoreData - core data related code commented out as of version 1

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    //execute on app open
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //initialize google sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        
        //load and set user data - temporary storing set up for version 1 before implementing database
        let loadedData = UserDefaults.standard.string(forKey: "storedData")
        if loadedData != "" {

            //break up loaded string
            let itemArray = loadedData?.components(separatedBy: "\n")
            for i in 0...(itemArray?.count)! - 2
            {
                //break up into name and nutrints
                let temp = itemArray?[i].components(separatedBy: ".")
                let itemName = temp?[0]
                let newTemp = temp?[1]
                //break up nutrients
                let attributeArray = newTemp?.components(separatedBy: " ")
                if attributeArray?[0] != "" && (attributeArray?.count)! >= 3
                {
                    //add foodItem
                    let itemToAdd: FoodItem = FoodItem.init(nam: itemName!)
                    var j = 0
                    while j <= (attributeArray?.count)! - 2
                    {
                        //add nutrient to foodItem
                        let nutrientToAdd: Nutrient = Nutrient.init(nam: attributeArray![j], amoun: Int(attributeArray![j+1])!)
                        _ = itemToAdd.add(nutrient: nutrientToAdd)
                        j = j + 2
                    }
                    //add to global array for table
                    array.append(itemToAdd)
                }
            }

        }

        return true
    }
    
    //google sign in related functions for implentation
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //sign in error check
        if (error == nil) {
            print("Wow! Our user signed in!\n")
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //xcode given functions
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    //execute on app close
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        //store user data
        var dataToBeStored = ""
        if array.count > 0
        {
            //if something to be stored store each foodItem as an array and seperate them by \n
            for i in 0...array.count - 1
            {
                dataToBeStored = dataToBeStored + array[i].toString() + "\n"
            }
        }
        //update current version of stored data
        UserDefaults.standard.set(dataToBeStored, forKey: "storedData")
        UserDefaults.standard.synchronize()
    
        
        //self.saveContext() - core data related code commented out as of version 1
    }

    /* - core data related code commented out as of version 1
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SnacTrak")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    */
}

