//
//  AddGroupVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/20/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit

class AddGroupVC: UIViewController {
    
    @IBOutlet weak var titleTxtfield: InsetTxtField!
    @IBOutlet weak var descriptionTxtfield: InsetTxtField!
    @IBOutlet weak var emailSearchTxtfield: InsetTxtField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var emailArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxtfield.delegate = self
        emailSearchTxtfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        
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
        cell.ConfigureCell(profileImage: profileImage!, email: emailArray[indexPath.row] as! String, isSelected: true)
        return cell
    }
    
    
}
extension AddGroupVC: UITextFieldDelegate{
    
}
