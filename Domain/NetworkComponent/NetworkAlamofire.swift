//
//  NetworkAlamofire.swift
//  Domain
//
//  Created by iniad on 2019/04/11.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAlamofire: Network {
    
    func request(model: APIModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        let session = Alamofire.Session.default
        let request = session.request(URL(string: model.path)!, method: .get, parameters: model.parameter, encoding: URLEncoding.default, headers: HTTPHeaders(model.parameter), interceptor: nil)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let json):
                completion(.success(json as? Data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}

