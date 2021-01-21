//
//  User.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/2/1399 AP.
//

import Foundation

struct User {
    
    let email: String
    let fullname: String
    let profileImageUrl: String
    let uid: String
    let username: String
    
    init(dictionaty: [String: Any]) {
        self.email = dictionaty["email"] as? String ?? ""
        self.fullname = dictionaty["fullname"] as? String ?? ""
        self.profileImageUrl = dictionaty["profileImageUrl"] as? String ?? ""
        self.uid = dictionaty["uid"] as? String ?? ""
        self.username = dictionaty["username"] as? String ?? ""
    }
    
}
