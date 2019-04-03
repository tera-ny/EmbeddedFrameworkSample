//
//  NetworkCreater.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public class NetworkCreator {
    public static func createContext() -> Network {
        return NetworkImpl()
    }
}
