//
//  DataServices.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/9/20.
//  Copyright © 2020 Dixit. All rights reserved.
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
    
    //public variables
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
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    func uploadPost( withmessage message: String, forUID uid: String, withGroupKey: String?, sendComplete: @escaping(_ status: Bool)-> ()){
        if withGroupKey != nil {
            //send to group refernce
        }
        else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
}
