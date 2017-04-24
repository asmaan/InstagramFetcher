//
//  ServiceClient.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

struct Constants {
    static let getPostsURL = "https://api.instagram.com/v1/users/self/media/recent?access_token=2134107307.7e78d97.da3e9de8d2ad49d083b19a0ea1747f25"
}
import UIKit

class ServiceClient: NSObject {
    class var sharedInstance :ServiceClient {
        struct Singleton {
            static let instance = ServiceClient()
        }
        return Singleton.instance
    }
    //Fetching data from Instagram with URLSession
    func getUserPostsFromInstaGram(_ completionHandler: @escaping (Bool?,Any?) -> Swift.Void) {
        let urlPosts:URL = URL(string: Constants.getPostsURL)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: urlPosts as URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if (json != nil){
                completionHandler(true,json as Any)
            }
            else{
                completionHandler(false,nil)
            }
        }
        task.resume()
    }
}
