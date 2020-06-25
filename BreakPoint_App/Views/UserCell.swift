//
//  UserCell.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/20/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var checkLbl: UIImageView!
    var showing = false
    func ConfigureCell(profileImage image: UIImage, email: String, isSelected:Bool){
        self.profileImage.image = image
        self.emailLbl.text = email
        if isSelected{
            self.checkLbl.isHidden = false
        } else {
            self.checkLbl.isHidden = true
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            if showing == false {
             checkLbl.isHidden = false
                showing = true
            }
            
        else {
            checkLbl.isHidden = true
                showing = false
        }
        }
    }
}
