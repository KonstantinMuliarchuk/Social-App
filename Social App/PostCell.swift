//
//  PostCell.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: CustomImmageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var postImag: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.configure()
        
        
        
    }

    
    

}
