//
//  ViewController.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import Domain

class ViewController: UIViewController {
    override func viewDidLoad() {
        let model: APIModel = APIModel(path: "https://www.google.com", requestMethod: .get)
        NetworkCreator.createContext().request(model: model, responseType: User.self) { (result) in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}

