//
//  MeVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/12/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MeVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    let imagepicker = UIImagePickerController()
   var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        //profileView.delegate = self
        imagepicker.delegate = self
        //imagepicker.isEditing = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        //print("MEVC view will appear")
    self.emailLbl.text = Auth.auth().currentUser?.email
        
    }
    
    
    
    @IBAction func uploadImgeBtnWasPressed(_ sender: Any) {
        imagepicker.allowsEditing = false
        //imagepicker.sourceType = .camera
        imagepicker.sourceType = .savedPhotosAlbum
        imagepicker.sourceType = .photoLibrary
        //imagepicker.isEditing = true
        present(imagepicker, animated: true, completion: nil)
        
        guard let imageSelected = self.image as? UIImage else { return }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
        if profileView.image != nil {
             let storageRef = Storage.storage().reference(forURL: "gs://breakpoint-nd.appspot.com")
            let storageProfileRef = storageRef.child("ProfileImage").child(Auth.auth().currentUser!.uid)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            storageProfileRef.putData(imageData, metadata: metadata) { (StorageMetaData, error) in
                if error != nil {
                    print(error.self)
                    return
                }
                storageProfileRef.downloadURL { (url, error) in
                                       if let metaimageurl = url?.absoluteString
                                       {
                                        DataService.instance.uploadImageURl(imageurl: metaimageurl)
                                          print("metaimageurl", metaimageurl)
                                       }
                }
            }
            
        }
    }
    
    
    @IBAction func signOutBtnWasPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "logout", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                authVC?.modalPresentationStyle = .fullScreen
                self.present(authVC!, animated: true, completion: nil)
            } catch { print(error)
                
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
}
extension MeVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = pickedImage
            profileView.contentMode = .scaleAspectFill
            profileView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
    
   


