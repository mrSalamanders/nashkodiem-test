//
//  EntryViewController.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import UIKit
import SwiftyVK

class EntryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func logInVKButton(_ sender: UIButton) {
        VK.sessions.default.logIn(
              onSuccess: { _ in
                // Start working with SwiftyVK session here
                print("Logged In")
              },
              onError: { _ in
                // Handle an error if something went wrong
                print("Egor")
              }
          )
    }

}

