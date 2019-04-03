//
//  NetworkCreator.swift
//  Domain
//
//  Created by haruta yamada on 2019/04/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

class NetworkCreator {
    static let domain: String = "https://qiita.com"
    public static func create() -> Network {
        return NetworkImpl()
    }
}
