//
//  ViewController.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//
struct HeightConstants {
    static let topBottomContainerHeight = 50.0 as CGFloat //Height of Name and Like,Comment sections
    static let likeButtonHeight = 30.0 as CGFloat //Height of count of likes button
    static let timestampLabelHeight = 20.0 as CGFloat //Height of timestamp label
}

import UIKit
import ReachabilitySwift



class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var collectionViewPosts: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var userInstaPosts = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true;
        if (Reachability.init()?.isReachable)!
        {
            //If Network is there fetch data from Server
            getUserPosts()
        }
        else
        {
            //If Network is not there fetch data from Core data and show to the user
            PostsDataManager.sharedInstance.getUserPostsFromCoreData({ (success, posts) in
                self.userInstaPosts = NSArray.init(array: posts!);
                DispatchQueue.main.async {
                    self.collectionViewPosts.reloadData()
                }
                
            })
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserPosts() {
        self.loadingIndicator.startAnimating()
        //Fetching Posts of the user
        ServiceClient.sharedInstance.getUserPostsFromInstaGram({ (success, jsonResponse) in
            if success! {
                //Extract Posts Data and Save in Core Data
                PostsDataManager.sharedInstance.saveUserPostsinCoreData(with: jsonResponse as! NSDictionary, completionHandler: { (success, posts) in
                    self.userInstaPosts = NSArray.init(array: posts!);
                    DispatchQueue.main.async {
                        self.loadingIndicator.stopAnimating()
                        self.collectionViewPosts.reloadData()
                    }
                })
                
            }
        })
    }
    // MARK: UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.userInstaPosts.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let postTemp = self.userInstaPosts[indexPath.row] as! Instapost
        var heightTemp = (postTemp.captionText?.height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont(name: "Helvetica", size: 14.0)!))
        if heightTemp == nil
        {
            heightTemp = 10.0
        }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width+(HeightConstants.topBottomContainerHeight*2)+HeightConstants.timestampLabelHeight+HeightConstants.likeButtonHeight+heightTemp!)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath as IndexPath) as! PostCollectionViewCell
        // Configure the cell
        cell.configurePostCell(self.userInstaPosts[indexPath.row] as! Instapost)
        
        return cell
        
    }
}
