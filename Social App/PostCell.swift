//
//  PostCell.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: CustomImmageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var postImag: UIImageView!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.configure()
  
    }

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        
        self.captionText.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImag.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.postUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Kot: Cannot download image from Url")
                } else {
                    print("Kot: Image downloaded from Firebase Storege")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImag.image = img
                            FeedVC.immageCache.setObject(img, forKey: post.postUrl as NSString)
                        }
                    }
                }
            })
            
        }
        
    }
    

}
