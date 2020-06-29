//
//  AuthService.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/10/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    func registerUser(withEmail email: String, andPassword password: String,  userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else { userCreationComplete(false, error); return }
        
            let userData = ["provider": user.user.providerID, "email": user.user.email, "ProfileImageUrl": ""]
            DataService.instance.createDBUser(uid: user.user.uid, userData: userData)
        }
    }
    func loginUser(email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                    loginComplete(false, error)
                    return }
            loginComplete(true, nil)
        }
        
    }
    
}
