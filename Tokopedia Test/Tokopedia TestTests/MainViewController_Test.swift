//
//  Tokopedia_TestTests.swift
//  Tokopedia TestTests
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import XCTest
import Eatr

@testable import Tokopedia_Test

class MainViewController_Test: XCTestCase, EatrDelegate {
    
    var mainViewController : MainViewController!
    var group : DispatchGroup?
    var response : EatrResponse?
    
    override func setUp() {
        super.setUp()
        mainViewController = MainViewController()
        _ = mainViewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequest() {
        let filter = Filter()
        assert(request(with: filter) != nil, "Failed")
        filter.maximumPrice = 1000000
        filter.minimumPrice = 500000
        guard let data : [ResultData] = request(with: filter) else {
            assertionFailure("Failed")
            return
        }
        for d in data {
            let price = getPrice(from : d.price)
            assert(price <= filter.maximumPrice && price >= filter.minimumPrice, "Price did not match")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // TEST HELPER
    
    func request(with filter : Filter) -> [ResultData]?{
        group = DispatchGroup()
        group?.enter()
        mainViewController.isRequesting = false
        mainViewController.requestForResult(for: "Samsung", with: filter, startIndex: 0, count: 10, delegate: self)
        group?.wait()
        guard let response : EatrResponse = response else {
            assertionFailure("No Response")
            return nil
        }
        guard let restResponse : RestResponse = response.parsedBody(), let data : [ResultData] = restResponse.data else {
            assertionFailure("Bad Response")
            return nil
        }
        assert(data.count == 10, "Data count is \(data.count)")
        return data
    }
    
    //DELEGATE
    
    func eatrOnFinished() {
        mainViewController.isRequesting = false
        group?.leave()
    }
    
    func eatrOnResponded(_ response: EatrResponse) {
        self.response = response
    }
    
    // FUNCTION
    
    func getPrice(from text : String?) -> Int {
        guard let text : String = text, text.count > 0 else {
            return 0
        }
        let currency : String = "Rp"
        var number = text
        if text.count > currency.count {
            for _ in currency {
                number = String(number.dropFirst())
            }
        }
        let trimmed = number.replacingOccurrences(of: "\\D", with: "", options: .regularExpression, range: nil)
        if let result : Int = Int(trimmed) {
            return result
        }
        else {
            return 0
        }
    }
    
}
