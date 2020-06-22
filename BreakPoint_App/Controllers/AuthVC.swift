//
//  AuthVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDidLoad()
     //super.viewDidAppear(true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        if Auth.auth().currentUser != nil {
            print("currentuser")
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("current user is not nill")
            //dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            print("print current")
        }
    }
    @IBAction func signInWhenFBBtnPressed(_ sender: Any) {
    }
    
    @IBAction func signInWhenGoogleBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func signInWhenEmailBtnWasPressed(_ sender: Any) {
       // let loginVC = (storyboard?.instantiateViewController(withIdentifier: "LoginVC"))!
       // present(loginVC, animated: true, completion: nil)
        let vc = (storyboard?.instantiateViewController(withIdentifier: "LoginVC"))!
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
