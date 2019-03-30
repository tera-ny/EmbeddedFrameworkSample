//
//  ViewController.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import Domain

class ViewController: UIViewController {
    override func viewDidLoad() {
        let model: APIModel = APIModel(path: "https://www.google.com", requestMethod: .get)
        NetworkCreator.createContext().request(model: model) { (result) in
            switch result {
            case .success(let json):
                guard let json = json else {
                    return
                }
                print(NetworkCreator.decodeToBaseDataModel(json: json, type: Domain.User.self))
            case .failure(let error):
                print(error)
            }
        }
    }
}

