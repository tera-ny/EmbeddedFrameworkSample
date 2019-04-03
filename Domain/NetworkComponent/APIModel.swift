//
//  APIModel.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
public enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public struct APIModel {
    public var path: String
    public var requestMethod: APIRequestMethod
    public var header: [String: String]
    public var parameter: [String: String]
    
    public init(path: String , requestMethod: APIRequestMethod,header: [String: String] = [:], parameter: [String: String] = [:]) {
        self.path = path
        self.requestMethod = requestMethod
        self.header = header
        self.parameter = parameter
    }
}
