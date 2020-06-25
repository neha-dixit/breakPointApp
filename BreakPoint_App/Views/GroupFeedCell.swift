//
//  GroupFeedCell.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/23/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
}
