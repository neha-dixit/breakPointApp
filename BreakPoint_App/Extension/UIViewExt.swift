//
//  UIViewExt.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/13/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
extension UIView {
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillChange(_ notification: NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        print("beginingFrame", beginingFrame)
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print("endFrame", endFrame)
        let deltaY = endFrame.origin.y - beginingFrame.origin.y
        print("deltaY", deltaY)
        UIView.animate(withDuration:duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += CGFloat(deltaY)
        }, completion: nil)
        
    }
}
/*
func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillChange(_ notification: NSNotification){
        let duration = 10;//notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = 5;//notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt

        //Print all this in single lines to see what is creating the issue
            (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
         

              print(UIResponder.keyboardFrameBeginUserInfoKey);
             print((notification.userInfo[UIResponder.keyboardFrameBeginUserInfoKey]);
             (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue))
            //then see if the last one can be changed to NSValue
        

        let beginingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        let deltaY = 3;//endFrame.origin.y - beginingFrame.origin.y
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: UIView.AnimationOptions(rawValue: UInt(curve)), animations: {
            self.frame.origin.y += CGFloat(deltaY)
        }, completion: nil)
        
    }
}
 */
