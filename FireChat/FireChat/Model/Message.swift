//
//  Message.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/6/1399 AP.
//

import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    let isFromCurrentUser: Bool
    
    init(dictionaty: [String: Any]) {
        self.text = dictionaty["text"] as? String ?? ""
        self.toId = dictionaty["toId"] as? String ?? ""
        self.fromId = dictionaty["fromId"] as? String ?? ""
        self.timestamp = dictionaty["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}
