//
//  Group.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/23/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import Foundation
class Group {
    
    private var _groupTitle: String
    private var _groupDescription: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    //public variables
    var groupTitle: String {
        return _groupTitle
    }
    var groupDescription:String{
        return _groupDescription
    }
    var key: String {
        return _key
    }
    var memberCount: Int {
        return _memberCount
    }
    var members: [String] {
        return _members
    }
    init(title: String, description: String, key: String, memberCount: Int, Members: [String]) {
        self._groupTitle = title
        self._groupDescription = description
        self._key = key
        self._memberCount = memberCount
        self._members = Members
        
    }
}
