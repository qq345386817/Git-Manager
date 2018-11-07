//
//  GMLoginViewController.swift
//  Git-Manager
//
//  Created by 北京爱康泰科技有限责任公司 on 2017/11/5.
//  Copyright © 2017年 北京爱康泰科技有限责任公司. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire

class GMLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        let oauthVC = OAuthViewController()
        let nav = UINavigationController(rootViewController: oauthVC)
        show(nav, sender: sender)
    }

}
