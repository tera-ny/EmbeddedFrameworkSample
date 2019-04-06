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
    var webView: AuthWebViewController?
    override func viewDidLoad() {
        webView = AuthWebViewController()
        webView?.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        if let webview = webView {
            self.present(webview, animated: true, completion: nil)
        }
    }
}

extension ViewController: AuthWebViewDelegate {
    func didfinishRequest(token: String) {
        self.webView?.dismiss(animated: true, completion: nil)
        self.webView = nil
        self.present(HomeViewController(), animated: true, completion: nil)
    }
}

