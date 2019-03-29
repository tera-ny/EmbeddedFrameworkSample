//
//  BaseDataModel.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
public protocol BaseDataModel {
    static func decode(json: Any) -> BaseDataModel
}

public struct User: BaseDataModel {
    public static func decode(json: Any) -> BaseDataModel {
        return User()
    }
    
    let id: String = ""
}
