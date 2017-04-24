//
//  PostCollectionViewCell.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import UIKit
import SDWebImage

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnUserProfileImage: UIButton!
    
    @IBOutlet weak var lblTimeStamp: UILabel!
    @IBOutlet weak var lblPostText: UILabel!
    @IBOutlet weak var btnPostLikes: UIButton!
    @IBOutlet weak var imgViewPost: UIImageView!
    @IBOutlet weak var btnUserName: UIButton!
    func configurePostCell(_ post:Instapost)
    {
        self.btnUserName.setTitle(post.user?.userName, for: UIControlState.normal)
        self.btnUserProfileImage.sd_setBackgroundImage(with: URL.init(string:(post.user?.profilePictureURL!)!), for: UIControlState.normal, placeholderImage: nil, options: SDWebImageOptions()) { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            //Making User Image Round Cornered
            self.btnUserProfileImage.layer.cornerRadius = self.btnUserProfileImage.frame.size.width/2;
            self.btnUserProfileImage.layer.borderWidth = 0.5;
            self.btnUserProfileImage.layer.borderColor = UIColor.lightGray.cgColor;
            self.btnUserProfileImage.layer.masksToBounds = true
        }
        self.lblTimeStamp.text = DateTimeFormatter.sharedInstance.getStringFromDate(post.createdTime! as Date)
        self.lblPostText.text = post.captionText
        self.btnPostLikes.setTitle( "\(post.likes)"+" likes", for: UIControlState.normal)
        self.imgViewPost.sd_setImage(with: URL.init(string:post.standardImageURL!)) { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
        }
    }
}
