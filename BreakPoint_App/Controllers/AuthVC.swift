//
//  AuthVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInWhenFBBtnPressed(_ sender: Any) {
    }
    
    @IBAction func signInWhenGoogleBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func signInWhenEmailBtnWasPressed(_ sender: Any) {
        let loginVC = (storyboard?.instantiateViewController(withIdentifier: "LoginVC"))!
        present(loginVC, animated: true, completion: nil)
    }
    
}
