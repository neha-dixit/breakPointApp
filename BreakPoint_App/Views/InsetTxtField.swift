//
//  InsetTxtField.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class InsetTxtField: UITextField {

    private var textRectOffset: CGFloat = 20
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
        }
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
        }
    func setupView(){
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        self.attributedPlaceholder = placeholder
    }
 
}
