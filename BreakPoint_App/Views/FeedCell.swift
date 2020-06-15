//
//  FeedCell.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/15/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var postText: UILabel!
    func configureCell(profileImage: UIImage, email: String, content: String){

        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.postText.text = content
}
}
