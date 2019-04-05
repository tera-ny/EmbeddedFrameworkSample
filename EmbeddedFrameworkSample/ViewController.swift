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
import Auth

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let webView = AuthWebViewController(auth: Auth(redirect: URL(string: "https://g4zeru_swift.qiita_client_application.com")!, clientID: "897dc498d5c4987376b5bf74db70d6e5d9362ee3"))
        self.present(webView, animated: false, completion: nil)
    }
}

