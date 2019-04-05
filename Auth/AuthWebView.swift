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

public class AuthWebViewController: UIViewController {
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.frame = UIScreen.main.bounds
        return view
    }()
    private var webView: WKWebView!
    
    let auth: Auth
    
    private let accessURL = "https://qiita.com/api/v2/oauth/authorize"
    
    public init(auth: Auth) {
        self.auth = auth
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            return
        } else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}

extension URL {
    func query() -> [String: String?] {
        var params: [String: String?] = [:]
        guard let comp = NSURLComponents(string: self.absoluteString) else {
            return params
        }
        guard let queryItems = comp.queryItems else {
            return params
        }
        for item in queryItems {
            params[item.name] = item.value
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
