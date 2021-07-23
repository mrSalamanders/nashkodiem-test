//
//  AppDelegate.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import UIKit
import SwiftyVK

var vkDelegateReference : SwiftyVKDelegate?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        vkDelegateReference = CustomVKDelegate()
        return true
    }
    
    
//    func application(
//        _ app: UIApplication,
//        open url: URL,
//        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
//    ) -> Bool {
//        let app = options[.sourceApplication] as? String
//        VK.handle(url: url, sourceApplication: app)
//        return true
//    }


}

