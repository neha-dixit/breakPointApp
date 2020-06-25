//
//  AddGroupVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/20/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
class AddGroupVC: UIViewController {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleTxtfield: InsetTxtField!
    @IBOutlet weak var descriptionTxtfield: InsetTxtField!
    @IBOutlet weak var emailSearchTxtfield: InsetTxtField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var emailArray = [String]()
    var choosenArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxtfield.delegate = self
        emailSearchTxtfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
        
    }
    //func for emailssearchfield
    @objc func textfieldDidChange(){
        if emailSearchTxtfield.text == "" {
            emailArray = []
            tableView.reloadData()
        }
        else {
            DataService.instance.getEmail(forSeacrhQuery: emailSearchTxtfield.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTxtfield.text != "" && descriptionTxtfield.text != "" {
            DataService.instance.getIds(forUsernames: choosenArray) { (idsArray) in
                var userIds = idsArray
                print("userids", userIds, userIds.count)
                userIds.append(Auth.auth().currentUser!.uid)
                print(userIds.count)
                DataService.instance.createGroup(withTitile: self.titleTxtfield.text!, andDescription: self.descriptionTxtfield.text!, foruserIds: userIds) { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group couldnot be created, Please try to create one")
                    }
                }
            }
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension AddGroupVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        if choosenArray.contains(emailArray[indexPath.row]){
        cell.ConfigureCell(profileImage: profileImage!, email: emailArray[indexPath.row] as! String, isSelected: true)
        } else { cell.ConfigureCell(profileImage: profileImage!, email: emailArray[indexPath.row] as! String, isSelected: false) }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !choosenArray.contains(cell.emailLbl.text!){
            choosenArray.append(cell.emailLbl.text!)
            //add these selected or searched email to our label
            groupMemberLbl.text = choosenArray.joined(separator: ",")
            doneBtn.isHidden = false
        }else {
            choosenArray = choosenArray.filter({$0 != cell.emailLbl.text!})
            if choosenArray.count >= 1 {
                groupMemberLbl.text = choosenArray.joined(separator: ",")
            } else {
                groupMemberLbl.text = "add People to your group"
                doneBtn.isHidden = true
            }
        }
    }
}
extension AddGroupVC: UITextFieldDelegate{
    
}
