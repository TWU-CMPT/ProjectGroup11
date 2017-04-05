//
//  SnacTrakUITests.swift
//  SnacTrakUITests
//
//  Created by Brittany Ryan on 2017-03-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import XCTest
import CoreData
@testable import SnacTrak

class SnacTrakUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMenu() {
        let app = XCUIApplication()
        //offline use
        app.buttons["Use Offline"].tap()
        //menuNavigation
        sleep(1)
        XCTAssert(app.navigationBars["Food Items"].exists)
        app.navigationBars["Food Items"].buttons["More 50"].tap()
        app.tables.staticTexts["Goals"].tap()
        sleep(1)
        XCTAssert(app.navigationBars["Goals"].exists)
        app.navigationBars["Goals"].buttons["More 50"].tap()
        app.tables.staticTexts["Meals"].tap()
        sleep(1)
        XCTAssert(app.navigationBars["Meals"].exists)
        app.navigationBars["Meals"].buttons["More 50"].tap()
        app.tables.staticTexts["About"].tap()
        sleep(1)
        XCTAssert(app.navigationBars["About"].exists)
        app.navigationBars["About"].buttons["More 50"].tap()
        app.tables.staticTexts["Food Items"].tap()
        sleep(1)
        XCTAssert(app.navigationBars["Food Items"].exists)
    }
    
    func testAddAndDelete() {
        let app = XCUIApplication()
        //offline use
        app.buttons["Use Offline"].tap()
        //menuNavigation
        app.navigationBars["Food Items"].buttons["More 50"].tap()
        app.tables.staticTexts["Goals"].tap()
        //add goal
        let before = app.tables.cells.count
        app.navigationBars["Goals"].buttons["Add"].tap()
        app.textFields["Enter amount here"].tap()
        app.textFields["Enter amount here"].typeText("1")
        XCUIApplication().navigationBars["Add"].buttons["Done"].tap()
        let after = before + 1
        XCTAssertEqual(app.tables.cells.count, after)
        Delete()
    }
    
    func Delete() {
        let app = XCUIApplication()
        let before = app.tables.cells.count
        //delete goal
        let index = app.tables.cells.count - 1
        app.tables.cells.element(boundBy: index).swipeLeft()
        app.tables.cells.element(boundBy: index).buttons["Delete"].tap()
        let after = before - 1
        XCTAssertEqual(app.tables.cells.count, after)
    }
    
    func testUserInput() {
        let app = XCUIApplication()
        //offline use
        app.buttons["Use Offline"].tap()
        //menuNavigation
        app.navigationBars["Food Items"].buttons["More 50"].tap()
        app.tables.staticTexts["Goals"].tap()
        //add goal
        app.navigationBars["Goals"].buttons["Add"].tap()
        app.textFields["Enter amount here"].tap()
        //typed input
        app.textFields["Enter amount here"].typeText("foo")
        XCTAssert(app.textFields["foo"].exists)
    }
    
}
