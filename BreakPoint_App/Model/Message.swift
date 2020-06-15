//
//  Message.swift
//  BreakPoint_App
//
//  Created by Saurabh Dixit on 6/15/20.
//  Copyright © 2020 Dixit. All rights reserved.
//

import Foundation
class Message {
    private var _content: String
    private var _senderId: String
    
    public var content: String {
        return _content
    }
    public var senderId: String {
        return _senderId
    }
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
