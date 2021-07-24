//
//  ImageModel.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import Foundation
import UIKit

struct ImageModel {
    var imageURL : URL
    var timestamp : Date
    
    init(imageURL: URL, timestamp: Date) {
        self.imageURL = imageURL
        self.timestamp = timestamp
    }
}
