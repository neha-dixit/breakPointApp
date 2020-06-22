//
//  CreatePostVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/13/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var butview: UIView!
    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.delegate = self
        butview.bindToKeyboard()
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
        if textView != nil && textView.text != "Say something here...." {
            print("send button enable false")
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    print("is completer true")
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    self.sendBtn.isEnabled = true
                    print("There is an error while sending the message from CReateVC")
                }
            }
            
        }
    }
    
    
}
extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
