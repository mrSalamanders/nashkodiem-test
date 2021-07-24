//
//  PhotoViewController.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 24.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    
    var photo: ImageModel?
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        
        let activityItem: [AnyObject] = [self.imageViewOutlet.image as AnyObject]

        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)

        self.present(avc, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = "L"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        self.title = formatter1.string(from: photo!.timestamp)
        
        imageViewOutlet.downloaded(from: photo!.imageURL)
        
    }
    
    
}
