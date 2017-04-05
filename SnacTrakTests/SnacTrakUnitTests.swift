//
//  CoreDataTests.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-04-04.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import XCTest
import CoreData
@testable import SnacTrak

class SnacTrakUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatchMajority() {
        let viewController = AddVC()
        XCTAssertTrue(viewController.matchMajority(nutrient: "Protein",scannedN: "Protein"))
        XCTAssertTrue(viewController.matchMajority(nutrient: "Protein",scannedN: "Protyn"))
        XCTAssertFalse(viewController.matchMajority(nutrient: "Protein",scannedN: "Fiber"))
    }
    
    func testSeparate() {
        let viewController = AddVC()
        //set input for function
        let input = "Fibre 3 Potassium 5"
        //create item to test against
        let entityFoodItem = NSEntityDescription.entity(forEntityName: "FoodItem", in: managedObjectContext)
        let newItem = NSManagedObject(entity: entityFoodItem!, insertInto: managedObjectContext) as! FoodItem
        let entityNutrient = NSEntityDescription.entity(forEntityName: "Nutrient", in: managedObjectContext)
        let newNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
        newNutrient.name = "Fibre"
        newNutrient.amount = 3
        newItem.addToNutrients(newNutrient)
        let otherNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
        otherNutrient.name = "Potassium"
        otherNutrient.amount = 3
        newItem.addToNutrients(otherNutrient)
        //test
        XCTAssertEqual(Array(viewController.separate(strin: input).nutrients)[0].name, Array(newItem.nutrients)[0].name)
        XCTAssertEqual(Array(viewController.separate(strin: input).nutrients)[0].amount, Array(newItem.nutrients)[0].amount)
        XCTAssertEqual(Array(viewController.separate(strin: input).nutrients)[1].name, Array(newItem.nutrients)[1].name)
        XCTAssertNotEqual(Array(viewController.separate(strin: input).nutrients)[1].amount, Array(newItem.nutrients)[1].amount)
        //delete
        managedObjectContext.delete(newItem)
        managedObjectContext.delete(newNutrient)
        managedObjectContext.delete(otherNutrient)
    }
    
    func testFoodItemPrintAll() {
        //create food item
        let entityFoodItem = NSEntityDescription.entity(forEntityName: "FoodItem", in: managedObjectContext)
        let newItem = NSManagedObject(entity: entityFoodItem!, insertInto: managedObjectContext) as! FoodItem
        let entityNutrient = NSEntityDescription.entity(forEntityName: "Nutrient", in: managedObjectContext)
        let newNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
        newNutrient.name = "Iron"
        newNutrient.amount = 3
        newItem.addToNutrients(newNutrient)
        let newerNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
        newerNutrient.name = "Fibre"
        newerNutrient.amount = 4
        newItem.addToNutrients(newerNutrient)
        let newestNutrient = NSManagedObject(entity: entityNutrient!, insertInto: managedObjectContext) as! Nutrient
        newestNutrient.name = "Cholesterol"
        newestNutrient.amount = 5
        newItem.addToNutrients(newestNutrient)
        newItem.serving = 2
        //set output
        let output = "Nutrient Name/Amount Per Serving/Total:\nIron 3.0% 6.0%\nFibre 4.0g 8.0g\nCholesterol 5.0mg 10.0mg\n"
        //test
        XCTAssertEqual(newItem.printAll(), output)
        //delete
        managedObjectContext.delete(newItem)
        managedObjectContext.delete(newNutrient)
        managedObjectContext.delete(newerNutrient)
        managedObjectContext.delete(newestNutrient)
    }
    
    func testGoalToString() {
        //create goal
        let entityGoal = NSEntityDescription.entity(forEntityName: "Goal", in: managedObjectContext)
        let newGoal = NSManagedObject(entity: entityGoal!, insertInto: managedObjectContext) as! Goal
        newGoal.nutrient = "Vitamin A"
        newGoal.amount = 10
        let newerGoal = NSManagedObject(entity: entityGoal!, insertInto: managedObjectContext) as! Goal
        newerGoal.nutrient = "Sugars"
        newerGoal.amount = 7
        let newestGoal = NSManagedObject(entity: entityGoal!, insertInto: managedObjectContext) as! Goal
        newestGoal.nutrient = "Sodium"
        newestGoal.amount = 101
        //test
        XCTAssertEqual(newGoal.toString(), "10.0% of Vitamin A")
        XCTAssertEqual(newerGoal.toString(), "7.0g of Sugars")
        XCTAssertEqual(newestGoal.toString(), "101.0mg of Sodium")
        //delete
        managedObjectContext.delete(newGoal)
        managedObjectContext.delete(newerGoal)
        managedObjectContext.delete(newestGoal)
    }
    
    func testGoalGetNeed() {
        //create goal
        let entityGoal = NSEntityDescription.entity(forEntityName: "Goal", in: managedObjectContext)
        let newGoal = NSManagedObject(entity: entityGoal!, insertInto: managedObjectContext) as! Goal
        newGoal.nutrient = "Protein"
        newGoal.amount = 50
        newGoal.progress = 20.5
        //test
        XCTAssertEqual(newGoal.getNeed(), 50-20.5)
        //delete
        managedObjectContext.delete(newGoal)
    }
    
    func testMealPrintMeal() {
        //create meal
        let entityMeal = NSEntityDescription.entity(forEntityName: "Meal", in: managedObjectContext)
        let newMeal = NSManagedObject(entity: entityMeal!, insertInto: managedObjectContext) as! Meal
        newMeal.name = "meal"
        newMeal.itemNames = ["foodItem1", "foodItem2"]
        newMeal.totals = [1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 0.0]
        //set ouput
        let output = "Meal Name:\nmeal\n\nIncluded Food Items:\nfoodItem1\nfoodItem2\n\nNutrient Name/Total:\nCalories 1.0g\nFat 2.0g\nCholesterol 3.0mg\nIron 4.0%\n"
        //test
        XCTAssertEqual(newMeal.printMeal(), output)
        //delete
        managedObjectContext.delete(newMeal)
    }
    
}
