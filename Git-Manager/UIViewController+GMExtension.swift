//
//  UIViewController+GMExtension.swift
//  Git-Manager
//
//  Created by 罗培克 on 2017/11/7.
//  Copyright © 2017年 北京爱康泰科技有限责任公司. All rights reserved.
//

import UIKit

extension UIViewController {
    
    fileprivate class func findBestViewController(_ rootVC: UIViewController) -> UIViewController {
        if let vc = rootVC.presentedViewController {
            return UIViewController.findBestViewController(vc)
        }
        if rootVC.isKind(of: UISplitViewController.self) {
            let svc = rootVC as? UISplitViewController
            if let lastVC = svc?.viewControllers.last {
                return UIViewController.findBestViewController(lastVC)
            }
        } else if rootVC.isKind(of: UINavigationController.self) {
            let nvc = rootVC as? UINavigationController
            if let topVC = nvc?.topViewController {
                return UIViewController.findBestViewController(topVC)
            }
        } else if rootVC.isKind(of: UITabBarController.self) {
            let tvc = rootVC as? UITabBarController
            if let selectedVC = tvc?.selectedViewController {
                return UIViewController.findBestViewController(selectedVC)
            }
        }
        return rootVC
    }
    
    public class func currentViewController() -> UIViewController {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return UIViewController.findBestViewController(rootVC!)
    }
}
