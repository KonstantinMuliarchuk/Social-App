//
//  DataService.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import Firebase

let DB_REF = Database.database().reference()

class DataService {
    
    static var ds = DataService()
    
    private var _REF_BASE = DB_REF
    private var _REF_USERS = DB_REF.child("users")
    private var _REF_POSTS = DB_REF.child("posts")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    func createFirebaseDBUser (uid: String, userData: Dictionary<String,String>) {
        _REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
