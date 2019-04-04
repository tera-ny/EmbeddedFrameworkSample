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
        let model: APIModel = APIModel(path: "\(NetworkCreator.domain)/api/v2/users/haruevorun", requestMethod: .get, header: ["Host":"qiita.com"])
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        let context = NetworkCreator.create()
        
        debugPrint("request...")
        context.request(model: model) { (response) in
            defer {
                networkExpectation?.fulfill()
            }
            debugPrint("connected...")
            switch response {
            case .failure(let error):
                debugPrint(error)
                XCTAssert(false)
            case .success(let json):
                do {
                    let models = try NetworkParser.decodeToBaseDataModels(json: json, type: User.self)
                    XCTAssertEqual(1, models.count)
                    XCTAssertEqual("こんにちは", models[0].description)
                } catch {
                    print(error)
                }
            }
        }
        
        self.waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testUsers() {
        let page = 1
        let per = 20
        let model: APIModel = APIModel(path: "\(NetworkCreator.domain)/api/v2/users?page=\(page)&per_page=\(per)", requestMethod: .get, header: ["Host":"qiita.com"])
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        let context = NetworkCreator.create()
        
        debugPrint("request...")
        context.request(model: model) { (response) in
            defer {
                networkExpectation?.fulfill()
            }
            debugPrint("connected...")
            switch response {
            case .failure(let error):
                debugPrint(error)
                XCTAssert(false)
            case .success(let json):
                guard let json = json else {
                    XCTAssert(true)
                    return
                }
                do {
                    let result = try NetworkParser.decodeToBaseDataModels(json: json, type: User.self)
                    XCTAssertEqual(result.count, per)
                } catch {
                    print(error)
                    XCTAssert(false)
                }
            }
        }
        
        self.waitForExpectations(timeout: 3, handler: nil)
    }
    
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
    
    
    func testItems() {
        let page: Int = 1
        let per: Int = 20
        let path: String = "\(NetworkCreator.domain)/api/v2/items?page=\(page)&per_page=\(per)"
        let model = APIModel(path: path, requestMethod: .get)
        let context = NetworkCreator.create()
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        context.request(model: model) { (result) in
            defer {
                networkExpectation?.fulfill()
            }
            guard case .success(let json) = result else {
                if case .failure(let error) = result {
                    debugPrint(error)
                }
                XCTAssert(false)
                return
            }
            do {
                let items: [Item] = try NetworkParser.decodeToBaseDataModels(json: json, type: Item.self)
                XCTAssertEqual(items.count, per)
            } catch {
                debugPrint(error)
                XCTAssert(false)
            }
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
