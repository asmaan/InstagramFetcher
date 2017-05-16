//
//  InstagramFetcherUITests.swift
//  InstagramFetcherUITests
//
//  Created by Amandeep Singh on 08/05/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import XCTest

class InstagramFetcherUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstafetcherUI() {
        // Use recording to get started writing UI tests.
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        let likeButton = cell.buttons["like"]
        likeButton.tap()
        likeButton.tap()
        cell.buttons["send to"].swipeUp()
        
        let element2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element(boundBy: 0)
        element.swipeUp()
        element.swipeUp()
        element2.swipeUp()
        element2.swipeUp()
        element2.swipeUp()
        
        let element3 = cell.children(matching: .other).element.children(matching: .other).element
        element3.swipeUp()
        element3.swipeUp()
        element2.swipeUp()
        element.swipeUp()
        element2.swipeUp()
        element3.swipeUp()
        element2.swipeUp()
        element3.swipeUp()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
