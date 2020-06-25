//
//  GroupCell.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/23/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTtileLbl: UILabel!
    
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    
    @IBOutlet weak var memberLbl: UILabel!
    func configureCell(groupTitle: String, groupDescription: String, MemberCount: Int) {
        self.groupTtileLbl.text = groupTitle
        self.groupDescriptionLbl.text = groupDescription
        self.memberLbl.text = "\(MemberCount) members"
    }
}
