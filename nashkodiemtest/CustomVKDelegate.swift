//
//  CustomVKDelegate.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import Foundation
import SwiftyVK

class CustomVKDelegate: SwiftyVKDelegate {
    
    let appId = "7909942"
    let scopes: Scopes = [.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    
    init() {
        VK.setUp(appId: appId, delegate: self)
        VK.sessions.default.config.language = Language.ru
        VK.sessions.default.config.handleErrors = true
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        // This code works only for simplest cases and one screen applications
        // If you have application with two or more screens, you should use different implementation
        // HINT: google it - get top most UIViewController
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                rootController.present(viewController, animated: true)
            }
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}
