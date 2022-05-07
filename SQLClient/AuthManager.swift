//
//  AuthManager.swift
//  SQLClient
//
//  Created by Yujie Zhang on 4/28/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation

class AuthManager{
    static let shared = AuthManager()
    private init(){
        
    }
    var currentUser: User?
    
    var isSignedIn: Bool = false
    
    func registerNewUser(email: String, password: String) -> Bool{//return true if signed in
        //TODO: insert new record to users table, return 1 if success executed
        return true
    }
    
    func loginExistingUser(email: String, password: String) -> Bool{// return true if logged in
        //TODO: search for this tuple, if exist return the useremail as current user id, else return "No user"
        //TODO: set var current user to the return id or nil
        return true
    }
    
    
    
    
}
