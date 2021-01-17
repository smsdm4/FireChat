//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/28/1399 AP.
//

import Foundation

struct LoginViewModel {
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
    
}
