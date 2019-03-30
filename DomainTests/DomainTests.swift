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

    func testDecode() {
        let model: APIModel = APIModel(path: "hoge", requestMethod: .get)
        NetworkCreator.createContext().request(model: model) { (response) in
            switch response {
            case .failure(let error):
                print(error)
                XCTAssert(false)
            case .success(let json):
                let result = NetworkCreator.decodeToBaseDataModel(json: json!, type: User.self)
                switch result {
                case .failure(let error):
                    print(error)
                    XCTAssert(false)
                case .success(let users):
                    XCTAssertEqual("hoge", users[0].name)
                }
            }
        }
    }

}
