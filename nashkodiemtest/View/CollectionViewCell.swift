//
//  CollectionViewCell.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 24.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(url: URL) {
        imageView.downloaded(from: url)
    }
}
