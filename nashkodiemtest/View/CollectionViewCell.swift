//
//  CollectionViewCell.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 24.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with text: String, url: URL) {
        print("%%%%%%%%%%%%%%%%%%\(text)")
        print("%%%%%%%%%%%%%%%%%%\(url)")
        testLabel.text = text
        imageView.downloaded(from: url)
    }
}
