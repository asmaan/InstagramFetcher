//
//  DateTimeFormatterTest.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 07/05/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import XCTest
@testable import InstagramFetcher
class DateTimeFormatterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testDateFromMilliseconds() {

        let dateInMilliseconds:Int64 = 1494156808
//        let formatterManager = DateTimeFormatter.s
        
//        let currentDate = Date()
        XCTAssertNotNil(DateTimeFormatter.sharedInstance.getDateFromMiliseconds(dateInMilliseconds))
        //Below test if for comparing the dates
//        XCTAssertEqualWithAccuracy(fetchedDate.timeIntervalSinceReferenceDate,
//                                   currentDate.timeIntervalSinceReferenceDate, accuracy: 0.001)

        
    }    
}
