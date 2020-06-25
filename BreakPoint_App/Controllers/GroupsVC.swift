//
//  GroupsVC.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/23/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import UIKit
import Firebase
class GroupsVC: UIViewController {
    
    @IBOutlet weak var groupsTableView: UITableView!
    var groupsArray = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("hi i am in gropusVC viewdidappear")
        DataService.instance.REF_GROUPS.observe(.value) { (Snapshot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                //print("view did appear", self.groupsArray)
                self.groupsTableView.reloadData()
            }
        }
    }
    
}
extension GroupsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(groupsArray.count)
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell()}
        let group = groupsArray[indexPath.row]
        cell.configureCell(groupTitle: group.groupTitle, groupDescription: group.groupDescription, MemberCount: group.memberCount)
        print(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else {  return }
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        //present(groupFeedVC, animated: true, completion: nil)
        presentDetail(groupFeedVC)
    }
    
}
