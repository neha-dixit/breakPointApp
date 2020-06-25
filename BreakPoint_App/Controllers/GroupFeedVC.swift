//
//  GroupFeedVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/23/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupNAmeLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var msgView: UIView!
    
    @IBOutlet weak var msgTxtField: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group){
        self.group = group
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
       // msgView.bindToKeyboard()
        //tableView.bindToKeyboard()
        //msgView.bindToKeyboard()
        IQKeyboardManager.shared.enable = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        groupNAmeLbl.text = group?.groupTitle
        DataService.instance.getEmailsfor(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
        DataService.instance.getAllMessagesFor(DesiredGroup: self.group!) { (returnedGroupMessages) in
            self.groupMessages = returnedGroupMessages
            self.tableView.reloadData()
            
            
            if self.groupMessages.count > 0 {
                self.tableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
            }
        }
    }
    }

    @IBAction func backBtnWasPreesed(_ sender: Any) {
        dismissDetail()
    }
    
    
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    
    if msgTxtField.text != "" {
            msgTxtField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: msgTxtField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (complete) in
                if complete {
                    self.msgTxtField.text = ""
                    self.msgTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
            
        }
    }
    
}
extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(groupMessages)
    print("i am inside tableview")
    return groupMessages.count
}
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("i m cell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell
            else { print("Hi inside")
            return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
    
}
