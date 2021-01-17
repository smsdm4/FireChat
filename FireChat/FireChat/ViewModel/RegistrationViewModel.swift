//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/28/1399 AP.
//

import Foundation

struct RegistrationViewModel {
    
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
    
}
