//
//  DomainTests.swift
//  DomainTests
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import XCTest
@testable import Domain

class DomainTests: XCTestCase {
    
    func testFetchUserWithId() {
        let id: String = "haruevorun"
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        User.fetch(userId: id) { (result) in
            defer {
                networkExpectation?.fulfill()
            }
            guard case .success(let users) = result else {
                if case .failure(let error) = result {
                    debugPrint(error)
                }
                XCTAssert(false)
                return
            }
            XCTAssertEqual("こんにちは", users[0].description)
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testfetchItems() {
        let page: Int = 1
        let per: Int = 10
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        Item.fetch(page: page, per: per, query: nil) { (result) in
            defer {
                networkExpectation?.fulfill()
            }
            guard case .success(let items) = result else {
                if case .failure(let error) = result {
                    debugPrint(error)
                }
                XCTAssert(false)
                return
            }
            XCTAssertEqual(items.count, per)
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}

func debugPrint(_ item: Any?) {
    guard let item = item else {
        return
    }
    #if DEBUG
    print(item)
    #else
    print("this method is debug only")
    #endif
}
