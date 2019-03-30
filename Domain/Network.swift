//
//  Network.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public protocol Network {
    func request(model: APIModel, completion: @escaping (Result<Any?, Error>) -> Void)
}

class NetworkImpl: Network {
    private let cachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
    private let timeoutInterval: TimeInterval = 20
    
    func request(model: APIModel, completion: @escaping (Result<Any?, Error>) -> Void) {
        
        guard let url = URL(string: model.path) else {
            completion(.failure(NSError(domain: "Url isn't active", code: 1, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
        
        request.httpMethod = model.requestMethod.rawValue
        insertHeader(request: &request, headers: model.header)
        
        do {
            try insertParameter(request: &request, parameters: model.parameter)
        } catch {
            completion(.failure(error))
        }
        
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
                completion(.success(json))
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
    
    private func insertParameter(request: inout URLRequest, parameters: [String: String]) throws -> Void {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
}

class NetworkDummyData: Network {
    func request(model: APIModel, completion: @escaping (Result<Any?, Error>) -> Void) {
        completion(.failure(NSError(domain: "DummyData", code: 1, userInfo: nil)))
    }
}
