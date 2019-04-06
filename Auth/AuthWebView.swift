//
//  AuthWebView.swift
//  Auth
//
//  Created by iniad on 2019/04/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import WebKit
public protocol AuthWebViewDelegate: class {
    func didfinishRequest(token: String)
    func didCatchError(error: Error)
}
public extension AuthWebViewDelegate {
    func didCatchError(error: Error) {
        print(error)
    }
}

public class AuthWebViewController: UIViewController {
    public struct Auth {
        let redirectUrl: URL
        let clientID: String
        public init(redirect: URL, clientID: String) {
            self.redirectUrl = redirect
            self.clientID = clientID
        }
    }
    
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.frame = UIScreen.main.bounds
        return view
    }()
    private var webView: WKWebView!
    
    private let auth: Auth = Auth(redirect: URL(string: "https://g4zeru_swift.qiita_client_application.com")!, clientID: "897dc498d5c4987376b5bf74db70d6e5d9362ee3")
    public weak var delegate: AuthWebViewDelegate?
    
    private let accessURL = "https://qiita.com/api/v2/oauth/authorize"
   
    override public func loadView() {
        super.loadView()
        self.view = self.backGroundView
    }
    
    override public func viewDidLoad() {
        self.webView = WKWebView(frame: self.view.frame)
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: URL(string: "\(accessURL)?client_id=\(auth.clientID)&scope=read_qiita+write_qiita_team")!))
        self.view.addSubview(self.webView)
    }
}

extension AuthWebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let requestURL = navigationAction.request.url else {
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        if requestURL.host == auth.redirectUrl.host {
            print("finished")
            print(requestURL.query!)
            decisionHandler(WKNavigationActionPolicy.cancel)
            let querys = requestURL.querys()
            self.delegate?.didfinishRequest(token: querys["code"] ?? String())
        } else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}

extension URL {
    func querys() -> [String: String] {
        var params: [String: String] = [:]
        guard let comp = NSURLComponents(string: self.absoluteString) else {
            return params
        }
        guard let queryItems = comp.queryItems else {
            return params
        }
        for item in queryItems {
            params[item.name] = item.value ?? String()
        }
        return params
    }
    func host() -> String? {
        guard let comp = NSURLComponents(string: self.absoluteString) else {
            return nil
        }
        return comp.host
    }
}
