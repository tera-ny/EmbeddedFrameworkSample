//
//  Network.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public protocol Network {
    func request<DataType: BaseDataModel>(model: APIModel, responseType: DataType.Type, completion: @escaping (Result<DataType?, Error>) -> Void)
}

class NetworkImpl: Network {
    private let cachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
    private let timeoutInterval: TimeInterval = 20
    
    func request<DataType: BaseDataModel>(model: APIModel, responseType: DataType.Type, completion: @escaping (Result<DataType?, Error>) -> Void) {
        
        guard let url = URL(string: model.path) else {
            completion(.failure(NSError(domain: "Url isn't active", code: 1, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
        request.httpMethod = model.requestMethod.rawValue
        insertHeader(request: &request, headers: model.header)
        insertParameter(request: &request, parameters: model.parameter)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.success(nil))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                completion(.success(self.decodeJsonToBaseDataModel(json: json, type: responseType)))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func insertHeader(request: inout URLRequest, headers: [String: String]) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    private func insertParameter(request: inout URLRequest, parameters: [String: String]) {
        var parameterString = String()
        for (index, parameter) in parameters.enumerated() {
            defer {
                ///パラメーターの接続のための&
                if index != parameters.count - 1 {
                    parameterString += "&"
                }
            }
            parameterString += "\(parameter.key)=\(parameter.value)"
        }
        request.httpBody = parameterString.data(using: String.Encoding.utf8)
    }
    
    private func decodeJsonToBaseDataModel<DataType: BaseDataModel>(json: Any, type: DataType.Type) -> DataType? {
        guard let data: DataType = type.decode(json: json) as? DataType else {
            return nil
        }
        return data
    }
}
