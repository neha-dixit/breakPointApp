//
//  CreatePostVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/13/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
class CreatePostVC: UIViewController {

    @IBOutlet weak var butview: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTextView.delegate = self
       //sendBtn.bindToKeyboard()
        butview.bindToKeyboard()
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
    print("closer button was pressed")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if msgTextView != nil && msgTextView.text != "Say something here...." {
            print("send button enable false")
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: msgTextView.text, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    print("is completer true")
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    self.sendBtn.isEnabled = false
                    print("There is an error while sending the message from CReateVC")
                }
            }
            
        }
    }
    
    
}
extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        msgTextView.text = ""
    }
}
