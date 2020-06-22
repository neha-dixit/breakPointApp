//
//  LoginVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: InsetTxtField!
    
    @IBOutlet weak var pwdField: InsetTxtField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        pwdField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && pwdField.text != nil {
            AuthService.instance.loginUser(email: emailField.text!, andPassword: pwdField.text!) { (success, loginError) in
                if success {
                    print("login sucessfully")
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    //print(loginError!.localizedDescription)
                
                    AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.pwdField.text!) { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(email: self.emailField.text!, andPassword: self.pwdField.text!) { (success, nil) in
                             
                            self.dismiss(animated: true, completion: nil)
                        print("Successfully registered user")
                    }
                    }
                    else {
                        //when fail to register user
                        print(String(describing: registrationError?.localizedDescription))
                    }
                }
            }
            }
        }
    }
    
    
    @IBAction func closeBtnWasPRessed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension LoginVC: UITextFieldDelegate{
    
}
