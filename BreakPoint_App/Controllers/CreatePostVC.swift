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

    @IBOutlet weak var emailLbl: UILabel!
   
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var postTxtView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closerBtnWasPRessed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if postTxtView.text != nil && postTxtView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withmessage: postTxtView.text, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil) { (isComplete) in
                if isComplete {
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
        postTxtView.text = ""
    }
}
