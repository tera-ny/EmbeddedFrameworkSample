//
//  NetworkCreater.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public class NetworkCreator {
    private static let decoder = JSONDecoder()
    public static func createContext() -> Network {
        return NetworkImpl()
    }
    public static func decodeToBaseDataModels<T: BaseDataModel>(json: Data, type: T.Type) -> Result<[T], Error> {
        do {
            let model = try decoder.decode([T].self, from: json)
            return .success(model)
        } catch {
            ///配列のDecodeに失敗した際に単体でのデコードに再挑戦
            return decodeToBaseDataModel(json: json, type: T.self)
        }
    }
    private static func decodeToBaseDataModel<T: BaseDataModel>(json: Data, type: T.Type) -> Result<[T], Error> {
        do {
            let model = try decoder.decode(T.self, from: json)
            return .success([model])
        } catch {
            return .failure(error)
        }
    }
}
