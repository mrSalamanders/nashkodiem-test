//
//  ImageManager.swift
//  nashkodiemtest
//
//  Created by Владислав Николаев on 23.07.2021.
//

import Foundation
import SwiftyVK
import SwiftyJSON

class ImageManager {
    
    var col : [ImageModel] = []
    
    // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
    func getData(from url: URL, dateInUnix date: Int, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func appendPrepared(from url: URL, dateInUnix date: Int) -> () {
        print("Download Started")
        getData(from: url, dateInUnix: date) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            self.col.append(ImageModel(image: UIImage(data: data)!, timestamp: Date(timeIntervalSince1970: TimeInterval(date))))
            
            print(self.col)
        }
    }
    
    func fetchAll(collection col: [ImageModel]) {
        
        self.col = col
        
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
                
                self.appendPrepared(from: (subJson["sizes"][2]["url"].url ?? URL(string: "http://sun9-48.userapi.com/s/v1/if1/maqj7cf0CEF4cxYS46v03jay1ed3rFgtKHaN-RWSjfKZqjA5mNMfv1t7eVI-ZliPpzuSDveh.jpg?size=200x0&quality=96&crop=0,0,400,400&ava=1"))!, dateInUnix: subJson["date"].int ?? 0)
            }
        })
        .onError({ VKError in
            print(VKError.localizedDescription)
        })
            .send()
        
    }
}
