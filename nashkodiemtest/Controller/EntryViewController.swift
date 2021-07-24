//
//  EntryViewController.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import UIKit
import SwiftyVK

class EntryViewController: UIViewController {
    
    
    @IBAction func logInVKButton(_ sender: UIButton) {
        VK.sessions.default.logIn(
              onSuccess: { _ in
                
                print("Logged in")
                DispatchQueue.main.async { () -> Void in
                    self.performSegue(withIdentifier: "LogIn", sender: self)
                   }
              },
              onError: { _ in
                
                print("Egor on login")
              }
          )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let at = VK.sessions.default.accessToken
        if at == nil {
            print("No access token found")
        } else {
            if !at!.isValid {
                print("Invalid token")
            } else {
                print("Access token valid")
                self.performSegue(withIdentifier: "LogIn", sender: self)
            }
        }
    }
}

