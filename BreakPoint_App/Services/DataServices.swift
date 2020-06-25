//
//  DataService.swift
//  breakpoint
//
//  Created by Caleb Stultz on 7/22/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                //print(user)
                if user.key == uid {
                    //print("hi username ",user.childSnapshot(forPath: "email"))
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            // send to groups ref
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    func getAllMessagesFor(DesiredGroup: Group, handler: @escaping(_ messageArray: [Message])->()){
        var groupMsgArray = [Message]()
        REF_GROUPS.child(DesiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as? String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as? String
                let groupMessage = Message(content: content!, senderId: senderId!)
                groupMsgArray.append(groupMessage)
            }
            handler(groupMsgArray)
        }
    }
    
    func getEmail(forSeacrhQuery query:String, handler:@escaping(_ emailArry:[String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as? String
                if email?.contains(query) == true && email != Auth.auth().currentUser!.email {
                    emailArray.append(email!)
                }
            }
            handler(emailArray)
        }
    }
    func getIds(forUsernames usernames:[String], handler: @escaping (_ uiDArray: [String]) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            var iDArray = [String]()
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as? String
                if usernames.contains(email!) {
                    iDArray.append(user.key)
                    
                }
            }
            handler(iDArray)
        }
    }
    func createGroup(withTitile title: String, andDescription description: String, foruserIds ids:[String], handler: @escaping (_ groupCreated: Bool)-> ()){
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping (_ groupsArray : [Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as? [String]
                if (memberArray!.contains((Auth.auth().currentUser?.uid)!)) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as? String
                    let group = Group(title: title, description: description!, key: group.key, memberCount: memberArray!.count, Members: memberArray!)
                    groupsArray.append(group)
                    print("groupsArray", groupsArray)
                }
                
            }
            handler(groupsArray)
        }
    }
    
    func getEmailsfor(group: Group, handler: @escaping (_ emailArray: [String])-> ()){
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if group.members.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
}















