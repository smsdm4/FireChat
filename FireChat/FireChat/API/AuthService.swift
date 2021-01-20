//
//  AuthService.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/1/1399 AP.
//

import UIKit
import Firebase

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    // MARK: - Login
    func logUserIn(withEmail email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    // MARK: - SignUp
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let fileName = UIDevice.current.identifierForVendor!.uuidString //NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImgUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (response, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uid = response?.user.uid else { return }
                    
                    let data = ["email": credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImgUrl,
                                "uid": uid,
                                "username": credentials.username] as [String: Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    
                }
            }
        }
    }
    
}


