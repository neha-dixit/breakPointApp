//
//  AuthVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKLoginKit
class AuthVC: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
          if let error = error {
            print(error.localizedDescription)
            return
          }
          // ...
        }
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDidLoad()
     //super.viewDidAppear(true)
        //if let token = AccessToken.current,
            //!token.isExpired {
            // User is logged in, do work such as go to next view controller.
       // }
       // loginButton.permissions = ["public_profile", "email"]
        let loginButton = FBLoginButton()
              loginButton.center = view.center
              view.addSubview(loginButton)
        //let loginButton = FBLoginButton()
        loginButton.delegate = self
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
       
        //calls the facebook login function that is defined in the fbMuser   class
        loginFaceBookuser()
            self.dismiss(animated: true, completion: nil)
    }
        func loginFaceBookuser(){
            let fbLoginManager : LoginManager = LoginManager()
                fbLoginManager.logIn(permissions: ["email"], from: AuthVC() )
            { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : LoginManagerLoginResult = result!
                    // if user cancel the login
                    if (result?.isCancelled)!
                    {
                        return
                    }
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        //self.getFBUserData()
                        //MARK: perform navigation segue to profile page
                                           let homeView = self.storyboard?.instantiateViewController(withIdentifier: "meVC") as! MeVC
                                           self.navigationController?.pushViewController(homeView, animated: true)
                        // fbLoginManager.logOut()

                    }
                }
            }
        }


            //this function helps me get the user data from facebook then i then i store the all the data into firebase under my User collection
    /*
        func getFBUserData()
            {
               if((AccessToken.current) != nil)
               {
                  GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler:
                           { (connection, result, error) -> Void in

                                if (error == nil)
                                {
                                    if let data = result as? NSDictionary
                                    {
                                        let firstName  = data.object(forKey: "first_name") as? String
                                        let lastName  = data.object(forKey: "last_name") as? String
                                        let name = data.object(forKey: "name") as? String
                                        let id = data.object(forKey: "id") as? String
                                        //what we need to do next is make a document path in the users collection for full address and purchase itemids
                                       if let email = data.object(forKey: "email") as? String
                                       {
                                        //MARK: TO DO IF THE USERS ALREADY EXIST IN THE FIRESTORE SERVER  DO NOT PERFORM SET DATA IT WILL OVERWRITE PREVIOUS DATA! NEED TO WRITE CODE TO DETECT THIS
                                        FirebaseReferece(.User).document(id!).setData(data as! [String : Any]) //saves all the information under user the document id is id
                                        saveit()

                                       }else{
                                        print("We are unable to access Facebook account details, please use other sign in methods.")
                                           }
                                    }
                                }
                           })
                       }

                   }
 */
        
        
        
        
        
        
        
        
        
        
        
        
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
