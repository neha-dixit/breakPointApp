//
//  ShadowView.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/10/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
