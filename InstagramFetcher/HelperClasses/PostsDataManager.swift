//
//  PostsDataManager.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import UIKit
import CoreData

class PostsDataManager: NSObject {
    var user : User?
    var userInstaPosts = NSMutableArray()
    
    class var sharedInstance :PostsDataManager {
        struct Singleton {
            static let instance = PostsDataManager()
        }
        return Singleton.instance
    }
    
    func saveUserPostsinCoreData(with postsData: NSDictionary, completionHandler: @escaping (Bool?,NSArray?) -> Swift.Void) {
        if let postsAll = postsData["data"] as? NSArray {
            if postsAll.count>0 {
                //Clear existing data since we get updated data from server
                self.clearExistingPosts()
            }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            for postDict in postsAll {
                let postDictTemp = postDict as! NSDictionary
                //Set user if not set already
                if (self.user == nil) {
                    self.user = User(context: managedContext)
                    if let userDict = postDictTemp["user"] as? NSDictionary{
                        self.user?.userId = userDict["id"] as? String
                        self.user?.fullName = userDict["full_name"] as? String
                        self.user?.userName = userDict["username"] as? String
                        self.user?.profilePictureURL = userDict["profile_picture"] as? String
                    }
                }
                
                
                let instaPost = Instapost(context: managedContext)
                instaPost.location = postDictTemp["location"] as? String
                instaPost.filter = postDictTemp["filter"] as? String
                if let likesDict = postDictTemp["likes"] as? NSDictionary{
                    instaPost.likes = (likesDict["count"] as? Int16)!
                }
                if let captionDict = postDictTemp["caption"] as? NSDictionary{
                    instaPost.captionText = captionDict["text"] as? String
                }
                if let commentsDict = postDictTemp["comments"] as? NSDictionary{
                    instaPost.comments = (commentsDict["count"] as? Int16)!
                }
                let creationTime = postDictTemp["created_time"] as? String
                instaPost.createdTime = DateTimeFormatter.sharedInstance.getDateFromMiliseconds(Int64(creationTime!)!) as NSDate
                instaPost.userHasLiked = (postDictTemp["user_has_liked"] as? Bool)!
                instaPost.postID = postDictTemp["id"] as? String
                instaPost.tags = postDictTemp["id"] as? NSArray
                if let imagesDict = postDictTemp["images"] as? NSDictionary{
                    if let imagesDictStandard = imagesDict["standard_resolution"] as? NSDictionary{
                        instaPost.standardImageURL = imagesDictStandard["url"] as? String
                    }
                    if let imagesDictStandard = imagesDict["thumbnail"] as? NSDictionary{
                        instaPost.thumbnailURL = imagesDictStandard["url"] as? String
                    }
                }
                instaPost.user = self.user
                userInstaPosts.add(instaPost)
            }
            if userInstaPosts.count>0 {
                //save data locally after creating new entities from updated data
                do {
                    
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                completionHandler(true,userInstaPosts)
            }
        }
    }
    
    func getUserPostsFromCoreData(_ completionHandler: @escaping (Bool?,NSArray?) -> Swift.Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Instapost> = Instapost.fetchRequest()
        //Sorting by Post Date
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdTime", ascending: false)]
        do {
            let instaPosts = try managedContext.fetch(fetchRequest)
            completionHandler(true,instaPosts as NSArray)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func clearExistingPosts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetchUser: NSFetchRequest<User> = User.fetchRequest()
        
        let deleteRequestUsers = NSBatchDeleteRequest(fetchRequest: deleteFetchUser as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try managedContext.execute(deleteRequestUsers)
            try managedContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
}
