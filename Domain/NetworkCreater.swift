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
        #if DEBUG
        return NetworkDummyData()
        #else
        return NetworkImpl()
        #endif
    }
    public static func decodeToBaseDataModel<T: BaseDataModel>(json: Data, type: T.Type) -> Result<T, Error> {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: json)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}
