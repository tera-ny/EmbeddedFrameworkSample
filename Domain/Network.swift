//
//  Network.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public protocol Network {
    func request(model: APIModel, completion: @escaping (Result<Data?, Error>) -> Void)
}

class NetworkImpl: Network {
    private let cachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
    private let timeoutInterval: TimeInterval = 20
    private var requestCount: Int = 0
    
    func request(model: APIModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        let session = URLSession.shared
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
        let task: URLSessionDataTask = session.dataTask(with: request) {(data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("StatusCode\(response.statusCode)")
            } else {
                print("response:\(String(describing: response))")
                print(model)
            }
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(data))
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
    func request(model: APIModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        let dummyUserJsonString: String = """
{
  "description": "Hello, world.",
  "facebook_id": "yaotti",
  "followees_count": 100,
  "followers_count": 200,
  "github_login_name": "yaotti",
  "id": "yaotti",
  "items_count": 300,
  "linkedin_id": "yaotti",
  "location": "Tokyo, Japan",
  "name": "Hiroshige Umino",
  "organization": "Increments Inc",
  "permanent_id": 1,
  "profile_image_url": "https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg",
  "team_only": false,
  "twitter_screen_name": "yaotti",
  "website_url": "http://yaotti.hatenablog.com"
}
"""
        completion(.success(dummyUserJsonString.data(using: String.Encoding.utf8)))
        //completion(.failure(NSError(domain: "DummyData", code: 1, userInfo: nil)))
    }
}
