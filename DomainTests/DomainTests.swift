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


    func testNetwork() {
        let model: APIModel = APIModel(path: "hoge", requestMethod: .get)
        NetworkCreator.createContext().request(model: model) { (resul) in
            guard case .success(let json) = resul else {
                fatalError()
            }
            let result = NetworkCreator.decodeToBaseDataModel(json: json!, type: User.self)
            guard case .success(let createdUser) = result else {
                fatalError()
            }
            XCTAssertEqual("hoge", createdUser.name)
        }
    }

}
