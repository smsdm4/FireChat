//
//  Service.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/2/1399 AP.
//
import Firebase

struct Service {
    static let shared = Service()
     
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionaty: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
}

