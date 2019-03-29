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


    func testHuman() {
        let jony = Human()
        XCTAssertEqual(jony.say(), "Hello World!")
    }

}
