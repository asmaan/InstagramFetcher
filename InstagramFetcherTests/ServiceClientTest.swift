//
//  ServiceClientTest.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 08/05/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import XCTest
@testable import InstagramFetcher
class ServiceClientTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Instagram Fetch Request test to check whether request is fulfilled or not
    func testInstagramFetchRequest() {
        // given
        let url = URL(string: Constants.getPostsURL)
        let promise = expectation(description: "Status code: 200")
        let sessionTest = URLSession.shared
        
        let dataTask = sessionTest.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
