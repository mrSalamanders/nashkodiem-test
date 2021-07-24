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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageObject = self.images[indexPath.row]
        
        var cell = UICollectionViewCell()
        
        if let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as? CollectionViewCell {
            imageCell.configure(url: imageObject.imageURL)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            PhotoViewController, let index =
            collectionView.indexPathsForSelectedItems?.first {
            destination.photo = images[index.row]
        }
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
