//
//  NetworkParser.swift
//  Domain
//
//  Created by haruta yamada on 2019/04/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public class NetworkParser {
    private static let decoder = JSONDecoder()
    public static func decodeToBaseDataModels<T: BaseDataModel>(json: Data?, type: T.Type) throws -> [T] {
        guard let json = json else {
            throw NSError(domain: "json is nil", code: 1, userInfo: nil)
        }
        do {
            let model = try decoder.decode([T].self, from: json)
            return model
        } catch {
            return try decodeToBaseDataModel(json: json, type: T.self)
        }
    }
    private static func decodeToBaseDataModel<T: BaseDataModel>(json: Data, type: T.Type) throws -> [T] {
        return [try decoder.decode(T.self, from: json)]
    }
}
