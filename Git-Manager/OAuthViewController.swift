//
//  OAuthViewController.swift
//  Git-Manager
//
//  Created by 罗培克 on 2017/11/5.
//  Copyright © 2017年 北京爱康泰科技有限责任公司. All rights reserved.
//

import UIKit
import WebKit
import Then
import Alamofire

class OAuthViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration()).then {_ in
        
    }
    
    override func loadView() {
        view = webView
        webView.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "GitHub OAuth"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancel))
        
        let url = "https://github.com/login/oauth/authorize?scope=user:email&client_id=" + clientID
        webView.load(URLRequest(url: URL(string: url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    fileprivate func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let callback = navigationAction.request.url?.absoluteString.hasPrefix(callbackURL) {
            if callback {
                let query = navigationAction.request.url!.query!
                if query.hasPrefix("code=") {
                    let index = query.index(after: query.index(of: "=")!)
                    let code = query[index...]
                    print("OAuth code: " + code)
                    loadAccessToken(String(code))
                } else {
                    print("OAuth canceled!")
                    cancel()
                }
                decisionHandler(.cancel)
            }
        }
        decisionHandler(.allow)
    }
    
    fileprivate func loadAccessToken(_ code: String) {
        let url = "https://github.com/login/oauth/access_token"
        let params = ["code": code, "client_secret": clientSecret, "client_id": clientID]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
        }
    }

}
