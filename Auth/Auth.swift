//
//  AuthID.swift
//  Auth
//
//  Created by iniad on 2019/04/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public struct Auth {
    let redirectUrl: URL
    let clientID: String
    public init(redirect: URL, clientID: String) {
        self.redirectUrl = redirect
        self.clientID = clientID
    }
}
