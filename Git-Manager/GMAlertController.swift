//
//  GMAlertController.swift
//  Git-Manager
//
//  Created by 罗培克 on 2017/11/7.
//  Copyright © 2017年 北京爱康泰科技有限责任公司. All rights reserved.
//

import UIKit

class GMAlertController: UIAlertController {
    
    typealias GMAlertAction = (title: String?, handler: ((UIAlertAction) -> Void)?)
    
    public class func showAlert(title: String?,
                                message: String?,
                                confirmAction: GMAlertAction,
                                cancelAction: GMAlertAction?) {
        //  避免重复弹出同一个弹窗
        let currentVC = UIViewController.currentViewController()
        if currentVC.isKind(of: type(of: GMAlertController())) {
            if let currentAlertC = currentVC as? GMAlertController {
                if currentAlertC.title == title && currentAlertC.message == message {
                    return
                }
            }
        }
        
        let alertC = GMAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let confirmAct1 = UIAlertAction(title: confirmAction.title,
                                        style: UIAlertAction.Style.default,
                                        handler: confirmAction.handler)
        alertC.addAction(confirmAct1)
        if cancelAction?.handler != nil {
            let cancelAct = UIAlertAction(title: cancelAction?.title,
                                          style: UIAlertAction.Style.default,
                                          handler: cancelAction?.handler)
            alertC.addAction(cancelAct)
        }
        
        print("===> Show alert with title: " + (title ?? "nil") + ", message: " + (message ?? "nil"))
        DispatchQueue.main.async {
            currentVC.present(alertC, animated: true, completion: nil)
        }
    }

}
