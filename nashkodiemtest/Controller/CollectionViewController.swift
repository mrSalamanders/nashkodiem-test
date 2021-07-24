//
//  CollectionViewController.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import UIKit
import SwiftyVK
import SwiftyJSON


private let reuseIdentifier = "dataCell"

class CollectionViewController: UICollectionViewController {
    
//    var images = [ImageModel(imageURL: URL(string: "https://sun9-81.userapi.com/impg/5tAteArP7UPg8S1Q7npfthYFQ4qrpwY2BOpprQ/9zkOOQF-h5c.jpg?size=604x403&quality=96&sign=1bee0317a6387c1678dae29e9cd2af97&c_uniq_tag=zKz1A6aWiIyOmoi6rbHBu3g8MJDq1V1_UcBYfs5sRxY&type=album")!, timestamp: Date(timeIntervalSinceNow: 1245)), ImageModel(imageURL: URL(string: "https://sun9-81.userapi.com/impg/5tAteArP7UPg8S1Q7npfthYFQ4qrpwY2BOpprQ/9zkOOQF-h5c.jpg?size=604x403&quality=96&sign=1bee0317a6387c1678dae29e9cd2af97&c_uniq_tag=zKz1A6aWiIyOmoi6rbHBu3g8MJDq1V1_UcBYfs5sRxY&type=album")!, timestamp: Date(timeIntervalSinceNow: -124))]
    
    var images = [ImageModel]()
    
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        print("Log out")
        VK.sessions.default.logOut()
        self.performSegue(withIdentifier: "LogOut", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        loadListOfImages()
        
    }
    
    // MARK: UICollectionViewDataSource
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let imageObject = self.images[indexPath.row]
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
//        myCell.labelOutlet.text = formatter1.string(from: imageObject.timestamp)
        
        var cell = UICollectionViewCell()
        
        if let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as? CollectionViewCell {
            imageCell.configure(with: formatter1.string(from: imageObject.timestamp), url: imageObject.imageURL)
            imageCell.layoutIfNeeded()
            cell = imageCell
        }
        
        return cell
    }
    
    func loadListOfImages()
    {
        
        print("Loading photos")
        VK.API.Photos.get([
            .ownerId: "-128666765",
            .albumId: "266276915"
        ])
        .onSuccess({ response in
            let json = try JSON(data: response)
            for (_, subJson):(String, JSON) in json["items"] {
                
                print(subJson["date"])
                print(subJson["sizes"][2]["url"])
                
                self.images.append(ImageModel(imageURL: (subJson["sizes"][2]["url"].url ?? URL(string: "http://sun9-48.userapi.com/s/v1/if1/maqj7cf0CEF4cxYS46v03jay1ed3rFgtKHaN-RWSjfKZqjA5mNMfv1t7eVI-ZliPpzuSDveh.jpg?size=200x0&quality=96&crop=0,0,400,400&ava=1"))!, timestamp: Date(timeIntervalSince1970: TimeInterval(subJson["date"].int ?? 0))))
                
                
                
            }
            
            DispatchQueue.main.async {
                print(self.images)
                self.collectionView.reloadData()
            }
            
        })
        .onError({ VKError in
            print(VKError.localizedDescription)
        })
        .send()
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
