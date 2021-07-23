//
//  ImageModel.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import Foundation
import UIKit

class ImageModel {
    var image : UIImage
    var timestamp : Date
    
    init(image: UIImage, timestamp: Date) {
        self.image = image
        self.timestamp = timestamp
    }
}
