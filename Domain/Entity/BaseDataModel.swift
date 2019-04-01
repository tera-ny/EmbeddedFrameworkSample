//
//  BaseDataModel.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public protocol BaseDataModel: Codable {}

public struct User: BaseDataModel {
    let userId: String
    let name: String
    let age: Int
}
