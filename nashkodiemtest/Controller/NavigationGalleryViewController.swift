//
//  NavigationGalleryViewController.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import UIKit
import SwiftyVK

class NavigationGalleryViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let at = VK.sessions.default.accessToken
        if (at != nil) {
            if (at!.isValid) {
                print("Access Granted")
            }
        } else {
            print("Move to log screen")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
